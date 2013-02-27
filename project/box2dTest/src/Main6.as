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
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author wdc
	 */
	public class Main6 extends Sprite 
	{
		private var world:b2World;
		private var worldScale:Number = 30;
		private var sphereVector:Vector.<b2Body>;
		
		private var theBird:Sprite=new Sprite();
private var slingX:int=100;
private var slingY:int=250;
private var slingR:int = 75;


		public function Main6() 
		{
			var gravity:b2Vec2 = new b2Vec2(0, 5);
			var sleep:Boolean = true;
			world = new b2World(gravity, sleep);
			
			debugDraw();
			floor();
			brick(402,431,140,36);
brick(544,431,140,36);
brick(342,396,16,32);
brick(604,396,16,32);
brick(416,347,16,130);
brick(532,347,16,130);
brick(474,273,132,16);
brick(474,257,32,16);
brick(445,199,16,130);
brick(503,199,16,130);
brick(474,125,58,16);
brick(474,100,32,32);
brick(474,67,16,32);
brick(474,404,64,16);
brick(450,363,16,64);
brick(498,363,16,64);
brick(474, 322, 64, 16);

brick(174, 11, 64, 16);
brick2(174, 122, 64, 16);

pig(474, 322, 16);


var slingCanvas:Sprite=new Sprite();
slingCanvas.graphics.lineStyle(1,0xffffff);
slingCanvas.graphics.drawCircle(0,0,slingR);
addChild(slingCanvas);slingCanvas.x=slingX;
slingCanvas.y=slingY;
	theBird.graphics.lineStyle(1,0xfffffff);
theBird.graphics.beginFill(0xffffff);
theBird.graphics.drawCircle(0,0,15);
addChild(theBird);
theBird.x=slingX;
theBird.y=slingY;		
			theBird.addEventListener(MouseEvent.MOUSE_DOWN,birdClick);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			world.SetContactListener(new customContact());
			stage.addEventListener(MouseEvent.CLICK,destroyBrick);
		}
		
		private function birdClick(e:MouseEvent):void 
		{
			stage.addEventListener(MouseEvent.MOUSE_MOVE,birdMove);
			stage.addEventListener(MouseEvent.MOUSE_UP,birdRelease);
			theBird.removeEventListener(MouseEvent.MOUSE_DOWN,birdClick);
		}
		
		private function birdMove(e:MouseEvent):void 
		{
			theBird.x = mouseX;
			theBird.y = mouseY;
			
			var distanceX:Number = theBird.x - slingX;
			var distanceY:Number = theBird.y - slingY;
			var dis:Number = Math.sqrt(distanceX * distanceX + distanceY * distanceY);
			if (dis>slingR) 
			{
				var birdAngle:Number = Math.atan2(distanceY, distanceX);
				theBird.x = slingX + slingR*Math.cos(birdAngle);
				theBird.y = slingY + slingR*Math.sin(birdAngle);
			}
		}
		
		private function birdRelease(e:MouseEvent):void 
		{
			
			var distanceX:Number=theBird.x-slingX;
var distanceY:Number=theBird.y-slingY;
var velocityX:Number=distanceX*-1/5;
var velocityY:Number=distanceY*-1/5;
var birdVelocity:b2Vec2 = new b2Vec2(velocityX, velocityY);


			stage.removeEventListener(MouseEvent.MOUSE_MOVE,birdMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, birdRelease);
			
			var sphereX:Number = theBird.x / worldScale;
			var sphereY:Number = theBird.y / worldScale;
			var r:Number =15 / worldScale;
			
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set(sphereX, sphereY);
			bodyDef.type = b2Body.b2_dynamicBody;
			
			var bodyShape:b2CircleShape = new b2CircleShape(r);
			
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = bodyShape;
			fixtureDef.density = 4;
			fixtureDef.friction = 0.5;
			fixtureDef.restitution = 0.4;
			
			var body:b2Body = world.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);
			body.SetLinearVelocity(birdVelocity);
			removeChild(theBird);
			
			
			
		}
		
		private function pig(pX:int,pY:int,r:Number):void
		{
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set(pX/worldScale, pY/worldScale);
			bodyDef.type = b2Body.b2_dynamicBody;
			bodyDef.userData = "pig";
			
			var bodyShape:b2CircleShape = new b2CircleShape(r/worldScale);
			
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = bodyShape;
			fixtureDef.density = 1;
			fixtureDef.friction = 0.5;
			fixtureDef.restitution = 0.4;
			
			var body:b2Body = world.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);
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
			
			for (var b:b2Body = world.GetBodyList(); b; b = b.GetNext())
			{
				if (b.GetUserData()=="remove") 
				{
					world.DestroyBody(b);
				}
			}
			world.DrawDebugData();
		}
		private function brick(px:int,py:int,w:Number,h:Number):void
		{
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set(px/worldScale, py/worldScale);
			bodyDef.type = b2Body.b2_dynamicBody;
			bodyDef.userData = "brick";
			
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
		
		private function brick2(px:int,py:int,w:Number,h:Number):void
		{
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set(px/worldScale, py/worldScale);
			bodyDef.type = b2Body.b2_kinematicBody;
			bodyDef.userData = "brick";
			
			var polygonShape:b2PolygonShape = new b2PolygonShape();
			polygonShape.SetAsBox(w / 2 / worldScale, h / 2 / worldScale);
			
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = polygonShape;
			fixtureDef.density = 2;
			fixtureDef.restitution = 0.4;
			fixtureDef.friction = 0.5;	
			
			
			var theBrick:b2Body = world.CreateBody(bodyDef);
			theBrick.CreateFixture(fixtureDef);
			
			theBrick.setga 
			//theBrick.ApplyImpulse(new b2Vec2(0, 11),theBrick.GetWorldCenter());
			
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