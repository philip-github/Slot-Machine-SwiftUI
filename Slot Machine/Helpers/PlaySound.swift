//
//  PlaySound.swift
//  Slot Machine
//
//  Created by Philip Al-Twal on 10/31/22.
//

import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
    if let urlPath = Bundle.main.url(forResource: sound, withExtension: type) {
        do{
            let data = try Data(contentsOf: urlPath)
            audioPlayer = try AVAudioPlayer(data: data)
            audioPlayer?.play()
        }catch{
            print("ERROR [      ] Failed to play sound!")
        }//: DO/CATCH
    }
}
