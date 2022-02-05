package;

import flixel.addons.effects.FlxSkewedSprite;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
#if polymod
import polymod.format.ParseRules.TargetSignatureElement;
#end
import PlayState;

using StringTools;

class Note extends FlxSprite
{
	public var strumTime:Float = 0;

	public var mustPress:Bool = false;
	public var noteData:Int = 0;
	public var canBeHit:Bool = false;
	public var tooLate:Bool = false;
	public var wasGoodHit:Bool = false;
	public var prevNote:Note;
	public var modifiedByLua:Bool = false;
	public var noteType:Int = 0;
	public var sustainLength:Float = 0;
	public var isSustainNote:Bool = false;

	public var burning:Bool = false; //fire
	public var halo:Bool = false;    //halo/death
	public var warning:Bool = false; //warning sign

	public var noteScore:Float = 1;
	public static var mania:Int = 0;

	public static var noteyOff1:Array<Float> = [4, 0, 0, 0, 0, 0];
	public static var noteyOff2:Array<Float> = [0, 0, 0, 0, 0, 0];
	public static var noteyOff3:Array<Float> = [0, 0, 0, 0, 0, 0];

	public static var swagWidth:Float;
	public static var noteScale:Float;
	public static var pixelnoteScale:Float;
	public static var PURP_NOTE:Int = 0;
	public static var GREEN_NOTE:Int = 2;
	public static var BLUE_NOTE:Int = 1;
	public static var RED_NOTE:Int = 3;
	public static var tooMuch:Float = 30;
	public var rating:String = "shit";


