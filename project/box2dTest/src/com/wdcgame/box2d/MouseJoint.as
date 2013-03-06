package com.wdcgame.box2d 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.Joints.b2JointDef;
	import Box2D.Dynamics.Joints.b2MouseJoint;
	import Box2D.Dynamics.Joints.b2MouseJointDef;
	/**
	 * ...
	 * @author wdc
	 */
	public class MouseJoint 
	{
		private var _bodyA:b2Body;
		private var _bodyB:b2Body;
		private var _world:b2World;
		private var _joint:b2MouseJoint;
		private var _mouseToWorld:b2Vec2;
		
		public function MouseJoint(world:b2World ,bodyB:b2Body,mouseToWorld:b2Vec2) 
		{
			_mouseToWorld = mouseToWorld;
			_world = world;
			_bodyB = bodyB;
			 
			
			init()
		}
 
		private function init():void 
		{
			var _jointDef:b2MouseJointDef = new  b2MouseJointDef();
			_jointDef.bodyA = _world.GetGroundBody();
			_jointDef.bodyB = _bodyB;
			_jointDef.maxForce = 10000 * _bodyB.GetMass();
			_jointDef.target=_mouseToWorld
			
			_joint=_world.CreateJoint(_jointDef   ) as b2MouseJoint;
		}
		
		/**
		 * 每移动一下的时候调用
		 * @param	ww
		 */
		public function SetTarget(ww:b2Vec2):void 
		{
			_joint.SetTarget(ww);
		}
		
		public function DestroyJoint( ):void 
		{
			_world.DestroyJoint(_joint);
		}
		
	}

}