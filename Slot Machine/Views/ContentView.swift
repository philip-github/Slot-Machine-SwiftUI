//
//  ContentView.swift
//  Slot Machine
//
//  Created by Philip Al-Twal on 10/28/22.
//

import SwiftUI

struct ContentView: View {
    //MARK: - PROPERTIES
    let symbols: [String] = ["gfx-bell",
                             "gfx-cherry",
                             "gfx-coin",
                             "gfx-grape",
                             "gfx-seven",
                             "gfx-strawberry"]
    let haptics = UINotificationFeedbackGenerator()
    @State private var highScore: Int = UserDefaults.standard.integer(forKey: "HighScore")
    @State private var coins: Int = 100
    @State private var betAmount: Int = 10
    @State private var reels: Array = [0, 1, 2]
    @State private var showingInfoView: Bool = false
    @State private var isActiveBet20: Bool = false
    @State private var isActiveBet10: Bool = true
    @State private var showingModal: Bool = false
    @State private var animatingSymbol: Bool = false
    @State private var animatingModal: Bool = false

    
    
    //MARK: - FUNCTIONS
    
    
    // SPIN THE REELS
    func spinReels(){
        reels = reels.map { _ in Int.random(in: 0...symbols.count - 1) }
        playSound(sound: "spin", type: "mp3")
        haptics.notificationOccurred(.success)
    }
    
    // CHECK WINNING
    func checkWinning()  {
        if Set(reels).count == 1{
            playerWins()
            if coins > highScore {
                newHighScore()
            }else{
                playSound(sound: "win", type: "mp3")
            }
        }else{
            playerLoses()
        }
    }
    
    func playerWins() {
        coins += (betAmount * 10)
    }
    
    func newHighScore() {
        highScore = coins
        UserDefaults.standard.set(highScore, forKey: "HighScore")
        playSound(sound: "high-score", type: "mp3")
    }
    
    func playerLoses() {
        coins -= betAmount
    }
    
    func activateBet20() {
        betAmount = 20
        isActiveBet20 = true
        isActiveBet10 = false
        playSound(sound: "casino-chips", type: "mp3")
        haptics.notificationOccurred(.success)
    }
    
    func activateBet10(){
        betAmount = 10
        isActiveBet20 = false
        isActiveBet10 = true
        playSound(sound: "casino-chips", type: "mp3")
        haptics.notificationOccurred(.success)
    }
    
    func isGameOver() {
        if coins <= 0 {
            // SHOW MODAL WINDOW
            showingModal = true
            playSound(sound: "game-over", type: "mp3")
        }
    }
    
    func resetGame() {
        UserDefaults.standard.set(0, forKey: "HighScore")
        highScore = 0
        coins = 100
        activateBet10()
        playSound(sound: "chimeup", type: "mp3")
    }
    
    //MARK: - BODY
    
