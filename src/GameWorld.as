package  
{
	import flash.events.Event;
	import flash.geom.Point;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	import playerio.*;
	
	/**
	 * ...
	 * @author Richard Marks
	 */
	public class GameWorld extends World 
	{
		
		public function GameWorld() { }
		
		private var updateFunc:Function = UpdateGameNotConnected;
		private var renderFunc:Function = RenderGameNotConnected;
		
		private var statusTxt:Text;
		
		private function ConnectWithPlayerIO(gameID:String, userName:String, userAuth:String = "", connectionID:String = "public"):void
		{
			PlayerIO.connect(FP.stage, gameID, connectionID, userName, userAuth, OnSuccessfulConnection, OnFailedConnection);
		}
		
		private function OnSuccessfulConnection(client:Client):void
		{
			trace("Connected to Player.IO");
			statusTxt.text = "Status: Connected";
			updateFunc = UpdateGameConnected;
			renderFunc = RenderGameConnected;
			
		}
		
		private function OnFailedConnection(error:PlayerIOError):void
		{
			trace("An error has occurred:", error);
			statusTxt.text = "Status: Error: " + error;
			updateFunc = UpdateGameNotConnected;
			renderFunc = RenderGameNotConnected;
		}
		
		override public function begin():void 
		{
			Text.size = 8;
			statusTxt = new Text("Status: Not Connected");
			ConnectWithPlayerIO("explore-idknbmfl4eegyrqbrqlpsq", "RichardMarks");
			
			super.begin();
		}
		
		// --- inline state management --
		// state: gameconnected
		
		private function UpdateGameConnected():void 
		{ 
		}
		
		private function RenderGameConnected():void 
		{ 
			statusTxt.render(new Point, FP.camera);
		}
		
		// state: gamenotconnected
		
		private function UpdateGameNotConnected():void 
		{ 
		}
		
		private function RenderGameNotConnected():void 
		{ 
			statusTxt.render(new Point, FP.camera);
		}
		
		override public function update():void { updateFunc(); super.update(); }
		override public function render():void { renderFunc(); super.render(); }
	}
}