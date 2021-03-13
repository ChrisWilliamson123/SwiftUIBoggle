import AVFoundation

class SoundPlayer {
    let audioPlayer: AVAudioPlayer?

    init(soundFileName: String) {
        guard let path = Bundle.main.path(forResource: soundFileName, ofType: nil) else {
            self.audioPlayer = nil
            return
        }
        audioPlayer = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
        audioPlayer?.volume = 0.25
        DispatchQueue.global().async {
            self.audioPlayer?.prepareToPlay()
        }
    }

    func playSound() {
        resetSound()
        audioPlayer?.play()
    }

    private func resetSound() {
        audioPlayer?.stop()
        audioPlayer?.currentTime = 0
    }
}
