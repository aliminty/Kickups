//
//  GameScene.h
//  KickUps
//

//  Copyright (c) 2015 Ali Minty. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameScene : SKScene

@property SKLabelNode *scoreLabel;
@property SKLabelNode *highScoreLabel;
@property unsigned long score;
@property unsigned long highScore;

@end