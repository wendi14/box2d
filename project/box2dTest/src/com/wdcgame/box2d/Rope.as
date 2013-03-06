package com.wdcgame.box2d 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	/**
	 * ...
	 * @author wdc
	 */
	public class Rope 
	{
		private var _world:b2World;
		private var _jj:MouseJoint;
		private var _b:b2Body;
		
		public function Rope() 
		{
			
		}
		 
		public function buildRope(world:b2World,_head:b2Body,n:Number):void 
		{
			_world = world;
			var joinDef:b2RevoluteJointDef = new b2RevoluteJointDef();
			var yy:int = 100;
			var preBody:b2Body=_head;
			var anchor:b2Vec2 = _head.GetWorldCenter();;
			for (var i:int = 0; i <n; i++) 
			{
				var item: b2Body = WDCBox2DFactory.createBox(world,300, yy, 2, 30, false);
				joinDef.Initialize(preBody, item, anchor);
				preBody = item;
				anchor = item.GetWorldCenter();
				_world.CreateJoint(joinDef);
				yy += 30;
				
				
			}trace("yy: " + yy);
			_b = WDCBox2DFactory.createCircle(_world,300,yy, 20, false);
			joinDef.Initialize(preBody, _b, anchor);
			_world.CreateJoint(joinDef);
			
			//_b.ApplyForce(new b2Vec2(500), _b.GetWorldCenter());
			
			//_jj = new MouseJoint(_world, _b, _b.GetWorldCenter());
			//_jj.SetTarget(new b2Vec2(0,6));
			//setTimeout(aaa, 4000);
		}
		
		public function get jj():MouseJoint 
		{
			return _jj;
		}
		
		public function get b():b2Body 
		{
			return _b;
		}
	}

}