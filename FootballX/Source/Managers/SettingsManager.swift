//
//  SettingsManager.swift
//  FootballX
//
//  Created by Alex on 12.02.2025.
//

import UIKit
import AVFoundation

final class SettingsManager {
    static let shared = SettingsManager()
    
    private let appID: String
    private let appStoreURL: URL
    private let defaults = UserDefaults.standard
    private var audioPlayer: AVAudioPlayer?
    
    var isMusicEnabled: Bool {
        get { defaults.bool(forKey: "musicEnabled") }
        set {
            defaults.set(newValue, forKey: "musicEnabled")
            if newValue {
                playBackgroundMusic()
            } else {
                stopBackgroundMusic()
            }
        }
    }
    
    private init() {
        #warning("appID")
        self.appID = "6741690079"
        self.appStoreURL = URL(string: "https://apps.apple.com/app/id\(appID)")!
        setupDefaultSettings()
        setupAudioSession()
        prepareBackgroundMusic()
    }
    
    func toggleMusic() {
        isMusicEnabled.toggle()
    }
    
    func playBackgroundMusic() {
        guard isMusicEnabled,
              let player = audioPlayer,
              !player.isPlaying else { return }
        
        audioPlayer?.play()
    }
    
    func stopBackgroundMusic() {
        audioPlayer?.pause()
    }
    
    func rateApp() {
        let appStoreURL = "itms-apps://apps.apple.com/app/id\(appID)"
        if let url = URL(string: appStoreURL),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.open(self.appStoreURL)
        }
    }
    
    private func setupDefaultSettings() {
        if defaults.object(forKey: "musicEnabled") == nil {
            defaults.set(true, forKey: "musicEnabled")
        }
    }
    
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print(error)
        }
    }
    
    private func prepareBackgroundMusic() {
        guard let url = Bundle.main.url(forResource: "backgroundmusic", withExtension: "mp3") else {
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.prepareToPlay()
        } catch {
            print(error)
        }
    }
}