	public function new(strumTime:Float, noteData:Int, ?prevNote:Note, ?sustainNote:Bool = false, ?noteType:Int = 0, ?_mustPress:Bool = false, ?inCharter:Bool = false)
	{
		

		swagWidth = 160 * 0.7; //factor not the same as noteScale
		noteScale = 0.7;
		pixelnoteScale = 1;
		mania = 0;

		if (PlayState.SONG.mania == 3)
			{
				swagWidth = 130 * 0.7;
				noteScale = 0.65;
				pixelnoteScale = 0.6;
				mania = 3;
			}

		super();

		if (prevNote == null)
			prevNote = this;
		this.noteType = noteType;
		this.prevNote = prevNote; 
		isSustainNote = sustainNote;





		x += 50;
		if (PlayState.SONG.mania == 2)
			{
				x -= tooMuch;
			}
		// MAKE SURE ITS DEFINITELY OFF SCREEN?
		y -= 2000;
		if (Main.editor)
			this.strumTime = strumTime;
		else 
			this.strumTime = Math.round(strumTime);

		if (this.strumTime < 0 )
			this.strumTime = 0;

		this.noteData = noteData % 9;

		var daStage:String = PlayState.curStage;

		//defaults if no noteStyle was found in chart
		var noteTypeCheck:String = 'normal';


      


		if (PlayState.SONG.noteStyle == null) {
			switch(PlayState.storyWeek) {case 6: noteTypeCheck = 'pixel';}
		} else {noteTypeCheck = PlayState.SONG.noteStyle;}



		switch(PlayState.SONG.song.toLowerCase())
		{	 
        /*case 'tutoriel' | 'raccounter' | 'dusting beats'| 'aixwtgqfdv' | 'back on' | 'diez minutos':
			frames = Paths.getSparrowAtlas('noteassets/Zellen Notes');
	
			animation.addByPrefix('greenScroll', 'green alone');
			animation.addByPrefix('redScroll', 'red alone');
			animation.addByPrefix('blueScroll', 'blue alone');
			animation.addByPrefix('purpleScroll', 'purple alone');
			animation.addByPrefix('whiteScroll', 'cyan alone');
	
			animation.addByPrefix('purpleholdend', 'purple tail');
			animation.addByPrefix('greenholdend', 'green tail');
			animation.addByPrefix('redholdend', 'red tail');
			animation.addByPrefix('blueholdend', 'blue tail');
			animation.addByPrefix('whiteholdend', 'cyan tail');
	
			animation.addByPrefix('purplehold', 'purple hold');
			animation.addByPrefix('greenhold', 'green hold');
			animation.addByPrefix('redhold', 'red hold');
			animation.addByPrefix('bluehold', 'blue hold');
			animation.addByPrefix('whitehold', 'cyan hold');

			setGraphicSize(Std.int(width * noteScale * 0.8));
			updateHitbox();
			antialiasing = true;
			if (noteType == 3)
			{
				loadGraphic(Paths.image('noteassets/notabug'));
				setGraphicSize(Std.int(width * noteScale));
				updateHitbox();
				antialiasing= true;
			}	
		case 'bugging realities' |'my turn':
			frames = Paths.getSparrowAtlas('noteassets/Glich Notes');
	
			animation.addByPrefix('greenScroll', 'green alone');
			animation.addByPrefix('redScroll', 'red alone');
			animation.addByPrefix('blueScroll', 'blue alone');
			animation.addByPrefix('purpleScroll', 'purple alone');
			animation.addByPrefix('whiteScroll', 'cyan alone');
	
			animation.addByPrefix('purpleholdend', 'purple tail');
			animation.addByPrefix('greenholdend', 'green tail');
			animation.addByPrefix('redholdend', 'red tail');
			animation.addByPrefix('blueholdend', 'blue tail');
			animation.addByPrefix('whiteholdend', 'cyan tail');
	
			animation.addByPrefix('purplehold', 'purple hold');
			animation.addByPrefix('greenhold', 'green hold');
			animation.addByPrefix('redhold', 'red hold');
			animation.addByPrefix('bluehold', 'blue hold');
			animation.addByPrefix('whitehold', 'cyan hold');

			setGraphicSize(Std.int(width * noteScale * 0.8));
			updateHitbox();
			antialiasing = true;
			if (noteType == 3)
			{
				loadGraphic(Paths.image('noteassets/notabug'));
				setGraphicSize(Std.int(width * noteScale));
				updateHitbox();
				antialiasing= true;
			}	
		case'zellen madness' | 'dusty fury' | 'mamdness':
			frames = Paths.getSparrowAtlas('noteassets/Hell Notes');
		
			animation.addByPrefix('greenScroll', 'green alone');
			animation.addByPrefix('redScroll', 'red alone');
			animation.addByPrefix('blueScroll', 'blue alone');
			animation.addByPrefix('purpleScroll', 'purple alone');
			animation.addByPrefix('whiteScroll', 'cyan alone');
	
			animation.addByPrefix('purpleholdend', 'purple tail');
			animation.addByPrefix('greenholdend', 'green tail');
			animation.addByPrefix('redholdend', 'red tail');
			animation.addByPrefix('blueholdend', 'blue tail');
			animation.addByPrefix('whiteholdend', 'cyan tail');
	
			animation.addByPrefix('purplehold', 'purple hold');
			animation.addByPrefix('greenhold', 'green hold');
			animation.addByPrefix('redhold', 'red hold');
			animation.addByPrefix('bluehold', 'blue hold');
			animation.addByPrefix('whitehold', 'cyan hold');

			setGraphicSize(Std.int(width * noteScale * 0.8));
			updateHitbox();
			antialiasing = true;
			if (noteType == 3)
			{
				loadGraphic(Paths.image('noteassets/notabug'));
				setGraphicSize(Std.int(width * noteScale));
				updateHitbox();
				antialiasing= true;
			}*/		
		default:
			frames = Paths.getSparrowAtlas('noteassets/shaggy/NOTE_assets');
			animation.addByPrefix('greenScroll', 'green0');
			animation.addByPrefix('redScroll', 'red0');
			animation.addByPrefix('blueScroll', 'blue0');
			animation.addByPrefix('purpleScroll', 'purple0');
			animation.addByPrefix('whiteScroll', 'white0');
			animation.addByPrefix('yellowScroll', 'yellow0');
			animation.addByPrefix('violetScroll', 'violet0');
			animation.addByPrefix('blackScroll', 'black0');
			animation.addByPrefix('darkScroll', 'dark0');

			animation.addByPrefix('purpleholdend', 'pruple end hold');
			animation.addByPrefix('greenholdend', 'green hold end');
			animation.addByPrefix('redholdend', 'red hold end');
			animation.addByPrefix('blueholdend', 'blue hold end');
			animation.addByPrefix('whiteholdend', 'white hold end');
			animation.addByPrefix('yellowholdend', 'yellow hold end');
			animation.addByPrefix('violetholdend', 'violet hold end');
			animation.addByPrefix('blackholdend', 'black hold end');
			animation.addByPrefix('darkholdend', 'dark hold end');

			animation.addByPrefix('purplehold', 'purple hold piece');
			animation.addByPrefix('greenhold', 'green hold piece');
			animation.addByPrefix('redhold', 'red hold piece');
			animation.addByPrefix('bluehold', 'blue hold piece');
			animation.addByPrefix('whitehold', 'white hold piece');
			animation.addByPrefix('yellowhold', 'yellow hold piece');
			animation.addByPrefix('violethold', 'violet hold piece');
			animation.addByPrefix('blackhold', 'black hold piece');
			animation.addByPrefix('darkhold', 'dark hold piece');

			setGraphicSize(Std.int(width * noteScale));
			updateHitbox();
			antialiasing = true;
			if (noteType == 1)
			{
				//add fire note assets here //zzz
			}
			else if (noteType == 2)
			{
				//add halo note assets here //zzz
			}
			else if (noteType == 3)
			{
				loadGraphic(Paths.image('noteassets/notabug'));
				setGraphicSize(Std.int(width * noteScale));
				updateHitbox();
				antialiasing= true;
			}
	    }
	    


		var frameN:Array<String> = ['purple', 'blue', 'green', 'red'];
		if (mania == 3) frameN = ['purple', 'blue', 'white', 'green', 'red'];

		x += swagWidth * noteData;
		animation.play(frameN[noteData] + 'Scroll');



		if (FlxG.save.data.downscroll && sustainNote) 
			flipY = true;

		if (isSustainNote && prevNote != null)
		{
			noteScore * 0.2;
			alpha = 0.6;

			x += width / 2 ;

			animation.play(frameN[noteData] + 'holdend');


			updateHitbox();

			x -= width / 2 ;



			if (prevNote.isSustainNote)
			{
				switch (prevNote.noteData)
				{
					case 0:
					//nada
				}
				prevNote.animation.play(frameN[prevNote.noteData] + 'hold');
				//prevNote.scale.y *= Conductor.stepCrochet / 100 * 1.5 * PlayState.SONG.speed * (0.7 / noteScale);


		
				if(FlxG.save.data.scrollSpeed != 1)
					prevNote.scale.y *= Conductor.stepCrochet / 100 * 1.5 * FlxG.save.data.scrollSpeed * (0.7 / noteScale);
				else
					prevNote.scale.y *= Conductor.stepCrochet / 100 * 1.5 * PlayState.SONG.speed * (0.7 / noteScale);
				prevNote.updateHitbox();
				// prevNote.setGraphicSize();
			}
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (mustPress)
		{
			// ass
			if (isSustainNote)
			{
				if (strumTime > Conductor.songPosition - (Conductor.safeZoneOffset * 1.5)
					&& strumTime < Conductor.songPosition + (Conductor.safeZoneOffset * 0.5))
					canBeHit = true;
				else
					canBeHit = false;
			}
			else
			{
				if (strumTime > Conductor.songPosition - Conductor.safeZoneOffset
					&& strumTime < Conductor.songPosition + Conductor.safeZoneOffset)
					canBeHit = true;
				else
					canBeHit = false;
			}

			if (strumTime < Conductor.songPosition - Conductor.safeZoneOffset * Conductor.timeScale && !wasGoodHit)
				tooLate = true;
		}
		else
		{
			canBeHit = false;

			if (strumTime <= Conductor.songPosition)
				wasGoodHit = true;
		}

		if (tooLate)
		{
			if (alpha > 0.3)
				alpha = 0.3;
		}
	}



}