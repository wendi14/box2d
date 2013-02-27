package  
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.Joints.b2DistanceJointDef;
	import Box2D.Dynamics.Joints.b2Joint;
	import Box2D.Dynamics.Joints.b2MouseJoint;
	import Box2D.Dynamics.Joints.b2MouseJointDef;
	import Box2D.Dynamics.Joints.b2RevoluteJoint;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import com.wdcgame.box2d.WDCBox2DFactory;
	import com.wdcgame.box2d.WDCBox2dFlashBasic;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author wdc
	 */
	public class RotateJoint extends WDCBox2dFlashBasic 
	{
		 
		private var mouseJoint:b2MouseJoint;
		private var _distanceJointDef:b2RevoluteJointDef;
		public function RotateJoint() 
		{
			super(null);
		}
		
		override protected function init():void 
		{
			var b1:b2Body=createBox(200, 200, 50, 50, false);
			var b2:b2Body = createBox(200, 100, 30, 30, true);
			
			_distanceJointDef = new b2RevoluteJointDef();
			_distanceJointDef.Initialize(b1, b2, b2.GetWorldCenter());
			//_distanceJointDef.bodyA = b1;
			//_distanceJointDef.bodyB =b2
			//_distanceJointDef.localAnchorB = b2.GetWorldCenter()
			//_distanceJointDef.localAnchorA = b1.GetWorldCenter();
			
			_distanceJointDef.enableMotor = true;
			_distanceJointDef.motorSpeed = 5;
			_distanceJointDef.maxMotorTorque = 100;
			_distanceJointDef.lowerAngle = -Math.PI;
			_distanceJointDef.upperAngle = Math.PI;
			_distanceJointDef.enableLimit = true;
			//_distanceJointDef.length = 100/WDCBox2DFactory.WORLD_SCALE;
			
			_world.CreateJoint(_distanceJointDef);
			var floor:b2Body = createBox(stage.stageWidth / 2, stage.stageHeight - 5, stage.stageWidth, 10, true);
			 stage.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown)
			super.init();
		}
		private function onMouseDown(e:MouseEvent):void 
		{
			_world.QueryPoint(queryCallBack, mouseToWorld());
		}
		
		private function mouseToWorld():b2Vec2 
		{
			return new b2Vec2(mouseX/WDCBox2DFactory.WORLD_SCALE, mouseY/WDCBox2DFactory.WORLD_SCALE)
		}
		
		private function queryCallBack(fix:b2Fixture):Boolean 
		{
			trace("queryCallBack: " + queryCallBack);
			var body:b2Body = fix.GetBody();
			var joinDef:b2MouseJointDef = new b2MouseJointDef();
			joinDef.bodyA = _world.GetGroundBody();
			joinDef.bodyB = body;
			joinDef.target = mouseToWorld();
			joinDef.maxForce = 1000 * body.GetMass();
			mouseJoint = _world.CreateJoint(joinDef) as b2MouseJoint;
			stage.addEventListener(MouseEvent.MOUSE_MOVE,moveJoint);
			stage.addEventListener(MouseEvent.MOUSE_UP,killJoint);
			return false;
			
		}
		
		private function moveJoint(e:MouseEvent):void 
		{
			mouseJoint.SetTarget(mouseToWorld());
		}
		
		private function killJoint(e:MouseEvent):void 
		{
			_world.DestroyJoint(mouseJoint);
		}
 
 
		
	}

}