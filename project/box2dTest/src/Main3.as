package  
{
	import Box2D.Collision.b2Bound;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author wdc
	 */
	public class Main3 extends Sprite 
	{
		private var world:b2World;
		private var worldScale:Number = 30;
		public function Main3() 
		{
			var gravity:b2Vec2 = new b2Vec2(0, 5);
			var sleep:Boolean = true;
			world = new b2World(gravity, sleep);
			
			debugDraw();
			
			brick(275,435,30,30);
			brick(365,435,30,30);
			brick(320,405,120,30);
			brick(320,375,60,30);
			brick(305,345,90,30);
			brick(320, 300, 120, 60);
			idol(320,242);

			floor();
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			stage.addEventListener(MouseEvent.CLICK,destroyBrick);
		}
		
		private function destroyBrick(e:MouseEvent):void 
		{
			var pX:Number = mouseX / worldScale;
			var pY:Number = mouseY / worldScale;
			world.QueryPoint(queryCallback, new b2Vec2(pX, pY));
		}
		
		private function queryCallback(fixture:b2Fixture):Boolean 
		{
			var touchedBody:b2Body = fixture.GetBody();
			trace("touchedBody: " + touchedBody);
			world.DestroyBody(touchedBody);
			return false;
		}
		
		private function idol(pX:Number, pY:Number):void 
		{
			var bodyDef:b2BodyDef=new b2BodyDef();
			bodyDef.position.Set(pX / worldScale, pY / worldScale);
			bodyDef.type = b2Body.b2_dynamicBody;
			var polygonShape:b2PolygonShape=new b2PolygonShape();
			polygonShape.SetAsBox(5/worldScale,20/worldScale);
			var fixtureDef:b2FixtureDef=new b2FixtureDef();
			fixtureDef.shape=polygonShape;
			fixtureDef.density=1;
			fixtureDef.restitution=0.4;
			fixtureDef.friction=0.5;
			var theIdol:b2Body = world.CreateBody(bodyDef);
			theIdol.CreateFixture(fixtureDef);
			
			var bW:Number=5/worldScale;
			var bH:Number=20/worldScale;
			var boxPos:b2Vec2=new b2Vec2(0,10/worldScale);
			var boxAngle:Number = -Math.PI / 4;
			
			polygonShape.SetAsOrientedBox(bW, bH, boxPos, boxAngle);
			fixtureDef.shape=polygonShape;
			theIdol.CreateFixture(fixtureDef);
			
			boxAngle=Math.PI/4;
			polygonShape.SetAsOrientedBox(bW,bH,boxPos,boxAngle);
			fixtureDef.shape=polygonShape;
			theIdol.CreateFixture(fixtureDef);
			
			var vertices:Vector.<b2Vec2>=new Vector.<b2Vec2>();
			vertices.push(new b2Vec2(-15/worldScale,
			-25/worldScale));
			vertices.push(new b2Vec2(0,-40/worldScale));
			vertices.push(new b2Vec2(15/worldScale,
			-25/worldScale));
			vertices.push(new b2Vec2(0,-10/worldScale));
			polygonShape.SetAsVector(vertices,4);
			fixtureDef.shape=polygonShape;
			theIdol.CreateFixture(fixtureDef);

		}
		private function onEnterFrame(e:Event):void 
		{
			var timeStep:Number = 1 / worldScale;
			world.Step(timeStep, 10, 10);
			
			world.ClearForces();
			world.DrawDebugData();
		}
		private function brick(px:int,py:int,w:Number,h:Number):void
		{
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set(px/worldScale, py/worldScale);
			bodyDef.type = b2Body.b2_dynamicBody;
			
			var polygonShape:b2PolygonShape = new b2PolygonShape();
			polygonShape.SetAsBox(w / 2 / worldScale, h / 2 / worldScale);
			
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = polygonShape;
			fixtureDef.density = 2;
			fixtureDef.restitution = 0.4;
			fixtureDef.friction = 0.5;	
			
			var theBrick:b2Body = world.CreateBody(bodyDef);
			theBrick.CreateFixture(fixtureDef);
			
		}
		private function debugDraw():void
		{
			var debugDraw:b2DebugDraw = new b2DebugDraw();
			var debugSprite:Sprite = new Sprite();
			addChild(debugSprite);
			debugDraw.SetSprite(debugSprite);
			debugDraw.SetDrawScale(worldScale);
			debugDraw.SetFlags(b2DebugDraw.e_shapeBit);
			debugDraw.SetFillAlpha(0.5);
			world.SetDebugDraw(debugDraw);
		}
		
		private function floor():void {
var bodyDef:b2BodyDef=new b2BodyDef();
bodyDef.position.Set(320/worldScale,465/worldScale);
var polygonShape:b2PolygonShape=new b2PolygonShape();
polygonShape.SetAsBox(320/worldScale,15/worldScale);
var fixtureDef:b2FixtureDef=new b2FixtureDef();
fixtureDef.shape=polygonShape;
fixtureDef.restitution=0.4;
fixtureDef.friction=0.5;
var theFloor:b2Body=world.CreateBody(bodyDef);
theFloor.CreateFixture(fixtureDef);
}
	}

}