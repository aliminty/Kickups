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
    CGRect theFrame = CGRectMake(self.anchorPoint.x, self.anchorPoint.y, self.size.width, self.size.height);
    NSLog(@"view: %f,%f   scene: %f, %f", (double)(self.view.frame.size.width), (double)(self.view.frame.size.height), (double)(self.size.width), (double)(self.size.height));
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:theFrame];
    
    score = 0;
    highScore = 0;
    
    scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    scoreLabel.text = [NSString stringWithFormat:@"%lu", score];
    scoreLabel.fontSize = 60;
    
    SKSpriteNode *ball = [SKSpriteNode spriteNodeWithImageNamed:@"Soccerball"];
    ball.physicsBody = [SKPhysicsBody bodyWithTexture:ball.texture size:ball.texture.size];
    ball.position = middlePoint;
    //ball.size = CGSizeMake(ball.size.width*2, ball.size.height);
    ball.xScale = 0.5;
    ball.yScale = 0.5;
    ball.name = @"ball";
    [self addChild:ball];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    CGFloat forceMultX = 50;
    CGFloat forceMulty = 490;
    
    for (UITouch *touch in touches) {
        
        CGPoint location = [touch locationInNode:self];
        CGFloat x1 = location.x;
        CGFloat y1 = location.y;
        CGVector ballVector;
        
        SKSpriteNode *nodeTouched = (SKSpriteNode *)[self nodeAtPoint:location];
        if ([nodeTouched.name isEqual: @"ball"]) {
            NSLog(@"made contact with ball");
            
            // create vector for physics force (impulse)
            CGFloat x2 = nodeTouched.position.x;
            CGFloat y2 = nodeTouched.position.y;
            NSLog(@"x1: %f, y1: %f, x2: %f, y2: %f", (double)x1, (double)y1, (double)x2, (double)y2);
            if (y1 > y2) {
                ballVector = CGVectorMake((x2-x1)*forceMultX, (y2-y1)*forceMulty);
            }
            else {
                ballVector = CGVectorMake((x2-x1)*2*forceMultX, (y1-y2)*forceMulty);
            }
            
            [nodeTouched.physicsBody applyImpulse: ballVector atPoint:location];
        }
        
        //SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        //[sprite runAction:[SKAction repeatActionForever:action]];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
