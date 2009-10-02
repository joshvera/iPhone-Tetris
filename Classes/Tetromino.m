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
@synthesize tetrominoType;
@synthesize boardX;
@synthesize boardY;


- (id)init
{
	if ((self = [super init])) {
		tetrominoType = (arc4random() % 7);
		
		for (int i = 0; i < 4; i++) {
			Block *tempBlock = [Block newBlock:tetrominoType];
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
	Block *firstBlock = [children objectAtIndex:0];
	self.boardX = firstBlock.boardX;
	self.boardY = firstBlock.boardY;
	self.anchorPoint = ccp(0,0);
}

- (void)setShape
{	
	NSUInteger index = 0;
	for (Block *currentBlock in self.children){
		
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
	for (Block *block in self.children) {
			stuck = block.stuck;
	}
	return stuck;
}

- (void)setStuck:(BOOL)stuckValue
{
	stuck = stuckValue;
	for (Block *block in self.children) {
		block.stuck = stuckValue;
	}
}

- (BOOL)isBlockInTetromino:(id)block
{
	for (Block *currentBlock in self.children) {
		if ([currentBlock isEqual:block]) {
			return YES;
		}
		
	}
	return NO;
}

- (void)moveTetrominoDown
{
	NSArray* reversedChildren = [[children reverseObjectEnumerator] allObjects];
	
	for (Block *currentBlock in reversedChildren) {
		[currentBlock moveDown];
	}
	self.boardY += 1;
	NSLog(@"%d, %d",COMPUTE_X(self.boardX), COMPUTE_Y(self.boardY));
	//[self runAction:[MoveTo actionWithDuration:1.0/45.0 position:COMPUTE_X_Y(self.boardX, self.boardY)]];
	
	
}

- (void)dealloc
{

	[super dealloc];
}


//- (void)setBoardX:(int)x
//{
//
//	boardX = x;
//
//	for (Block *currentBlock in self.children) {
//		
//		currentBlock.boardX = self.boardX - currentBlock.boardX;
//	}
//
//
//}
//
//- (void)setBoardY:(int)y
//{
//	boardY = y;
//	for (Block *currentBlock in self.children) {
//		currentBlock.boardY += self.boardY - currentBlock.boardY;
//	}
//}

- (CGPoint)leftMostPosition
{

	CGPoint	myLeftPosition = ccp(999,999);
	for (Block *currentBlock in self.children) {
		if ( myLeftPosition.x > currentBlock.boardX) {
			myLeftPosition = ccp(currentBlock.boardX, currentBlock.boardY);
		}
	}
	return myLeftPosition;
	
}

- (CGPoint)rightMostPosition
{
	CGPoint myRightPosition = ccp(-1, -1);
	for (Block *currentBlock in self.children) {
		if (myRightPosition.x < currentBlock.boardX) {
			myRightPosition = ccp(currentBlock.boardX, currentBlock.boardY);
		}
	}
	return myRightPosition;
}


@end
