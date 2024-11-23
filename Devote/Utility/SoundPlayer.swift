//
//  SoundPlayer.swift
//  Devote
//
//  Created by Jozek Andrzej Hajduk Sanchez on 22/11/24.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: AudioSoundsEnum, type: AudioSoundsTypeEnum = AudioSoundsTypeEnum.mp3) {
    if let path = Bundle.main.path(forResource: sound.rawValue, ofType: type.rawValue) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("Could not find and play the sound file")
        }
    }
}
