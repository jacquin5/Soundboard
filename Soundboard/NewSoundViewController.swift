//
//  NewSoundViewController.swift
//  Soundboard
//
//  Created by Jacquin Wynn Jr on 2/23/15.
//  Copyright (c) 2015 JMW. All rights reserved.
//

import UIKit
import AVFoundation

class NewSoundViewController : UIViewController {

    required init(coder aDecoder: NSCoder) {
        var baseString : String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as String
        
        var pathComponents = [baseString, "MyAudio.m4a"]
        
        self.audioURL = NSURL.fileURLWithPathComponents(pathComponents)
        
        var session = AVAudioSession.sharedInstance()
        
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        var recordSettings: [NSObject : AnyObject] = Dictionary()
        
        recordSettings[AVFormatIDKey] = kAudioFormatMPEG4AAC
        
        recordSettings[AVSampleRateKey] = 44100.0
        
        recordSettings[AVNumberOfChannelsKey] = 2
        
        self.audioRecorder = AVAudioRecorder(URL: self.audioURL, settings: recordSettings, error: nil)
        
        self.audioRecorder.meteringEnabled = true
        
        self.audioRecorder.prepareToRecord()
        //Super init is below
        super.init(coder: aDecoder)
    }
    
   
    
    @IBOutlet weak var soundTextField: UITextField!
    @IBOutlet weak var recordButton: UIButton!
    
    var audioRecorder : AVAudioRecorder
    var audioURL : NSURL!
    
    
    
    var previousViewController = SoundListViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Anything is Possible
    }
    
    @IBAction func saveTapped(sender: AnyObject) {
        //Create a sound object
        var sound = Sound()
        sound.name = self.soundTextField.text
        //sound.URL = self.audioURL
        
        //Adds sound to sounds array
        self.previousViewController.sounds.append(sound)
        
        
        //Dismiss this view controller
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func cancelButton(sender: AnyObject) {
        //All this does is dismiss the current view controller with an animation
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
     @IBAction func recordTapped(sender: AnyObject) {
        if self.audioRecorder.recording {
            self.audioRecorder.stop()
            self.recordButton.setTitle("RECORD", forState: UIControlState.Normal)
        } else {
            var session = AVAudioSession.sharedInstance()
            session.setActive(true, error: nil)
            self.audioRecorder.record()
            //Changing the text of the button when tapped
            self.recordButton.setTitle("DONE RECORDING", forState: UIControlState.Normal)
        }
        
    }
    
}
