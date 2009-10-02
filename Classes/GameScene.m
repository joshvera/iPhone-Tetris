//
//  GameScene.m
//  Tetris
//
//  Created by Joshua Aburto on 9/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"
#import "GameLogicLayer.h"


@implementation GameScene


-(id) init
{
	if ((self = [super init])) {
		Sprite *bg = [Sprite spriteWithFile:@"tetris_bg.jpg"];
		[bg setPosition:ccp(160,240)];
		[self addChild:bg z:0];
		
		Layer *layer = [GameLogicLayer node];
		[self addChild:layer z:1];
		
	}
	
	return self;
}

-(void) dealloc
{
	[self removeAllChildrenWithCleanup:YES];
	[[TextureMgr sharedTextureMgr] removeUnusedTextures];
	[super dealloc];
}
@end
