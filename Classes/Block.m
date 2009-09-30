//
//  Tetromino.m
//  Tetris
//
//  Created by Joshua Aburto on 9/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Block.h"

@interface Block (private)

- (void)initializeDefaults;
- (void)redrawPositionOnBoard;

@end

@implementation Block

@synthesize boardX;
@synthesize boardY;
@synthesize stuck;
@synthesize disappearing;

+ (Block *)newBlock:(int)blockType
{
	NSString *filename = nil, *color = nil;
	Block *temp = nil;
	
	switch (blockType) {
		case 0:
			color = @"red";
			break;
		case 1:
			color = @"blue";
			break;
		case 2:
			color = @"orange";
			break;
		case 3:
			color = @"yellow";
			break;
		case 4:
			color = @"magenta";
			break;
		case 5:
			color = @"cyan";
			break;
		case 6:
			color = @"green";
			break;
		default:
			break;
	}
	
	if (color) {
		filename = [[NSString alloc] initWithFormat:@"%@.png", color];
		temp = [[self spriteWithFile:filename] retain];
		[filename release];
		
		[temp initializeDefaults];
		
	}
	return temp;
	
}


- (void)initializeDefaults
{
	[self setAnchorPoint: ccp(0,0)];
	[self setPosition: ccp(0,0)];
	[self setOpacity:255];
	[self setStuck:NO];
	[self setDisappearing:NO];
	[self setBoardX:0];
	[self setBoardY:0];
}

- (void)redrawPositionOnBoard 
{
	[self setPosition: COMPUTE_X_Y(boardX, boardY)];
}

- (void)moveUp
{
	boardY -= 1;
	[self redrawPositionOnBoard];
}

- (void)moveDown
{
	boardY += 1;
	[self redrawPositionOnBoard];
}

- (void)moveLeft
{
	boardX -= 1;
	[self redrawPositionOnBoard];
}

- (void)moveRight
{
	boardX += 1;
	[self redrawPositionOnBoard];
}



@end
