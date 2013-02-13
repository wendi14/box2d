package 
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author wdc
	 */
	public class Main extends Sprite 
	{
		private var world:b2World;
		private var worldScale:Number = 30;
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var gravity:b2Vec2 = new b2Vec2(0, 9.8);
			var sleep:Boolean = true;
			world = new b2World(gravity, sleep);
			
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set(320 / worldScale, 30 / worldScale);
			bodyDef.type = b2Body.b2_dynamicBody;
			
			var circleShape:b2CircleShape = new b2CircleShape(25/worldScale);
			
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = circleShape;
			
			var theBall:b2Body = world.CreateBody(bodyDef);
			theBall.CreateFixture(fixtureDef);
			
			bodyDef.position.Set(320 / worldScale, 470 / worldScale);
			bodyDef.type = b2Body.b2_staticBody;
			var polygonShape:b2PolygonShape = new b2PolygonShape();
			polygonShape.SetAsBox(320 / worldScale, 10 / worldScale);
			fixtureDef.shape = polygonShape;
			var theFlooer:b2Body = world.CreateBody(bodyDef);
			theFlooer.CreateFixture(fixtureDef);
			
			
			var debugDraw:b2DebugDraw = new b2DebugDraw();
			var debugSprite:Sprite = new Sprite();
			addChild(debugSprite);
			debugDraw.SetSprite(debugSprite);
			debugDraw.SetDrawScale(worldScale);
			debugDraw.SetFlags(b2DebugDraw.e_shapeBit);
			debugDraw.SetFillAlpha(0.5);
			world.SetDebugDraw(debugDraw);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void 
		{
			var timeStep:Number = 1 / worldScale;
			world.Step(timeStep, 10, 10);
			
			world.ClearForces();
			world.DrawDebugData();
		}
		
	}
	
}