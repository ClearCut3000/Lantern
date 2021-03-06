//
//  ViewController.swift
//  Lantern
//
//  Created by Николай Никитин on 22.07.2021.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {

    func toggleTorch(on: Bool) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }

        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                if on == true {
                    device.torchMode = .on
                } else {
                    device.torchMode = .off
                }
                device.unlockForConfiguration()
            } catch {
                print("Torch could't be used")
            }
        } else {
            print("Torch isn't available")
        }
    }
    var isLigntOn = 1
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
   
    fileprivate func updateUI() {
        switch isLigntOn{
        case 1:
            view.backgroundColor = .white
        case 2:
            view.backgroundColor = .black
        case 3:
            view.backgroundColor = .red
        case 4:
            view.backgroundColor = .yellow
        case 5:
            view.backgroundColor = .green
        default:
            view.backgroundColor = .white
        }
    }

    @IBOutlet var torchOnOff: UISwitch!
    
    @IBAction func torchSwitch(_ sender: UISwitch) {
        
        if torchOnOff.isOn {
            toggleTorch(on: true)
        } else{
            toggleTorch(on: false)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isLigntOn += 1
        if isLigntOn > 5 {
            isLigntOn = 1
        }
        updateUI()
    }

    }
    