    var body: some View {
        ZStack {
            //MARK: - BACKGROUND
            LinearGradient(colors: [Color("ColorPink"),
                                    Color("ColorPurple")],
                           startPoint: .top,
                           endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            //MARK: - INTERFACE
            VStack(alignment: .center, spacing: 5) {
                
                //MARK: - HEADER
                LogoView()
                Spacer()
                
                //MARK: - SCORE
                HStack {
                    HStack {
                        Text("Your\nCoins".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.trailing)
                        
                        Text("\(coins)")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                    }//: HSTACK
                    .modifier(ScoreContainerModifier())
                    
                    Spacer()
                    
                    HStack {
                        Text("\(highScore)")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                        
                        Text("High\nScore".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.leading)
                        
                    }//: HSTACK
                    .modifier(ScoreContainerModifier())
                }//: HSTACK
                
                //MARK: - SLOT MACHINE
                
                VStack(alignment: .center, spacing: 0) {
                    //MARK: - REEL #1
                    ZStack{
                        ReelView()
                        Image(symbols[reels[0]])
                            .resizable()
                            .modifier(ImageModifier())
                            .opacity(animatingSymbol ? 1 : 0)
                            .offset(y: animatingSymbol ? 0 : -50)
                            .animation(.easeOut(duration: Double.random(in: 0.5...0.7)), value: animatingSymbol)
                            .onAppear {
                                animatingSymbol.toggle()
                                playSound(sound: "riseup", type: "mp3")
                            }
                    }//: ZSTACK
                    
                    HStack(alignment: .center, spacing: 0) {
                        //MARK: - REEL #2
                        
                        ZStack{
                            ReelView()
                            Image(symbols[reels[1]])
                                .resizable()
                                .modifier(ImageModifier())
                                .opacity(animatingSymbol ? 1 : 0)
                                .offset(y: animatingSymbol ? 0 : -50)
                                .animation(.easeOut(
                                    duration: Double.random(
                                        in: 0.7...0.9)),
                                           value: animatingSymbol)
                                .onAppear {
                                    animatingSymbol.toggle()
                                }
                        }//: ZSTACK
                        
                        Spacer()
                        //MARK: - REEL #3
                        ZStack{
                            ReelView()
                            Image(symbols[reels[2]])
                                .resizable()
                                .modifier(ImageModifier())
                                .opacity(animatingSymbol ? 1 : 0)
                                .offset(y: animatingSymbol ? 0 : -50)
                                .animation(.easeOut(
                                    duration: Double.random(
                                        in: 0.9...1.1)),
                                           value: animatingSymbol)
                                .onAppear {
                                    animatingSymbol.toggle()
                                }
                        }//: ZSTACK
                    }//: HSTACK
                    .frame(maxWidth: 500)
                    
                    //MARK: - SPIN BUTTON
                    Button {
                        withAnimation {
                            animatingSymbol = false
                        }
                        spinReels()
                        withAnimation {
                            animatingSymbol = true
                        }
                        checkWinning()
                        isGameOver()
                    } label: {
                        Image("gfx-spin")
                            .renderingMode(.original)
                            .resizable()
                            .modifier(ImageModifier())
                    }
                    
                    
                }//: VSTACK / SLOT MACHINE
                .layoutPriority(2)
                
                //MARK: - FOOTER
                Spacer()
                HStack {
                    //MARK: - BET 20
                    HStack(alignment: .center, spacing: 10) {
                        Button {
                            activateBet20()
                            
                        } label: {
                            Text("20")
                                .fontWeight(.heavy)
                                .foregroundColor(isActiveBet20 ? .yellow : .white)
                                .modifier(BetNumberModifier())
                        }//: BUTTON
                        .modifier(BetCapsuleModifier())
                        
                        Image("gfx-casino-chips")
                            .resizable()
                            .offset(x: isActiveBet20 ? 0 : 20)
                            .opacity(isActiveBet20 ? 1 : 0)
                            .modifier(CasinoChipsModifier())
                    }//: HSTACK
                    Spacer()
                    //MARK: - BET 10
                    HStack(alignment: .center, spacing: 10) {
                        Image("gfx-casino-chips")
                            .resizable()
                            .offset(x: isActiveBet10 ? 0 : -20)
                            .opacity(isActiveBet10 ? 1 : 0)
                            .modifier(CasinoChipsModifier())
                        
                        Button {
                            activateBet10()
                        } label: {
                            Text("10")
                                .fontWeight(.heavy)
                                .foregroundColor(isActiveBet10 ? .yellow : .white)
                                .modifier(BetNumberModifier())
                        }//: BUTTON
                        .modifier(BetCapsuleModifier())
                    }//: HSTACK
                }//: HSTACK
            }//: VSTACK
            //MARK: - BUTTONS
            .overlay(
                // RESET
                Button(action: {
                    resetGame()
                }, label: {
                    Image(systemName: "arrow.2.circlepath.circle")
                })
                .modifier(ButtonModifier())
                ,alignment: .topLeading
            )//: OVERLAY
            .overlay(
                // INFO
                Button(action: {
                    showingInfoView.toggle()
                }, label: {
                    Image(systemName: "info.circle")
                })
                .modifier(ButtonModifier())
                ,alignment: .topTrailing
            )//: OVERLAY
            .padding()
            .frame(maxWidth: 720)
            .blur(radius: showingModal ? 5 : 0, opaque: false)
            //MARK: - POP UP
            if $showingModal.wrappedValue {
                ZStack{
                    Color("ColorTransparentBlack")
                        .edgesIgnoringSafeArea(.all)
                    
                    // MODAL
                    VStack(spacing: 0) {
                        Text("GAME OVER")
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.heavy)
                            .padding()
                            .frame(minWidth: 0,
                                   maxWidth: .infinity)
                            .background(Color("ColorPink"))
                            .foregroundColor(.white)
                            .clipped(antialiased: true)
                        Spacer()
                        VStack(alignment: .center, spacing: 16) {
                            Image("gfx-seven-reel")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 72)
                            
                            Text("Bad Luck! You lost all of the coins. \nLet's play again!")
                                .font(.system(.body, design: .rounded))
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.gray)
                                .layoutPriority(1)
                            
                            Button {
                                showingModal = false
                                animatingModal = false
                                activateBet10()
                                coins = 100
                            } label: {
                                Text("New Game".uppercased())
                                    .font(.system(.body, design: .rounded))
                                    .fontWeight(.semibold)
                                    .accentColor(Color("ColorPink"))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .frame(minWidth: 128)
                                    .background(
                                        Capsule()
                                            .stroke(lineWidth: 1.75)
                                            .foregroundColor(Color("ColorPink"))
                                    )
                                
                            }//: BUTTON
                        }//: VSTACK
                        Spacer()
                    }//: VSTACK
                    .frame(minWidth: 280,
                           idealWidth: 280,
                           maxWidth: 320,
                           minHeight: 260,
                           idealHeight: 280,
                           maxHeight: 320,
                           alignment: .center)
                    .cornerRadius(20)
                    .background(
                        Color.white
                            .cornerRadius(20)
                            .shadow(color: Color("ColorTransparentBalck"),
                                    radius: 6,
                                    x: 0,
                                    y: 8)
                    )
                    .opacity($animatingModal.wrappedValue ? 1 : 0)
                    .offset(y: $animatingModal.wrappedValue ? 0 : -100 )
                    .animation(Animation.spring(response: 0.6,
                                                dampingFraction: 1.0,
                                                blendDuration: 1.0),
                               value: animatingModal)
                    .onAppear {
                        animatingModal = true
                    }
                }//: ZSTACK
            }//: CONDITIONAL
        }//: ZSTACK
        .sheet(isPresented: $showingInfoView) {
            InfoView()
        }
    }//: BODY
}

//MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
