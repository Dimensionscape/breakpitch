import com.haxepunk.Sfx;
import com.haxepunk.HXP;

class Audio
{
	private static var sounds = {};
	
	public static var music:Sfx;
	public static var musicVolume:Float;
	public static var rain:Sfx;
	public static var rainVolume:Float;
	
	public static function init ():Void
	{
		music = new Sfx("music/music.mp3");
		//music.loop();
		musicVolume = 0.0;

		rain = new Sfx("music/rain.mp3");
		rain.loop();
		rain.volume = rainVolume = 0;

		//FP.stage.addEventListener(Event.ACTIVATE, focusGain);
		//FP.stage.addEventListener(Event.DEACTIVATE, focusLost);
	}
	
	public static function update ():Void
	{
		music.volume = musicVolume;

		rainVolume = HXP.clamp(rainVolume, 0, 1);
		rain.volume = rainVolume;
		rainVolume *= 0.95;
	}
	
	public static function play (sound:String):Void
	{
		if (! Reflect.field(sounds, sound)) {
			Reflect.setField(sounds, sound, new Sfx("sfx/" + sound + ".mp3"));
		}
		
		if (Reflect.field(sounds, sound)) {
			Reflect.field(sounds, sound).play();
		}
		
		if (sound == "win") {
			musicVolume = 0.2;
			HXP.tween(Audio, {musicVolume: 1.0}, 1.0);
		}
	}
	
	/*private static function focusGain (e:Event):void
	{
		if (! music.playing) music.resume();
	}
	
	private static function focusLost (e:Event):void
	{
		if (Main.touchscreen || FP.stage.displayState != StageDisplayState.FULL_SCREEN) {
			music.stop();
		}
	}*/
}
