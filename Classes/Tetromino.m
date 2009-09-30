//
//  Tetromino.m
//  Tetris
//
//  Created by Joshua Aburto on 9/28/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Tetromino.h"

@interface Tetromino (private)
- (void)initializeTetromino;
- (void)setShape;
@end

@implementation Tetromino
@synthesize blockArray;
@synthesize tetrominoType;

- (id)init
{
	if ((self = [super init])) {
		tetrominoType = (arc4random() % 7);
		
		blockArray = [[NSMutableArray alloc] initWithCapacity:4];
		
		for (int i = 0; i < 4; i++) {
			Block *tempBlock = [Block newBlock:tetrominoType];
			[blockArray addObject:tempBlock];
			[self addChild:tempBlock z:2];
			[tempBlock release];
		}
		[self initializeTetromino];
		
	}
	return self;
}

- (void)initializeTetromino
{
	self.stuck = NO;
	[self setShape];
	
	
}

- (void)setShape
{	
	NSUInteger index = 0;
	for (Block *currentBlock in blockArray){
		
		switch (tetrominoType) {
			case kLetterI:
				currentBlock.boardX = index+3;
				currentBlock.boardY = 0;
				break;
			case kLetterO:

				if (index == 0 || index == 1) {
					currentBlock.boardX = index+5;
					currentBlock.boardY = 0;
				} else {
					currentBlock.boardX = index+3;
					currentBlock.boardY = 1;
				}

				break;
			case kLetterS:
				if (index == 0 || index == 1) {
					currentBlock.boardX = index+6;
					currentBlock.boardY = 0;
				} else {
					currentBlock.boardX = index+3;
					currentBlock.boardY = 1;
				}
				break;
			case kLetterZ:
				if (index == 0 || index == 1) {
					currentBlock.boardX = index+5;
					currentBlock.boardY = 0;
				} else {
					currentBlock.boardX = index+4;
					currentBlock.boardY = 1;
				}
				break;
			case kLetterL:
				if (index == 3) {
					currentBlock.boardX = index+4;
					currentBlock.boardY = 1;
				} else {
					currentBlock.boardX = index+5;
					currentBlock.boardY = 0;
				}
				break;
			case kLetterJ:
				
				if (index == 3) {
					currentBlock.boardX = index+3;
					currentBlock.boardY = 1;
				} else {
					currentBlock.boardX = index+5;
					currentBlock.boardY = 0;
				}
				break;
			case kLetterT:
				if (index == 3) {
					currentBlock.boardX = index+3;
					currentBlock.boardY = 1;
				} else {
					currentBlock.boardX = index+5;
					currentBlock.boardY = 0;
				}
				break;
			default:
				break;
		}
		currentBlock.position = COMPUTE_X_Y(currentBlock.boardX, currentBlock.boardY);
		index++;
	}

}

- (BOOL)stuck
{
	for (Block *block in blockArray) {
			stuck = block.stuck;
	}
	return stuck;
}

- (void)setStuck:(BOOL)stuckValue
{
	stuck = stuckValue;
	for (Block *block in blockArray) {
		block.stuck = stuckValue;
	}
}

- (void)dealloc
{
	[blockArray release];
	[super dealloc];
}


- (CGPoint)leftMostPosition
{
	CGPoint	myLeftPosition;
	for (Block *currentBlock in blockArray) {
		if ( myLeftPosition.x > currentBlock.boardX) {
			myLeftPosition = ccp(currentBlock.boardX, currentBlock.boardY);
		}
	}
	return myLeftPosition;
	
}

- (CGPoint)rightMostPosition
{
	CGPoint myRightPosition;
	for (Block *currentBlock in blockArray) {
		if (myRightPosition.x < currentBlock.boardX) {
			myRightPosition = ccp(currentBlock.boardX, currentBlock.boardY);
		}
	}
	return myRightPosition;
}

@end
