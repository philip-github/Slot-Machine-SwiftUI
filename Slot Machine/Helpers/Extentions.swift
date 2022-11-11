//
//  Extentions.swift
//  Slot Machine
//
//  Created by Philip Al-Twal on 10/28/22.
//

import SwiftUI


extension Text {
    
    //MARK: - SCORE LABEL STYLE
    
    func scoreLabelStyle() -> Text {
        self
            .foregroundColor(.white)
            .font(.system(size: 10,
                          weight: .bold,
                          design: .rounded))
    }
    
    //MARK: - SCORE NUMBER STYLE
    
    func scoreNumberStyle() -> Text {
        self
            .foregroundColor(.white)
            .font(.system(.title, design: .rounded))
            .fontWeight(.heavy)
    }
}
