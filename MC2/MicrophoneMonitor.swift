//
//  MicrophoneMonitor.swift
//  MC2
//
//  Created by Kevin Jonathan on 07/06/21.
//

import Foundation
import AVFoundation
import Speech

class MicrophoneMonitor: ObservableObject {
    
    //wpm
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    
    private var audioRecorder: AVAudioRecorder?
    
    private var timer: Timer?
    var counter = 0
    
    private var secondTimer: Timer?
    
    //visualizer
    private var currentSample: Int
    private let numberOfSamples: Int
    
    var wpm: Double = 0
    var words : [String] = []
    var isRecording: Bool = false
    
    @Published public var soundSamples: [Float]
    
    init(numberOfSamples: Int) {
        self.numberOfSamples = numberOfSamples
        self.soundSamples = [Float](repeating: .zero, count: numberOfSamples)
        self.currentSample = 0
    }
    
    func recordingButtonOnClick() {
        let audioSession = AVAudioSession.sharedInstance()
        if audioSession.recordPermission != .granted {
            audioSession.requestRecordPermission { (isGranted) in
                if !isGranted {
                    fatalError("You must allow audio recording for this demo to work")
                }
            }
        }
        
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        let recorderSettings: [String:Any] = [
            AVFormatIDKey: NSNumber(value: kAudioFormatAppleLossless),
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue
        ]
        
        // 5
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: recorderSettings)
            try audioSession.setCategory(.playAndRecord, mode: .default, options: [])
            
            startMonitoring()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func pauseButtonOnClick() {
        audioRecorder!.pause()
        audioEngine.pause()
    }
    
    func resumeButtonOnClick() throws {
        audioRecorder!.record()
        audioEngine.prepare()
        try audioEngine.start()
    }
    
    func finishRecordOnClick() {
        audioRecorder!.isMeteringEnabled = false
        audioRecorder!.stop()
        timer?.invalidate()
        secondTimer?.invalidate()
    }
    
    public func startRecognizing() throws {
        // Cancel the previous task if it's running.
        recognitionTask?.cancel()
        self.recognitionTask = nil
        
        // Configure the audio session for the app.
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        let inputNode = audioEngine.inputNode

        // Create and configure the speech recognition request.
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to create a SFSpeechAudioBufferRecognitionRequest object") }
        recognitionRequest.shouldReportPartialResults = true
        
        // Keep speech recognition data on device
        if #available(iOS 13, *) {
            recognitionRequest.requiresOnDeviceRecognition = false
        }
        
        // Create a recognition task for the speech recognition session.
        // Keep a reference to the task so that it can be canceled.
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { [self] result, error in
            var isFinal = false
            
            if let result = result {
                // Update the text view with the results.
                isFinal = result.isFinal
                //print(result.bestTranscription.formattedString)
                let components = result.bestTranscription.formattedString.components(separatedBy: .whitespacesAndNewlines)
                words = components.filter { !$0.isEmpty }
                //print(words.count)
                
            }
            
            if error != nil || isFinal {
                // Stop recognizing speech if there is a problem.
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)

                self.recognitionRequest = nil
                self.recognitionTask = nil
            }
        }

        // Configure the microphone input.
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        try audioEngine.start()
    }

    
    // 6
    private func startMonitoring() {
        isRecording = true
        audioRecorder!.isMeteringEnabled = true
        audioRecorder!.record()
        do {
            try startRecognizing()
        } catch {
            print("Error")
        }
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (timer) in
            self.audioRecorder!.updateMeters()
            self.soundSamples[self.currentSample] = self.audioRecorder!.averagePower(forChannel: 0)
            self.currentSample = (self.currentSample + 1) % self.numberOfSamples
        })
        self.secondTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [self] (timer) in
            self.counter += 1
            //print(self.counter)
            
            //print(words.count)
            if((words.count) > 0) {
                self.wpm = (Double(words.count) / Double(self.counter)) * 60
            }
            print(wpm)
        })
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
    
    // 8
    deinit {
        timer?.invalidate()
        secondTimer?.invalidate()
    }
}
