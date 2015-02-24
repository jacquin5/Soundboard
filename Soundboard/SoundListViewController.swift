//
//  SoundListViewController.swift
//  Soundboard
//
//  Created by Jacquin Wynn Jr on 2/22/15.
//  Copyright (c) 2015 JMW. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class SoundListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    //Creates  an audioplayer...gives us a way to play sound
    var audioPlayer = AVAudioPlayer()
    
    var sounds: [Sound] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Anything is possible...
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        var soundPath = NSBundle.mainBundle().pathForResource("whatitdo", ofType: "m4a")
        var soundURL = NSURL.fileURLWithPath(soundPath!)
        
        //Lets get the whole App Delegate and we are seaching manange object context 
        //Go to the app delegate the get the managed object context
        var context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
        
        var sound1 = NSEntityDescription.insertNewObjectForEntityForName("Sound", inManagedObjectContext: context) as Sound
        
        sound1.name = "My Sound"
        //Converts URL to string
        sound1.url = soundURL!.absoluteString!
        
        context.save(nil)
        
        var request = NSFetchRequest(entityName: "Sound")
        
        self.sounds = context.executeFetchRequest(request, error: nil)! as [Sound]
        
//        //An object that is created
//        var sound1 = Sound()
//        sound1.name = "What It Do"
//        sound1.URL = soundURL!
//        
//        self.sounds.append(sound1)
    }
    //How many rows? This answer questions that are set by datasource and delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sounds.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var sound = self.sounds[indexPath.row]
        //Creates brand new cell for Table View
        var cell = UITableViewCell()
        cell.textLabel!.text = sound.name
        return cell
    }
    //This is code is whenever a user taps on the table cell
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var sound = self.sounds[indexPath.row]
        
        var url = NSURL(string: sound.url)
        
        self.audioPlayer = AVAudioPlayer(contentsOfURL: url, error: nil)
        self.audioPlayer.play()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var nextViewController = segue.destinationViewController as NewSoundViewController
        nextViewController.previousViewController = self
    }

    

}

