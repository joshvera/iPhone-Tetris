//
//  Tetromino.h
//  Tetris
//
//  Created by Joshua Aburto on 9/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"


@interface Block : Sprite {
	int boardX, boardY;
	BOOL stuck;
	BOOL disappearing;
	

}

@property int boardX;
@property int boardY;
@property BOOL stuck;
@property BOOL disappearing;

+ (Block *)newBlock:(int)blockType;
- (void)moveUp;
- (void)moveDown;
- (void)moveLeft;
- (void)moveRight;

@end

#define COMPUTE_X(x) (abs(x) * 24)
#define COMPUTE_Y(y) (456 - (abs(y) * 24))
#define COMPUTE_X_Y(x,y) ccp( COMPUTE_X(x), COMPUTE_Y(y))