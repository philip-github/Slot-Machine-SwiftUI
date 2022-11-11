//
//  InfoView.swift
//  Slot Machine
//
//  Created by Philip Al-Twal on 10/28/22.
//

import SwiftUI

struct InfoView: View {
    //MARK: - PROPERTIES
    
    @Environment(\.dismiss) var dismiss
    
    //MARK: - BODY
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            //MARK: - LOGO VIEW
            LogoView()
            Spacer()
            //MARK: - FORM
            Form {
                Section("About the application") {
                    FormRowView(firstItem: "Application",
                                secondItem: "Slot Machine")
                    FormRowView(firstItem: "Platforms",
                                secondItem: "iPhone, iPad, iMac")
                    FormRowView(firstItem: "Developer",
                                secondItem: "Philip Al-Twal")
                    FormRowView(firstItem: "Designer",
                                secondItem: "Robert Petras")
                    FormRowView(firstItem: "Music",
                                secondItem: "Dan Lebowitz")
                    FormRowView(firstItem: "Website",
                                secondItem: "swiftuimasterclass.com")
                    FormRowView(firstItem: "Copyright",
                                secondItem: "© 2022 all rights reserved.")
                    FormRowView(firstItem: "Version",
                                secondItem: "1.0.0")
                }//: SECTION
            }//: FORM
            .font(.system(.body, design: .rounded))
        }//: VSTACK
        .padding(.top, 40)
        .overlay(
            Button(action: {
                dismiss()
                audioPlayer?.stop()
            }, label: {
                Image(systemName: "xmark.circle")
                    .font(.title)
            })
            .padding(.top, 30)
            .padding(.trailing, 20)
            .accentColor(.secondary)
            ,alignment: .topTrailing
        )
        .onAppear {
            playSound(sound: "background-music", type: "mp3")
        }
    }//: BODY
}

//MARK: - FORM ROW VIEW

struct FormRowView: View {
    var firstItem: String
    var secondItem: String
    var body: some View {
        HStack {
            Text(firstItem)
                .foregroundColor(.gray)
            Spacer()
            Text(secondItem)
        }//: HSTACK
    }
}


//MARK: - PREVIEW

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}


