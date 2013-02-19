package  
{
	import Box2D.Dynamics.b2ContactImpulse;
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.Contacts.b2Contact;
	
	/**
	 * ...
	 * @author wdc
	 */
	public class customContact extends b2ContactListener 
	{
		private const KILLBRICK:Number=22;
private const KILLPIG:Number=5;
		public function customContact() 
		{
			
		}
		
		override public function PostSolve(contact:b2Contact, impulse:b2ContactImpulse):void 
		{
			//super.PostSolve(contact, impulse);
			
			var fixtureA:b2Fixture = contact.GetFixtureA();
			var fixtureB:b2Fixture = contact.GetFixtureB();
			
			var dataA:String = fixtureA.GetBody().GetUserData();
			//trace("dataA: " + dataA);
			
			var dataB:String = fixtureB.GetBody().GetUserData();
			
			var force:Number = impulse.normalImpulses[0];
			//trace("force: " + force);
			
			switch (dataA) 
			{
				case "pig"	:
					if (force>KILLPIG) 
					{
						fixtureA.GetBody().SetUserData("remove");
					}
				break;
				case "brick":
					if (force>KILLBRICK) 
					{
						fixtureA.GetBody().SetUserData("remove");
					}
				break;
				default:
					
				break;
			}
			
			switch (dataB) 
			{
				case "pig"	:
					if (force>KILLPIG) 
					{
						fixtureB.GetBody().SetUserData("remove");
					}
				break;
				case "brick":
					if (force>KILLBRICK) 
					{
						fixtureB.GetBody().SetUserData("remove");
					}
				break;
				default:
					
				break;
			}
		}
	}

}