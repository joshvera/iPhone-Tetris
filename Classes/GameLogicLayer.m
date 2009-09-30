//
//  GameLogicLayer.m
//  Tetris
//
//  Created by Joshua Aburto on 9/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "GameLogicLayer.h"

@interface GameLogicLayer (private)

- (void)startGame;
- (void)createNewTetromino;
- (void)tryToCreateNewTetromino;

- (void)moveBlocksDown;
- (void)moveBlockDown:(Block *)block;
- (void)moveBlockLeft:(Block *)block;
- (void)moveBlockRight:(Block *)block;

- (void)gameOver;
- (BOOL)isBlockInTetromino:(Block *)block;
- (void)moveTetrominoDown;

- (BOOL)boardRowEmpty:(int)column;

- (void)moveTetrominoLeft;
- (void)moveTetrominoRight;

@end

@implementation GameLogicLayer

- (id)init
{
	if ((self = [super init])) {
		isTouchEnabled = YES;
		[self startGame];
	}
	return self;
}

- (void)startGame
{
	memset(board, 0, sizeof(board));
	
	[self createNewTetromino];
	frameCount = 0;
	moveCycleRatio = 45;
	[self schedule:@selector(updateBoard:) interval:(1.0/60.0)];
}

- (void)createNewTetromino
{
	
	Tetromino *tempTetromino = [[Tetromino alloc] init];

	for (Block *currentBlock in tempTetromino.blockArray) {
		NSLog(@"%@", currentBlock);
		board[currentBlock.boardX][currentBlock.boardY] = currentBlock;
	}
	userTetromino = tempTetromino;
	[self addChild:userTetromino];
	[tempTetromino release];

}
- (void)tryToCreateNewTetromino
{
	// If any spot in the top two rows where blocks spawn is taken
	for (int i = 4; i < 8; i++) {
		for (int j = 0; j < 2; j++) {
			if (board[i][j]) {
				[self gameOver];
			}
			
		}
	}
	[self createNewTetromino];
}
- (void)gameOver
{
	[self unschedule:@selector(updateFrame:)];
	
	Sprite *gameOverBackground = [Sprite spriteWithFile:@"gameover.jpeg"];
	gameOverBackground.position = ccp(160,240);
	gameOverBackground.opacity = 255;
	[self addChild:gameOverBackground z:3];
	
}
- (void)moveBlocksDown
{
	Block *currentBlock = nil;
	BOOL alreadyMovedTetromino = NO;
	// Get a new Tetromino if Tetromino cant move anymore
	if(userTetromino.stuck) {
		[self tryToCreateNewTetromino];
	}
	
	// Go through board from bottom to top
	

	for (int x = kLastColumn; x >= 0 ; x--) {
		for (int y = kLastRow; y >= 0; y--) {
			currentBlock = board[x][y];
			if (currentBlock != nil) {
				if ([self isBlockInTetromino:currentBlock]) {
					if (!(alreadyMovedTetromino)) {
						[self moveTetrominoDown];
						alreadyMovedTetromino = YES;
					}

					
				} else if (y != kLastRow && ([self boardRowEmpty:x])){
					[self moveBlockDown:currentBlock];
					currentBlock.stuck = NO;
				}
				else {
					currentBlock.stuck = YES;
				}
			}
		}
	}
	
}

- (BOOL)boardRowEmpty:(int)column
{
	for (int i = 0;i < kLastRow; i++) {
		if (board[column][i]) {
			return NO;
		}
	}
	return YES;
}

- (void)moveTetrominoDown
{

		

	
	for (Block *currentBlock in userTetromino.blockArray) {
		Block *blockUnderCurrentBlock = board[currentBlock.boardX][currentBlock.boardY + 1];
		if (!([self isBlockInTetromino:blockUnderCurrentBlock])) {
			
			if (currentBlock.boardY == kLastRow ||
				(board[currentBlock.boardX][currentBlock.boardY + 1] != nil)) {
				userTetromino.stuck = YES;
			}
		}
	}
	
	if (!userTetromino.stuck) {
		for (Block *block in userTetromino.blockArray) {
			[self moveBlockDown:block];
		}
	}
}

- (void)moveTetrominoLeft
{
	for (Block *currentBlock in userTetromino.blockArray) {
		[self moveBlockLeft:currentBlock];
	}
}

- (void)moveTetrominoRight
{
	for (Block *currentBlock in userTetromino.blockArray) {
		[self moveBlockRight:currentBlock];
	}
}

- (BOOL)isBlockInTetromino:(id)block
{
	for (Block *currentBlock in userTetromino.blockArray) {
		if ([currentBlock isEqual:block]) {
			return YES;
		}
		
	}
	return NO;
}

- (BOOL)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
	CGPoint point = [touch locationInView: [touch view]];
	
	//Flip the UITouch coord upside down for portrait mode
	// Because UITouch goes from top down and Cocos2d goes from bottom up?
	point.y = 480 - point.y;
	
	if (point.x < 116) {
		touchType = kMoveLeft;
	} else if (point.x > 204) {
		touchType = kMoveRight;
	}
	
	return kEventHandled;
}

- (void)processTaps
{
	NSLog(@"Processing Taps");
	if (touchType == kMoveLeft) {
		touchType = kNone;
		
		if (userTetromino.leftMostPosition.x > 0 && !userTetromino.stuck) {
				[self moveTetrominoLeft];
		}
	} else if (touchType == kMoveRight) {
		touchType = kNone;
		
		if (userTetromino.rightMostPosition.x < kLastColumn && !userTetromino.stuck) {
			[self moveTetrominoRight];
		}
	}	
	
}


- (void)moveBlockDown:(Block *)block
{
	board[block.boardX][block.boardY] = nil;
	board[block.boardX][block.boardY + 1] = block;
	[block moveDown];
}

- (void)moveBlockLeft:(Block *)block
{
	if (nil == board[block.boardX - 1][block.boardY]) {
		board[block.boardX][block.boardY] = nil;
		board[block.boardX - 1][block.boardY] = block;
		block.moveLeft;
	}

}

- (void)moveBlockRight:(Block *)block
{
	if (nil == board[block.boardX + 1][block.boardY]) {
		board[block.boardX][block.boardY] = nil;
		board[block.boardX + 1][block.boardY] = block;
		block.moveRight;		
	}

}

- (void)updateBoard:(ccTime)dt
{
	frameCount += 1;
	[self processTaps];
	if (frameCount % moveCycleRatio == 0) {
		[self moveBlocksDown];

	}


}

- (void)dealloc
{
	[self removeAllChildrenWithCleanup:YES];
	[userTetromino release];
	[difficultyLabel release];
	[scoreLabel release];
	[super dealloc];
}
@end
