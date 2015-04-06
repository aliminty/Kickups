//
//  GameScene.m
//  KickUps
//
//  Created by Ali Minty on 3/22/15.
//  Copyright (c) 2015 Ali Minty. All rights reserved.
//

#import "GameScene.h"

@interface GameScene () <SKPhysicsContactDelegate>
@end

@implementation GameScene

@synthesize scoreLabel;
@synthesize highScoreLabel;
@synthesize score;
@synthesize highScore;

-(void)didMoveToView:(SKView *)view {
    
    //SKSpriteNode *soccerball = [SKSpriteNode spriteNodeWithImageNamed:@"Soccerball"];
    //[self addChild:soccerball];
    
    /* Setup your scene here
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    
    myLabel.text = @"Hello, World!";
    myLabel.fontSize = 65;
    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMidY(self.frame));
    
    [self addChild:myLabel];*/
    
    CGPoint middlePoint = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
    
    self.physicsWorld.gravity = CGVectorMake(0,-7);
    self.physicsWorld.contactDelegate = self;
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    
    score = 0;
    highScore = 0;
    
    scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    scoreLabel.text = [NSString stringWithFormat:@"%lu", score];
    scoreLabel.fontSize = 60;
    
    SKSpriteNode *ball = [SKSpriteNode spriteNodeWithImageNamed:@"Soccerball"];
    ball.physicsBody = [SKPhysicsBody bodyWithTexture:ball.texture size:ball.texture.size];
    ball.position = middlePoint;
    ball.xScale = 0.5;
    ball.yScale = 0.5;
    ball.name = @"ball";
    [self addChild:ball];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKSpriteNode *nodeTouched = (SKSpriteNode *)[self nodeAtPoint:location];
        if ([nodeTouched.name isEqual: @"ball"]) {
            NSLog(@"made contact with ball");
            [nodeTouched.physicsBody applyImpulse: CGVectorMake(0, 4000) atPoint:location];
        }
        
        //SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        //[sprite runAction:[SKAction repeatActionForever:action]];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
