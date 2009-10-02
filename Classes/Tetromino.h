//
//  Tetromino.h
//  Tetris
//
//  Created by Joshua Aburto on 9/28/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "Block.h"


@interface Tetromino : CocosNode {
	
//	enum tetrominoTypes {
//		kLetterI,
//		kLetterO,
//		kLetterS,
//		kLetterZ,
//		kLetterL,
//		kLetterJ,
//		kLetterT
//	} 
	enum tetrominoTypes tetrominoType;
	BOOL stuck;
	
	CGPoint leftMostPosition;
	CGPoint rightMostPosition;
	
	int boardX;
	int boardY;
}


@property enum tetrominoTypes tetrominoType;
@property (assign) BOOL stuck;
@property (readwrite, assign) int boardX;
@property (readwrite, assign) int boardY;


@property (readonly) CGPoint leftMostPosition;
@property (readonly) CGPoint rightMostPosition;


- (BOOL)isBlockInTetromino:(id)block;
- (void)moveTetrominoDown;
@end
