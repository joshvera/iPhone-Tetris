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
	
	enum tetrominoTypes {
		kLetterI,
		kLetterO,
		kLetterS,
		kLetterZ,
		kLetterL,
		kLetterJ,
		kLetterT
	} tetrominoType;
	NSMutableArray *blockArray;
	BOOL stuck;
	
	CGPoint leftMostPosition;
	CGPoint rightMostPosition;
}


@property (retain, nonatomic) NSMutableArray *blockArray;
@property enum tetrominoTypes tetrominoType;
@property (assign) BOOL stuck;

@property (readonly) CGPoint leftMostPosition;
@property (readonly) CGPoint rightMostPosition;


@end
