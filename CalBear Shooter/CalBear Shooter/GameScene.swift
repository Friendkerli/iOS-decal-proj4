//
//  GameScene.swift
//  CalBear Shooter
//
//  Created by Xinran Guo on 12/6/15.
//  Copyright (c) 2015 Xinran Guo. All rights reserved.
//

import SpriteKit

struct PhysicsCatagory {
    static let Enemy: UInt32 = 1
    static let Bullet: UInt32 = 2
    static let Player: UInt32 = 3
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var Player = SKSpriteNode(imageNamed: "PlayerShip.png")
    var Score = Int()
    var ScoreLbl = UILabel()
    var HighScore = Int()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        var highDefault = NSUserDefaults.standardUserDefaults()
        if highDefault.valueForKey("highScore") != nil {
            HighScore = highDefault.valueForKey("highScore") as! NSInteger
        } else {
            HighScore = 0
        }
        self.scene?.backgroundColor = UIColor.yellowColor()
        physicsWorld.contactDelegate = self
        Player.position = CGPointMake(self.size.width / 2, self.size.height / 5)
        Player.physicsBody = SKPhysicsBody(rectangleOfSize: Player.size)
        Player.physicsBody?.affectedByGravity = false
        Player.physicsBody?.categoryBitMask = PhysicsCatagory.Player
        Player.physicsBody?.contactTestBitMask = PhysicsCatagory.Enemy
        Player.physicsBody?.dynamic = false
        
        Player.position = CGPointMake(self.size.width / 2, self.size.height / 6)
        var Timer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: Selector("SpawnBullets"), userInfo: nil, repeats: true)
        // By decreasing the timer, enermies will become more
        var EnemyTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("SpawnEnemies"), userInfo: nil, repeats: true)
        self.addChild(Player)
        
        ScoreLbl.text = "\(Score)"
        ScoreLbl = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        ScoreLbl.backgroundColor = UIColor(red: 0.6, green: 0.1, blue: 0.1, alpha: 0.3)
        ScoreLbl.textColor = UIColor.whiteColor()
        self.view?.addSubview(ScoreLbl)
    }
    
    func SpawnBullets(){
        var Bullet = SKSpriteNode(imageNamed: "BulletSingle.png")
        Bullet.zPosition = -5
        Bullet.position = CGPointMake(Player.position.x, Player.position.y)
        
        // By change duration, bullet speed will change
        let action = SKAction.moveToY(self.size.height + 300, duration: 1.0)
        let actionDone = SKAction.removeFromParent()
        Bullet.runAction(SKAction.sequence([action, actionDone]))
        
        //Bullet.runAction(SKAction.repeatActionForever(action))
        
        Bullet.physicsBody = SKPhysicsBody(rectangleOfSize: Bullet.size)
        Bullet.physicsBody?.categoryBitMask = PhysicsCatagory.Bullet
        Bullet.physicsBody?.contactTestBitMask = PhysicsCatagory.Enemy
        Bullet.physicsBody?.affectedByGravity = false
        Bullet.physicsBody?.dynamic = false
        
        self.addChild(Bullet)
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
//         NSLog("Hello")
        var firstBody: SKPhysicsBody = contact.bodyA
        var secondBody: SKPhysicsBody = contact.bodyB
        if(((firstBody.categoryBitMask == PhysicsCatagory.Enemy)&&(secondBody.categoryBitMask == PhysicsCatagory.Bullet)) ||
            ((firstBody.categoryBitMask == PhysicsCatagory.Bullet)&&(secondBody.categoryBitMask == PhysicsCatagory.Enemy))){
            CollisionWithBullet(firstBody.node as! SKSpriteNode, Bullet: secondBody.node as! SKSpriteNode)
        } else if(((firstBody.categoryBitMask == PhysicsCatagory.Enemy)&&(secondBody.categoryBitMask == PhysicsCatagory.Player)) ||
            ((firstBody.categoryBitMask == PhysicsCatagory.Player)&&(secondBody.categoryBitMask == PhysicsCatagory.Enemy))){
                CollisionWithPerson( firstBody.node as! SKSpriteNode, Person: secondBody.node as! SKSpriteNode)
        }
    }
    
    func CollisionWithBullet(Enemy: SKSpriteNode, Bullet: SKSpriteNode){
        Enemy.removeFromParent()
        Bullet.removeFromParent()
        Score++
        ScoreLbl.text = "\(Score)"
    }
    
    func CollisionWithPerson(Enemy: SKSpriteNode, Person: SKSpriteNode){
        var scoreDefaults = NSUserDefaults.standardUserDefaults()
        scoreDefaults.setValue(Score, forKey: "Score")
        scoreDefaults.synchronize()
        if Score > HighScore {
            var highDefault = NSUserDefaults.standardUserDefaults()
            highDefault.setValue(Score, forKey: "highScore")
        }
        
        Enemy.removeFromParent()
        Person.removeFromParent()
        self.view?.presentScene(EndScene())
        ScoreLbl.removeFromSuperview()
                
    }
    
    
    func SpawnEnemies(){
        var Enemy = SKSpriteNode(imageNamed: "EnemyShip.png")
        var MinValue = self.size.width / 8
        var MaxValue = self.size.width - 20
        var SpawnPoint = UInt32(MaxValue - MinValue)
        Enemy.position = CGPoint(x:CGFloat(arc4random_uniform(SpawnPoint)), y: self.size.height)
        
        Enemy.physicsBody = SKPhysicsBody(rectangleOfSize: Enemy.size)
        Enemy.physicsBody?.categoryBitMask = PhysicsCatagory.Enemy
        Enemy.physicsBody?.contactTestBitMask = PhysicsCatagory.Bullet
        Enemy.physicsBody?.affectedByGravity = false
        Enemy.physicsBody?.dynamic = true

        // By change duration, enermy speed will change
        let action = SKAction.moveToY(-70, duration: 3.0)
        let actionDone = SKAction.removeFromParent()
        Enemy.runAction(SKAction.sequence([action, actionDone]))
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
