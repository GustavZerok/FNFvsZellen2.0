package;

import openfl.display.Preloader.DefaultPreloader;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';	
	var curMood:String = '';	

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var zellenp:FlxSprite;
	var infrap:FlxSprite;
	var irenep:FlxSprite;
	var bfp:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();


		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;
		if (PlayState.SONG.song.toLowerCase() == 'tutoriel'||PlayState.SONG.song.toLowerCase() == 'raccounter'|| PlayState.SONG.song.toLowerCase() == 'dusting beats'||PlayState.SONG.song.toLowerCase() == 'bugging realities'|| PlayState.SONG.song.toLowerCase()=='my turn'||PlayState.SONG.song.toLowerCase() == 'zellen madness'|| PlayState.SONG.song.toLowerCase()=='dusty fury' ||PlayState.SONG.song.toLowerCase()=='aixwtgqfdv')
		{
			hasDialog = true;
			box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
			box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
			box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
			box.width =200;
			box.height =200;
			box.x = -100;
			box.y = 375;
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;
		
		//irene y gf
		irenep = new FlxSprite(775, 180);
		irenep.frames = Paths.getSparrowAtlas('portraits/IrenesPortraits');
		irenep.animation.addByPrefix('NEUTRAL', 'irenecb', 24, false);
		irenep.animation.addByPrefix('CB', 'irenecb', 24, false);
		irenep.animation.addByPrefix('SB', 'irenesb', 24, false);
		irenep.animation.addByPrefix('GF', 'gf', 24, false);
		irenep.scrollFactor.set();
		irenep.antialiasing = true;
		irenep.setGraphicSize(Std.int(irenep.width * 0.8));
		add(irenep);
		irenep.visible = false;

		//infrazellens
		infrap = new FlxSprite(25, 70);
		infrap.frames = Paths.getSparrowAtlas('portraits/InfraPortraits');
		infrap.animation.addByPrefix('NEUTRAL', 'Infra', 24, false);
		infrap.animation.addByPrefix('INFRA', 'Infra', 24, false);
		infrap.animation.addByPrefix('DUST', 'Dust', 24, false);
		infrap.animation.addByPrefix('NEON', 'Neon', 24, false);
		infrap.scrollFactor.set();
		infrap.antialiasing = true;
		infrap.setGraphicSize(Std.int(infrap.width * 0.8));
		add(infrap);
		infrap.visible = false;

		//zellen
		zellenp = new FlxSprite(625, 100);
		zellenp.frames = Paths.getSparrowAtlas('portraits/ZellenPortraits');
		zellenp.animation.addByPrefix('NEUTRAL', 'bf', 24, false);
		zellenp.animation.addByPrefix('DERECHA', 'bf', 24, false);		
		zellenp.animation.addByPrefix('IZQUIERDA', 'Zellen', 24, false);
		zellenp.scrollFactor.set();
		zellenp.antialiasing = true;
		zellenp.setGraphicSize(Std.int(zellenp.width * 0.8));
		add(zellenp);
		zellenp.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'raccounter'|| PlayState.SONG.song.toLowerCase() == 'dusting-beats')
		{
		zellenp.x -= 600;
		} 		

		//bf
		bfp = new FlxSprite(800, 140);
		bfp.frames = Paths.getSparrowAtlas('portraits/BFPortraits');
		bfp.animation.addByPrefix('NEUTRAL', 'BF_Dialogue_A', 24, false);
		bfp.animation.addByPrefix('NORMAL', 'BF_Dialogue_A', 24, false);		
		bfp.animation.addByPrefix('MIEDO', 'BF_Dialogue_B', 24, false);
		bfp.scrollFactor.set();
		bfp.antialiasing = true;
		bfp.setGraphicSize(Std.int(bfp.width * 0.8));
		add(bfp);
		bfp.visible = false;		

		
		box.animation.play('normalOpen');
		box.updateHitbox();
		add(box);
	
		box.screenCenter(X);

		//handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));
		//add(handSelect);
		

		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'Pixel Arial 11 Bold';
		dropText.color = 0xFFD89494;
		add(dropText);

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'Pixel Arial 11 Bold';
		swagDialogue.color = 0xFF3F2021;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{

        /*if (zellenp.animation.curAnim.name == 'DERECHA')
			zellenp.x -= 600;*/	

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (PlayerSettings.player1.controls.ACCEPT && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;


					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						bfp.visible = false;
						irenep.visible = false;
						infrap.visible = false;
						zellenp.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();

		switch (curCharacter)
		{
			case 'zellen':
				bfp.visible = false;
				infrap.visible = false;
				irenep.visible = false;
				zellenp.animation.play(curMood, true);
				if (!zellenp.visible)
				{
					zellenp.visible = true;
				}
			case 'infra':
				bfp.visible = false;
				zellenp.visible = false;
				irenep.visible = false;
				infrap.animation.play(curMood, true);
				if (!infrap.visible)
				{
					infrap.visible = true;
				}
			case 'irene':
				bfp.visible = false;
				infrap.visible = false;
				zellenp.visible = false;
				irenep.animation.play(curMood, true);
				if (!irenep.visible)
				{
					irenep.visible = true;
				}		
			case 'bf':
				zellenp.visible = false;
				infrap.visible = false;
				irenep.visible = false;
				bfp.animation.play(curMood, true);
				if (!bfp.visible)
				{
					bfp.visible = true;
				}
		}	

		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curMood = splitName[0];
		if (curMood == '')
		curMood = 'NEUTRAL'; // Just for cleaner logic
		curCharacter = splitName[1];
		var dialogue:String = dialogueList[0].substr(splitName[1].length + 2 + splitName[0].length).trim();
		dialogueList[0] = dialogue;
	}
}
