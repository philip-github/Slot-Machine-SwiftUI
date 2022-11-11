//
//  ReelView.swift
//  Slot Machine
//
//  Created by Philip Al-Twal on 10/28/22.
//

import SwiftUI

struct ReelView: View {
    //MARK: - PROPERTIES
    
    //MARK: - BODY
    
    var body: some View {
        Image("gfx-reel")
            .resizable()
            .modifier(ImageModifier())
    }//: BODY
}

//MARK: - PREVIEW

struct ReelView_Previews: PreviewProvider {
    static var previews: some View {
        ReelView()
            .previewLayout(.fixed(width: 220, height: 220))
    }
}
