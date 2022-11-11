//
//  Modifiers.swift
//  Slot Machine
//
//  Created by Philip Al-Twal on 10/28/22.
//


import SwiftUI

//MARK: - SHADOW MODIFIER

struct ShadowModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color("ColorTransparentBlack"),
                    radius: 0,
                    x: 0,
                    y: 6)
    }
}

//MARK: - BUTTON MODIFIER

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .accentColor(.white)
    }
}

//MARK: - SCORE NUMBER MODIFIER

struct ScoreNumberModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color("ColorTransparentBlack"),
                    radius: 0,
                    x: 0,
                    y: 3)
            .layoutPriority(1)
    }
}

//MARK: - SCORE CONTAINER MODIFIER

struct ScoreContainerModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 4)
            .padding(.horizontal, 16)
            .frame(minWidth: 128)
            .background(
                Capsule()
                    .foregroundColor(Color("ColorTransparentBlack"))
            )
    }
}

//MARK: - IMAGE MODIFIER

struct ImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .frame(minWidth: 140,
                   idealWidth: 200,
                   maxWidth: 220,
                   minHeight: 130,
                   idealHeight: 190,
                   maxHeight: 200,
                   alignment: .center)
            .modifier(ShadowModifier())
    }
}

//MARK: - BET NUMBER MODIFIER

struct BetNumberModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.title, design: .rounded))
            .padding(.vertical, 5)
            .frame(width: 90)
            .shadow(color: Color("ColorTransparentBalck"),
                    radius: 0,
                    x: 0,
                    y: 3)
    }
}


//MARK: - BET CAPSULE MODIFIER

struct BetCapsuleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                Capsule()
                    .fill(LinearGradient(colors:
                                            [Color("ColorPink"),
                                             Color("ColorPurple")],
                                         startPoint: .top,
                                         endPoint: .bottom))
            )//: BACKGROUND
            .padding(3)
            .background(
                Capsule()
                    .fill(LinearGradient(colors:
                                            [Color("ColorPink"),
                                             Color("ColorPurple")],
                                         startPoint: .bottom,
                                         endPoint: .top))
                    .modifier(ShadowModifier())
            )//: BACKGROUND
    }
}

//MARK: - CASINO CHIPS MODIFIER



struct CasinoChipsModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .frame(height: 64)
            .animation(.default)
            .modifier(ShadowModifier())
    }
}
