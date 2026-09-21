//
//  AudioPlayer.swift
//  MC2
//
//  Created by Kevin Jonathan on 15/06/21.
//

import Foundation
import AVFoundation

class AudioPlayer: ObservableObject {
    
    private var audioPlayer: AVAudioPlayer!
    
    func replayButtonOnClick() {
        prepareAudioPlayer()
        audioPlayer.play()
    }
    
    func stopReplayOnClick() {
        audioPlayer.stop()
    }
    
    func prepareAudioPlayer() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: getFileURL())
            print(getFileURL())
            audioPlayer.volume = 1.0
        } catch {
            print("Preparing Audio Player Failed!!")
            audioPlayer = nil
        }
    }
    
    func getFileURL() -> URL {
        let documentPath = getDocumentsDirectory()
        let audioFileURL = documentPath.appendingPathComponent("recording.m4a")
        return audioFileURL
    }
    
    func getDocumentsDirectory() -> URL {
        let fileManager = FileManager.default
        let paths = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
