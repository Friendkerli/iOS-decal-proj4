//
//  GameScene.swift
//  CalBear Shooter
//
//  Created by Xinran Guo on 12/6/15.
//  Copyright (c) 2015 Xinran Guo. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var Player = SKSpriteNode(imageNamed: "PlayerShip.png")
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        Player.position = CGPointMake(self.size.width / 2, self.size.height / 6)
        var Timer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: Selector("SpawnBullets"), userInfo: nil, repeats: true)
        // By decreasing the timer, enermies will become more
        var EnemyTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("SpawnEnemies"), userInfo: nil, repeats: true)
        self.addChild(Player)
    }
    
    func SpawnBullets(){
        var Bullet = SKSpriteNode(imageNamed: "BulletSingle.png")
        Bullet.zPosition = -5
        Bullet.position = CGPointMake(Player.position.x, Player.position.y)
        
        // By change duration, bullet speed will change
        let action = SKAction.moveToY(self.size.height + 300, duration: 1.0)
        Bullet.runAction(SKAction.repeatActionForever(action))
        self.addChild(Bullet)
    }
    
    func SpawnEnemies(){
        var Enemy = SKSpriteNode(imageNamed: "EnemyShip.png")
        var MinValue = self.size.width / 8
        var MaxValue = self.size.width - 20
        var SpawnPoint = UInt32(MaxValue - MinValue)
        Enemy.position = CGPoint(x:CGFloat(arc4random_uniform(SpawnPoint)), y: self.size.height)

        // By change duration, enermy speed will change
        let action = SKAction.moveToY(-70, duration: 3.0)
        Enemy.runAction(SKAction.repeatActionForever(action))
        self.addChild(Enemy)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            Player.position.x = location.x
            
            
            
            
            
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            
            Player.position.x = location.x
            
            
            
            
            
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
