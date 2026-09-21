//
//  Recording.swift
//  MC2
//
//  Created by Angelica Roseanne on 14/06/21.
//

import Foundation

public struct RecordingLog{
    var name:String
    var date:String
    
//    var duration:String
    
    //0 : presentation, 1 : convo, 2 : entertainment
    var mode:Int
    var isVideo:Bool
    
    var pace:Int
    
    var tone:String
    
    var fillers:String
}

public var recordingLog:[RecordingLog] = [
    
    //present
    RecordingLog(name: "Student Reps Campaign-2", date: "Jun 05 2021 | 09.41 AM", mode: 0, isVideo: true, pace: 110, tone: "Dynamic", fillers: "7"),
    RecordingLog(name: "Student Reps Campaign-1", date: "Jun 03 2021 | 11.58 AM", mode: 0, isVideo: false, pace: 139, tone: "Monotone", fillers: "5"),
    RecordingLog(name: "Speech Attempt", date: "May 30 2021 | 08.14 AM", mode: 0, isVideo: false, pace: 151, tone: "Monotone", fillers: "9"),
    RecordingLog(name: "My Second Attempt", date: "May 25 2021 | 03.22 PM", mode: 0, isVideo: true, pace: 122, tone: "Dynamic", fillers: "4"),
    RecordingLog(name: "First Attempt", date: "May 22 2021 | 09.41 AM", mode: 0, isVideo: true, pace: 95, tone: "Dynamic", fillers: "3"),
    RecordingLog(name: "App Demo Presentation", date: "April 05 2021 | 09.41 AM", mode: 0, isVideo: true, pace: 110, tone: "Dynamic", fillers: "7"),
    RecordingLog(name: "Class Presentation", date: "April 03 2021 | 11.58 AM", mode: 0, isVideo: false, pace: 139, tone: "Monotone", fillers: "5"),
    
    //entertainment
    RecordingLog(name: "TV Show Host Closing", date: "May 22 2021 | 09.41 AM", mode: 2, isVideo: true, pace: 155, tone: "Monotone", fillers: "3"),
    RecordingLog(name: "Podcast Host Opening", date: "May 20 2021 | 12.22 AM", mode: 2, isVideo: true, pace: 124, tone: "Monotone", fillers: "7"),
    RecordingLog(name: "WWDC MC Brainstorming", date: "April 15 2021 | 05.10 PM", mode: 2, isVideo: false, pace: 172, tone: "Dynamic", fillers: "3"),
    RecordingLog(name: "Stand Up Comedy", date: "April 10 2021 | 09.41 AM", mode: 2, isVideo: true, pace: 160, tone: "Dynamic", fillers: "4"),
//    RecordingLog(name: "Student Reps Campaign", date: "March 29 2021 | 08.30 PM", mode: 2, isVideo: false, pace: 144, tone: "Dynamic", fillers: "9"),
    
    
]
