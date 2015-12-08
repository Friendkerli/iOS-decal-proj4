//
//  EndScene.swift
//  CalBear Shooter
//
//  Created by Mac on 12/7/15.
//  Copyright © 2015 Xinran Guo. All rights reserved.
//

import Foundation
import SpriteKit

class EndScene : SKScene {
    var HighScore: Int!
    var restart : UIButton!
    var highScore : UILabel!
    var currScore : UILabel!
    
    override func didMoveToView(view: SKView) {
        self.scene?.backgroundColor = UIColor.blackColor()
        var scoreDefaults = NSUserDefaults.standardUserDefaults()
        var Score = scoreDefaults.valueForKey("Score") as! NSInteger
        NSLog("\(Score)")
        var highDefault = NSUserDefaults.standardUserDefaults()
        HighScore = highDefault.valueForKey("highScore") as! NSInteger
        NSLog("\(HighScore)")
        currScore = UILabel(frame: CGRect(x: 0, y: 0, width: frame.size.width/3, height: 30))
        currScore.center = CGPoint(x: view.frame.size.width/2+70, y: view.frame.size.width/7+70)
        currScore.textColor = UIColor.whiteColor()
        currScore.text = "\(Score)"
        self.view?.addSubview(currScore)
        
        highScore = UILabel(frame: CGRect(x: 0, y: 0, width: frame.size.width/3, height: 30))
        highScore.center = CGPoint(x: view.frame.size.width/2+150, y: view.frame.size.width/7+150)
        currScore.textColor = UIColor.whiteColor()
        highScore.text = "\(HighScore)"
        self.view?.addSubview(highScore)
        
        restart = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.size.width/3, height: 30))
        restart.center = CGPoint(x: frame.size.width/2+100, y: frame.size.width/7+100)
        restart.setTitle("Replay", forState: UIControlState.Normal)
        restart.addTarget(self, action: Selector("restartGame"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view?.addSubview(restart)
    }
    
    func restartGame () {
        self.view?.presentScene(GameScene(), transition: SKTransition.crossFadeWithDuration(0.3))
        restart.removeFromSuperview()
        currScore.removeFromSuperview()
        highScore.removeFromSuperview()
    }
}