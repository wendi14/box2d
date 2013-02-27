package  
{
		import Box2D.Common.Math.*;
		import Box2D.Common.*;
		import Box2D.Collision.Shapes.*;
		import Box2D.Dynamics.*;
		import Box2D.Dynamics.Controllers.*;

	
	/**
	 * ...
	 * @author wdc
	 */
	public class customGravity extends b2GravityController 
	{
		static private var NEW_CONST:Number = -5;
		
		public function customGravity() 
		{
			
		}
 
	public override function Step(step:b2TimeStep):void{
		//Inlined
		var i:b2ControllerEdge = null;
		var body1:b2Body = null;
		var p1:b2Vec2 = null;
		var mass1:Number = 0;
		var j:b2ControllerEdge = null;
		var body2:b2Body = null;
		var p2:b2Vec2 = null;
		var dx:Number = 0;
		var dy:Number = 0;
		var r2:Number = 0;
		var f:b2Vec2 = null;
		if(invSqr){
			for(i=m_bodyList;i;i=i.nextBody){
				body1 = i.body;
				p1 = body1.GetWorldCenter();
				mass1 = body1.GetMass();
				//trace("mass1: " + mass1);
				
				
				f = new b2Vec2(0,NEW_CONST*mass1);
				body1.ApplyForce(f, p1);
				if (NEW_CONST > 5)
				{
					//NEW_CONST--;
				}
				for(j=m_bodyList;j!=i;j=j.nextBody){
					body2 = j.body;
					p2 = body2.GetWorldCenter()
					dx = p2.x - p1.x;
					dy = p2.y - p1.y;
					r2 = dx*dx+dy*dy;
					if(r2<Number.MIN_VALUE)
						continue;
					f = new b2Vec2(dx,dy);
					f.Multiply(G / r2 / Math.sqrt(r2) * mass1* body2.GetMass());
					//if(body1.IsAwake())
						//body1.ApplyForce(f,p1);
					f.Multiply(-1);
					//if(body2.IsAwake())
						//body2.ApplyForce(f,p2);
				}
			}
		}else{
			for(i=m_bodyList;i;i=i.nextBody){
				body1 = i.body;
				p1 = body1.GetWorldCenter();
				mass1 = body1.GetMass();
				for(j=m_bodyList;j!=i;j=j.nextBody){
					body2 = j.body;
					p2 = body2.GetWorldCenter()
					dx = p2.x - p1.x;
					dy = p2.y - p1.y;
					r2 = dx*dx+dy*dy;
					if(r2<Number.MIN_VALUE)
						continue;
					f = new b2Vec2(dx,dy);
					f.Multiply(G / r2 * mass1 * body2.GetMass());
					//if(body1.IsAwake())
						//body1.ApplyForce(f,p1);
					f.Multiply(-1);
					//if(body2.IsAwake())
						//body2.ApplyForce(f,p2);
				}
			}
		}
	}
}}