//
//  MyScene.m
//  T6E1
//
//  Created by Sergio on 15/02/14.
//  Copyright (c) 2014 Sergio. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene
@synthesize ryu, secuencia, fadeIn, fadeOut, scale, loadTexture, boton1, boton2, boton3, boton4, wait, resultado, moverResultado;
int comparador = 0;
int contador = 1;
BOOL jugar = FALSE;

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        scale = [SKAction sequence:@[[SKAction scaleTo:2 duration:0.4],[SKAction scaleTo:1 duration:0.4]]];
        wait = [SKAction waitForDuration:1];
        moverResultado = [SKAction moveToY:CGRectGetMidY(self.frame) duration:.5];
        
        
        fadeIn = [SKAction fadeAlphaTo:1 duration:0.5];
        fadeOut = [SKAction fadeAlphaTo:0 duration:0.5];
        
        ryu = [[SKSpriteNode alloc] init];
        
        ryu.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
        [self addChild:ryu];
        
        boton1 = [[SKSpriteNode alloc] initWithImageNamed:@"parteRoja.png"];
        boton1.position = CGPointMake(CGRectGetMidX(self.frame)-75, CGRectGetMidY(self.frame)+75);
        boton1.name = @"ryu1";
        
        boton2 = [[SKSpriteNode alloc] initWithImageNamed:@"parteAzul.png"];
        boton2.position = CGPointMake(CGRectGetMidX(self.frame)+75, CGRectGetMidY(self.frame)+75);
        boton2.name = @"ryu2";
        
        boton3 = [[SKSpriteNode alloc] initWithImageNamed:@"parteMorada.png"];
        boton3.position = CGPointMake(CGRectGetMidX(self.frame)-75, CGRectGetMidY(self.frame)-75);
        boton3.name = @"ryu3";
        
        boton4 = [[SKSpriteNode alloc] initWithImageNamed:@"parteVerde.png"];
        boton4.position = CGPointMake(CGRectGetMidX(self.frame)+75, CGRectGetMidY(self.frame)-75);
        boton4.name = @"ryu4";
        
        resultado = [[SKLabelNode alloc] init];
        resultado.fontColor = [UIColor redColor];
        
        
        SKLabelNode * botonJugar = [[SKLabelNode alloc] init];
        botonJugar.text = @"Jugar";
        botonJugar.name = @"Jugar";
        botonJugar.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame)-100);
        
        [self addChild:botonJugar];
        [self addChild:boton1];
        [self addChild:boton2];
        [self addChild:boton3];
        [self addChild:boton4];
        [self addChild:resultado];

        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKNode * selectedButton = [self nodeAtPoint:location];
        if([selectedButton.name isEqualToString:@"Jugar"]){
            [self generarSecuencia];
        }
        NSRange finding = [selectedButton.name rangeOfString:@"ryu"];
        if(finding.length == 0){
            NSLog(@"No pulsamos el boton correcto");
        }else{
            if(jugar){
            [self runAction:[SKAction runAction:scale onChildWithName:selectedButton.name]];
            [self compararConSecuencia:selectedButton.name];
            }
        }
        
    
    }
}

-(SKAction *)animar:(NSString *)valor{

    
    NSString * nombreImagen = [[NSString alloc] initWithFormat:@"%@.png",valor];
    SKTexture * textura = [SKTexture textureWithImageNamed:nombreImagen];
    ryu.size = textura.size;
    loadTexture = [SKAction setTexture:textura];
    SKAction * sequence = [SKAction sequence:@[loadTexture,fadeIn,fadeOut]];
    
        
    return sequence;
}


# pragma mark generarSecuencia
-(void)generarSecuencia{
    jugar = TRUE;
    resultado.position = CGPointMake(CGRectGetMidX(self.frame),-30);
    comparador = 0;
    //En este array se almacenará la secuencia
    secuencia = [[NSMutableArray alloc] initWithCapacity:contador];
    //En este array almacenaré las animaciones para mostrar la secuencia aleatoria de ryu
    NSMutableArray * animaciones = [[NSMutableArray alloc] initWithCapacity:contador];
    
    
    //Genero una secuencia de 2
    for(int i=0; i<contador; i++){
        //Genero un numero aleatorio entre 1 y 4
        int value = 1 + arc4random() % (4-1+1);
        NSString * valor =[[NSString alloc]initWithFormat:@"ryu%i",value];
        
        //Almaceno la secuencia
        [secuencia addObject:valor];
        //Almaceno la secuencia de SKAction que habrá que representar en el centro.
        [animaciones addObject:[self animar:valor]];
        
    }
    NSMutableArray * secuencia_scale_botones = [[NSMutableArray alloc] initWithCapacity:contador*2];
    for(NSString * boton in secuencia){
        [secuencia_scale_botones addObject:[SKAction runAction:scale onChildWithName:boton]];
        [secuencia_scale_botones addObject:wait];
    }
    
    SKAction * ejecutaScales = [SKAction sequence:secuencia_scale_botones];
    SKAction * ejecutaTodo = [SKAction sequence:animaciones];
    [ryu runAction:ejecutaTodo];
    [self runAction:ejecutaScales];
    
    
    
}

-(void)compararConSecuencia:(NSString *)boton{
    if([[secuencia objectAtIndex:comparador] isEqualToString:boton]){
        if(comparador == [secuencia count]-1){
            resultado.text =@"¡HAS GANADO!";
            [resultado runAction:moverResultado ];

            contador++;
            jugar= FALSE;
        }
    }else{
        NSLog(@"Has perdido");
        resultado.text =@"¡HAS PERDIDO!";
        [resultado runAction:moverResultado ];
        jugar = FALSE;

        
    }
    comparador++;
}



@end
