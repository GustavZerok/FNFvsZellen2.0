package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';

	public var holdTimer:Float = 0;

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;

		var tex:FlxAtlasFrames;
		antialiasing = true;

		switch (curCharacter)
		{
			case 'gf':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('characters/GF_assets');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');


			case 'Irene':
				tex = Paths.getSparrowAtlas('characters/Irene');
				frames = tex;
				animation.addByIndices('singUP', 'Irene dancing Beat', [2], "", 24, false);
				animation.addByIndices('danceLeft', 'Irene dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24);
				animation.addByIndices('danceRight', 'Irene dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24);
	
				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);

				playAnim('danceRight');



			case 'bf':
				var tex = Paths.getSparrowAtlas('characters/BOYFRIEND', 'shared');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance', 24);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead confirm", 24);
				animation.addByPrefix('deathConfirm', "BF Dead Loop", 24, false);

			    addOffset('idle', 0, 100);
			    addOffset("singUP", -110, 75);
			    addOffset("singLEFT", -88, 81);
			    addOffset("singRIGHT", -106, 90);
			    addOffset("singDOWN", -150, 90);
			    addOffset("singUPmiss", -125, 120);
			    addOffset("singLEFTmiss", -87, 91);
			    addOffset("singRIGHTmiss", -150, 120);
			    addOffset("singDOWNmiss", -130, 95);
				addOffset('firstDeath', 30, 70);
				addOffset('deathLoop', 25, 70);
				addOffset('deathConfirm', 25, 70);

				playAnim('idle');

				flipX = true;


			case 'bf-pixel':
				frames = Paths.getSparrowAtlas('characters/bfPixel');
				animation.addByPrefix('idle', 'BF IDLE', 24);
				animation.addByPrefix('singUP', 'BF UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'BF LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'BF RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'BF DOWN NOTE', 24, false);
				animation.addByPrefix('singUPmiss', 'BF UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF DOWN MISS', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				playAnim('idle');

				flipX = true;
			case 'bf-pixel-dead':
				frames = Paths.getSparrowAtlas('characters/bfPixelsDEAD');
				animation.addByPrefix('singUP', "BF Dies pixel", 24, false);
				animation.addByPrefix('firstDeath', "BF Dies pixel", 24, false);
				animation.addByPrefix('deathLoop', "Retry Loop", 24);
				animation.addByPrefix('deathConfirm', "RETRY CONFIRM", 24, false);
				animation.play('firstDeath');

				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				playAnim('firstDeath');

				flipX = true;




			case 'Zellen':
				var tex = Paths.getSparrowAtlas('characters/Zellen_assets');
				frames = tex;
				animation.addByPrefix('idle', 'ZELLEN IDLE', 24);
				animation.addByPrefix('singUP', 'ZELLEN UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'ZELLEN LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'ZELLEN RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'ZELLEN DOWN NOTE', 24, false);
	
				addOffset('idle', 0, 100);
				addOffset("singUP", 5, 80);
				addOffset("singRIGHT", -40, 80);
				addOffset("singLEFT", 50, 90);
				addOffset("singDOWN", 10, 95);
	
				playAnim('idle');
	
			case 'IZellen':
			    frames = Paths.getSparrowAtlas('characters/IZellen_assets');
				animation.addByPrefix('idle', 'IZellen idle dance', 24);
				animation.addByPrefix('singUP', 'IZellen note up', 24, false);
				animation.addByPrefix('singRIGHT', 'IZellen note right', 24, false);
				animation.addByPrefix('singDOWN', 'IZellen note down', 24, false);
				animation.addByPrefix('singLEFT', 'IZellen note left', 24, false);
	
				addOffset('idle',0,130);
				addOffset("singUP", 0, 110);
				addOffset("singRIGHT", 0, 80);
				addOffset("singLEFT", 50, 100);
				addOffset("singDOWN", 40, 110);
		
				playAnim('idle');
	
			case 'Dust':
				frames = Paths.getSparrowAtlas('characters/Dust_assets');
				animation.addByPrefix('idle', 'Dust idle dance', 24);
				animation.addByPrefix('singUP', 'Dust note up', 24, false);
				animation.addByPrefix('singRIGHT', 'Dust note right', 24, false);
				animation.addByPrefix('singDOWN', 'Dust note down', 24, false);
				animation.addByPrefix('singLEFT', 'Dust note left', 24, false);
	
				addOffset('idle',0,130);
				addOffset("singUP", 0, 120);
				addOffset("singRIGHT", -10, 140);
				addOffset("singLEFT", 110, 140);
				addOffset("singDOWN", 80, 50);
		
				playAnim('idle');
	
			case 'Neon':
				frames = Paths.getSparrowAtlas('characters/Neon_assets');
				animation.addByPrefix('idle', 'idle dance neon', 24);
				animation.addByPrefix('singUP', 'note up neon', 24, false);
				animation.addByPrefix('singRIGHT', 'note right neon', 24, false);
				animation.addByPrefix('singDOWN', 'note down neon', 24, false);
				animation.addByPrefix('singLEFT', 'note left neon', 24, false);
				animation.addByPrefix('grito', 'grito neon', 24);
			
				addOffset('idle',0,0);
				addOffset("singUP", -100, 0);
				addOffset("singRIGHT", 15, 15);
				addOffset("singLEFT", 280, 50);
				addOffset("singDOWN", 120, 120);
				addOffset("grito",335,225);
			
				playAnim('idle');

			case 'irenegps':
				tex = Paths.getSparrowAtlas('characters/Irene');
				frames = tex;
				animation.addByPrefix('idle', 'Irene dancing Beat', 24);
				animation.addByPrefix('singLEFT', 'irene left', 24, false);
				animation.addByPrefix('singRIGHT', 'Irene right', 24, false);
				animation.addByPrefix('singUP', 'irene up', 24, false);
				animation.addByPrefix('singDOWN', 'irene down', 24, false);
		
				addOffset('idle',0, 0);
				addOffset("singUP", 95, -50);
				addOffset("singRIGHT", -13, -42);
				addOffset("singLEFT", -18, -50);
				addOffset("singDOWN", 0, -41);
		
				playAnim('idle');		
		}

		dance();

		if (isPlayer)
		{
			flipX = !flipX;

			// Doesn't flip for BF, since his are already in the right place???
			if (!curCharacter.startsWith('bf'))
			{
				// var animArray
				var oldRight = animation.getByName('singRIGHT').frames;
				animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
				animation.getByName('singLEFT').frames = oldRight;

				// IF THEY HAVE MISS ANIMATIONS??
				if (animation.getByName('singRIGHTmiss') != null)
				{
					var oldMiss = animation.getByName('singRIGHTmiss').frames;
					animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
					animation.getByName('singLEFTmiss').frames = oldMiss;
				}
			}
		}
	}

	override function update(elapsed:Float)
	{
		if (!curCharacter.startsWith('bf'))
		{
			if (animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}

			var dadVar:Float = 4;

			if (curCharacter == 'dad')
				dadVar = 6.1;
			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001)
			{
				
				dance();
				holdTimer = 0;
			}
		}

		switch (curCharacter)
		{
			case 'gf':
				if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished)
					playAnim('danceRight');
		}

		super.update(elapsed);
	}

	private var danced:Bool = false;

	/**
	 * FOR GF DANCING SHIT
	 */
	public function dance()
	{
		if (!debugMode)
		{
			switch (curCharacter)
			{
				case 'gf':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'Irene':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;
	
						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}				
				default:
					playAnim('idle');	
			}
		}
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName))
		{
			offset.set(daOffset[0], daOffset[1]);
		}
		else
			offset.set(0, 0);

		if (curCharacter == 'gf')
		{
			if (AnimName == 'singLEFT')
			{
				danced = true;
			}
			else if (AnimName == 'singRIGHT')
			{
				danced = false;
			}

			if (AnimName == 'singUP' || AnimName == 'singDOWN')
			{
				danced = !danced;
			}
		}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}
