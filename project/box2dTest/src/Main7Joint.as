package  
{
	import Box2D.Collision.Shapes.b2MassData;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.Joints.b2DistanceJointDef;
	import Box2D.Dynamics.Joints.b2Joint;
	import Box2D.Dynamics.Joints.b2JointDef;
	import Box2D.Dynamics.Joints.b2RevoluteJoint;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import com.wdcgame.box2d.WDCBox2DFactory;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	
	/**
	 * ...
	 * @author wdc
	 */
	public class Main7Joint extends Sprite 
	{
		private var world:b2World;
		private var worldScale:Number = 30;
		private var b1:b2Body;
		private var pos:b2Vec2;
		private var ang:Number=1;
		private var ang2:Number=0;
		private var jointDef:b2RevoluteJointDef;
		private var joint:b2RevoluteJoint;
		
		private var dir:int = -1;
		public function Main7Joint() 
		{
			var gravity:b2Vec2 = new b2Vec2(0, 5);
			var sleep:Boolean = true;
			world = new b2World(gravity, sleep);
			floor()
			debugDraw();
			joint1()
			
			pos = new b2Vec2(300/worldScale, 10/worldScale);
			ang = 0;
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function joint1():void 
		{
			jointDef = new b2RevoluteJointDef();
			jointDef.lowerAngle = -Math.PI 
			jointDef.upperAngle = 0
			jointDef.enableLimit = true;
			
			b1 = WDCBox2DFactory.createBox(world, 300, 100, 10, 10, false);
			
			var b2:b2Body = WDCBox2DFactory.createBox(world, 200, 100, 20, 20, true);
			
			var m:b2MassData =new b2MassData()
			 b1.GetMassData(m);
			//m.mass=0
			//b1.SetMassData(m);
			//b1.SetFixedRotation(true);
			jointDef.Initialize(b1, b2, b2.GetWorldCenter());
			
			joint=world.CreateJoint(jointDef) as b2RevoluteJoint;
		 
			
			stage.addEventListener(MouseEvent.CLICK, onCCC);
		}
		
		private function onCCC(e:MouseEvent):void 
		{
			//b1.ApplyForce(new b2Vec2(10, 0), b1.GetWorldCenter());
			destroyJoint();
		}
		
		private function destroyJoint():void 
		{
			world.DestroyJoint(joint);;
		}
		
		private function onEnterFrame(e:Event):void 
		{
			var timeStep:Number = 1 / 15;
			world.Step(timeStep, 10, 10);
			
			world.ClearForces();
			
			for (var b:b2Body = world.GetBodyList(); b; b = b.GetNext())
			{
				if (b.GetUserData()=="remove") 
				{
					world.DestroyBody(b);
				}
			}
			world.DrawDebugData();
			//ang2+=0.1
			//
			 //ang*=Math.cos(ang2);
			//ang = 1.1*Math.cos(ang);
			//var xxx:Number = 100 +50 * Math.cos(ang);
			//var yyy:Number = 100 + 50* Math.sin(ang);
			//pos=new b2Vec2(xxx/worldScale,yyy/worldScale)
			//b1.SetPositionAndAngle(pos, ang);
			//joint.GetJointAngle()
			//trace("joint.GetJointAngle(): " + joint.GetJointSpeed());
			trace("joint.GetBodyA(): " + joint.GetBodyA());
			 
			if (joint.GetBodyA()==null) 
			{
				
				
				return
			}
			if (dir==-1&&joint.GetJointSpeed()<0) 
			{
				dir = 1;
				b1.ApplyForce(new b2Vec2(-10, 0), b1.GetWorldCenter());
			}else if (dir==1&& joint.GetJointSpeed()>0) 
			{
				dir = -1;
				b1.ApplyForce(new b2Vec2(10, 0), b1.GetWorldCenter());
			}
			 
		}
		
		private function debugDraw():void
		{
			var debugDraw:b2DebugDraw = new b2DebugDraw();
			var debugSprite:Sprite = new Sprite();
			addChild(debugSprite);
			debugDraw.SetSprite(debugSprite);
			debugDraw.SetDrawScale(worldScale);
			debugDraw.SetFlags(b2DebugDraw.e_shapeBit|b2DebugDraw.e_jointBit);
			debugDraw.SetFillAlpha(0.5);
			world.SetDebugDraw(debugDraw);
		}
		
		private function floor():void 
		{
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