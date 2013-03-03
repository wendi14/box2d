package  
{
	import Box2D.Collision.b2RayCastInput;
	import Box2D.Collision.b2RayCastOutput;
	import Box2D.Collision.Shapes.b2MassData;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.Joints.b2Joint;
	import Box2D.Dynamics.Joints.b2RevoluteJoint;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import com.wdcgame.box2d.WDCBox2DFactory;
	import com.wdcgame.box2d.WDCBox2dFlashBasic;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.setTimeout;
	
	/**
	 * ...
	 * @author wdc
	 */
	public class Game extends WDCBox2dFlashBasic 
	{
		private var _levelMc:MovieClip;
		private var _head:b2Body;
		private var _stone:b2Body;
		private var _floor:b2Body;
		private var joint:b2RevoluteJoint;
		private var dir:int= 1;
		private var sss:Number=0.6;
		private var _stoneMc:MovieClip;
		private var startPoint:b2Vec2;
		private var endPoint:b2Vec2;
		private var _bomb:b2Body;
		 
		
		public function Game() 
		{
			 super(new b2Vec2(0,9));
			 
			 //var b:b2Body = createBox(100, 100, 100, 100, false);
			 
			 //var floor:b2Body = createBox(stage.stageWidth / 2, stage.stageHeight - 10 / 2, stage.stageWidth, 10, true);
			 
			 initLevel()
		}
		
		override protected function init():void 
		{
			super.init();
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			if (joint) 
			{
				_world.DestroyJoint(joint);
			}
			_stone.ApplyImpulse(new b2Vec2(0, -3), _stone.GetWorldCenter());
			joint = null;
			
			
			createNewStone();
			
		}
		private function initLevel():void 
		{
			_levelMc = new aa();
			 for (var i:int = 0; i < _levelMc.numChildren; i++) 
			{
				 
				var mc:MovieClip = _levelMc.getChildAt(i) as MovieClip;
				if (mc is head)
				{
					 _head = createCircle(mc.x,mc.y,mc.width/2,true);
				}else if (mc is floor) 
				{
					_floor = createBox(mc.x, mc.y, mc.width, mc.height, true);;
				}else if (mc is stone) 
				{
					_stoneMc = mc;
					 
				}else if (mc is b1) 
				{
					var _block:b2Body = createBox(mc.x, mc.y, mc.width, mc.height, false);;
					
				}else if (mc is bomb) 
				{
					_bomb=createCircle(mc.x,mc.y,mc.width/2,false);
				}
				
			}
			
		
			createNewStone();
			
			setTimeout(checkBomb,1000)
		}
		
		private function checkBomb():void 
		{
			startPoint = _bomb.GetWorldCenter();
			trace("startPoint: " + startPoint.x*30,startPoint.y*30);
			
			
			endPoint = new b2Vec2(startPoint.x + 4, startPoint.y);
			trace("endPoint: " + endPoint.x*30,endPoint.y*30);
			
			
			var inputRay:b2RayCastInput = new b2RayCastInput(startPoint, endPoint);
			inputRay.maxFraction = 1;
			 var outRay:b2RayCastOutput = new b2RayCastOutput();
			for (var b:b2Body=_world.GetBodyList(); b; b=b.GetNext()) 
			{
				if (b == _bomb|| b.GetFixtureList()==null  ) continue;
				 
				 var bo:Boolean = b.GetFixtureList().GetShape().RayCast(outRay, inputRay, b.GetTransform());
				 
				 if (bo)
				 {
					 var px:Number = inputRay.p1.x + outRay.fraction * (inputRay.p2.x - inputRay.p1.x);
					 trace("p: " + px*WDCBox2DFactory.WORLD_SCALE);
					 
				 }
				
			}
		}
		
		private function createNewStone():void 
		{
			_stone = createBox(_stoneMc.x, _stoneMc.y, _stoneMc.width, _stoneMc.height, false);;
			
			var jointDef :b2RevoluteJointDef= new b2RevoluteJointDef();
			jointDef.lowerAngle = -Math.PI 
			jointDef.upperAngle = 0
			//jointDef.enableMotor = true;
			//jointDef.motorSpeed = -sss;
			//jointDef.maxMotorTorque=10
			//jointDef.enableLimit = true;
			
			jointDef.Initialize(_head, _stone, _head.GetWorldCenter());
			
			joint = _world.CreateJoint(jointDef) as b2RevoluteJoint;
			
			
			
		}
		
		override protected function onRender():void 
		{
			
			if (joint)
			{
				swingStone();
			}
			
			
			 
		}
		
		private function swingStone():void 
		{
			if(joint.GetJointAngle() == -Math.PI / 4)
			{
				trace("xxx")
			}
			if (dir==-1&&joint.GetJointSpeed()<0) 
			{
				dir = 1;
				//joint.SetMotorSpeed(-sss);
				_stone.ApplyImpulse(new b2Vec2(_stone.GetMass()*40, 0), _stone.GetWorldCenter());
				//trace("-_stone.GetMass()*10: " + -_stone.GetMass() * 1110);
				
			}else if (dir==1&& joint.GetJointSpeed()>0) 
			{
				dir = -1;
				//joint.SetMotorSpeed(sss);
				_stone.ApplyImpulse(new b2Vec2(-_stone.GetMass()*40, 0), _stone.GetWorldCenter());
			}
		}
		
	}

}