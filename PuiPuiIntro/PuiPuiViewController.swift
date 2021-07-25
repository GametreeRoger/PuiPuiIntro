//
//  ViewController.swift
//  PuiPuiIntro
//
//  Created by 張又壬 on 2021/7/25.
//

import UIKit
import AVKit

class PuiPuiViewController: UIViewController {

    @IBOutlet weak var charaPicture: UIImageView!
    
    @IBOutlet weak var previousUIButton: UIButton!
    
    @IBOutlet weak var nextUIButton: UIButton!
    
    @IBOutlet weak var pageUILabel: UILabel!
    
    @IBOutlet weak var nameUILable: UILabel!
    
    @IBOutlet weak var charaIntroTextView: UITextView!
    
    @IBOutlet weak var pageUIPageControl: UIPageControl!
    
    @IBOutlet weak var segmentUISegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var repeatUIButton: UIButton!
    
    private var index = 0;
    private var filpAni = FlipPage.none
    private var isRepeat = false
    private var playTimer: Timer?
    private var soundPlayer: AVAudioPlayer?
    
    private var currentIndext: Int {
        set {
            if newValue < 0 {
                index = PuiPuiData.data.count - 1
                filpAni = .previous
            }
            else if newValue >= PuiPuiData.data.count {
                index = 0
                filpAni = .next
            }
            else {
                if index < newValue {
                    filpAni = .next
                } else if index > newValue {
                    filpAni = .previous
                } else {
                    filpAni = .none
                }
                index = newValue
            }
            updateView()
        }
        get {
            return index
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        charaPicture.layer.cornerRadius = 10
        charaPicture.layer.borderWidth = 5
        charaPicture.layer.borderColor = UIColor(named: "TextColor")?.cgColor
        pageUIPageControl.numberOfPages = PuiPuiData.data.count
        segmentUISegmentedControl.replaceSegments(datas: PuiPuiData.data)
        segmentUISegmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.orange], for: .selected)
        segmentUISegmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        if let url = Bundle.main.url(forResource: "sound", withExtension: "mp3") {
            soundPlayer = try? AVAudioPlayer(contentsOf: url)
        }
        currentIndext = 0
    }
    @IBAction func previousPage(_ sender: Any) {
        currentIndext -= 1
    }
    
    @IBAction func nextPage(_ sender: Any) {
        currentIndext += 1
    }

    @IBAction func pageControlChanged(_ sender: UIPageControl) {
        currentIndext = sender.currentPage
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        currentIndext = sender.selectedSegmentIndex
    }
    
    @IBAction func swipeChanged(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            currentIndext -= 1
        } else {
            currentIndext += 1
        }
    }
    
    @IBAction func repeatPlay(_ sender: UIButton) {
        isRepeat = !isRepeat
        if isRepeat {
            repeatUIButton.setImage(UIImage(systemName: "stop.fill"), for: .normal)
            playTimer = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(repeatTimerAction), userInfo: nil, repeats: true)
        } else {
            repeatUIButton.setImage(UIImage(systemName: "repeat"), for: .normal)
            playTimer?.invalidate()
        }
    }
    
    func updateView() {
        charaPicture.setImage(PuiPuiData.data[currentIndext].picture, dir: filpAni)
        pageUILabel.text = String(currentIndext + 1)
        nameUILable.text = PuiPuiData.data[currentIndext].name
        charaIntroTextView.text = PuiPuiData.data[currentIndext].intro
        pageUIPageControl.currentPage = currentIndext
        segmentUISegmentedControl.selectedSegmentIndex = currentIndext
        
        if let soundPlayer = soundPlayer {
            if soundPlayer.isPlaying {
                soundPlayer.currentTime = 0
                soundPlayer.stop()
            }
            soundPlayer.play()
        }
    }
    
    @objc func repeatTimerAction() {
        currentIndext += 1
    }
}

enum FlipPage {
    case next
    case previous
    case none
}

extension UIImageView{
    func setImage(_ image: UIImage?, dir: FlipPage) {
        let duration = dir == .none ? 0.0 : 0.3
        let options: UIView.AnimationOptions = dir == .next ? .transitionCurlUp : .transitionCurlDown
        UIView.transition(with: self, duration: duration, options: options, animations: {
            self.image = image
        }, completion: nil)
    }
}

extension UISegmentedControl {
    func replaceSegments(datas: Array<PuiPuiData>) {
        self.removeAllSegments()
        for data in datas {
            self.insertSegment(withTitle: data.name, at: self.numberOfSegments, animated: false)
        }
    }
}
