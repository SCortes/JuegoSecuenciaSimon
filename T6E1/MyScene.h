//
//  MyScene.h
//  T6E1
//

//  Copyright (c) 2014 Sergio. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MyScene : SKScene

@property(strong, nonatomic) SKSpriteNode * ryu;
@property(strong, nonatomic) NSMutableArray * secuencia;
@property(strong, nonatomic) NSMutableDictionary * botones;

@property(strong, nonatomic) SKSpriteNode * boton1;
@property(strong, nonatomic) SKSpriteNode * boton2;
@property(strong, nonatomic) SKSpriteNode * boton3;
@property(strong, nonatomic) SKSpriteNode * boton4;

@property(strong, nonatomic)SKAction * fadeIn;
@property(strong, nonatomic)SKAction * fadeOut;
@property(strong, nonatomic)SKAction * scale;
@property(strong, nonatomic)SKAction *loadTexture;
@property(strong, nonatomic)SKAction *wait;
@property(strong, nonatomic)SKAction *moverResultado;

@property(strong, nonatomic)SKLabelNode *resultado;



@end
