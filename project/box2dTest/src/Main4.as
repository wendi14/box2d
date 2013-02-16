package  
{
	import Box2D.Collision.Shapes.b2CircleShape;
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
	
	/**
	 * ...
	 * @author wdc
	 */
	public class Main4 extends Sprite 
	{
		private var world:b2World;
		private var worldScale:Number = 30;
		private var sphereVector:Vector.<b2Body>;
		public function Main4() 
		{
			world = new b2World(new b2Vec2(0, 10), true);
			debugDraw();
			floor();
			sphereVector=new Vector.<b2Body>();
			for (var i:int = 0; i < 3; i++) 
			{
				sphereVector.push(sphere(170+i*150,410,40))
				
			}
			
			var force:b2Vec2 = new b2Vec2(0, -15);
			var forceByMass:b2Vec2 = force.Copy();
			forceByMass.Multiply(sphereVector[1].GetMass());
			
			var forceByMassByTime:b2Vec2 = forceByMass.Copy();
			forceByMassByTime.Multiply(worldScale);
			
			
			
			var sphereCenter:b2Vec2=sphereVector[0].GetWorldCenter();
			sphereVector[0].ApplyForce(forceByMassByTime, sphereCenter);
			sphereCenter=sphereVector[1].GetWorldCenter();
			sphereVector[1].ApplyImpulse(forceByMass,sphereCenter);
			sphereVector[2].SetLinearVelocity(force);
			
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void 
		{
			world.Step(1 / worldScale, 10, 10);
			world.ClearForces();
			world.DrawDebugData();
			
			var maxHeight:Number;
var currHeight:Number;
			var outHeight:Number;
world.Step(1/30,10,10);
for (var i:int=0; i<3; i++) {
maxHeight=sphereVector[i].GetUserData();
currHeight=sphereVector[i].GetPosition().y*worldScale;
maxHeight=Math.min(maxHeight,currHeight);
sphereVector[i].SetUserData(maxHeight);
outHeight=sphereVector[i].GetUserData();
trace("Sphere "+i+":"+Math.round(outHeight));
}
trace("---------------");

		}
		
		
		private function sphere(pX:int, pY:int, r:Number):b2Body 
		{
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set(pX / worldScale, pY / worldScale);
			bodyDef.type = b2Body.b2_dynamicBody;
			bodyDef.userData = pY;
			
			var circleShape:b2CircleShape = new b2CircleShape(r/worldScale);
			
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = circleShape;
			fixtureDef.density = 1;
			fixtureDef.restitution = 0.4;
			fixtureDef.friction = 0.5;
			var the:b2Body = world.CreateBody(bodyDef);
			the.CreateFixture(fixtureDef);
			return the;
			
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