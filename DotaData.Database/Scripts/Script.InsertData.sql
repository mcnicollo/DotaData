/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
  insert into Heros values ('Io',180,17,14,23,295,-2,30.5,0.58,7,625);
  insert into Heros values ('Lion',180,16,15,22,290,-1,30,0.58,4,625);
  insert into Heros values ('Morphling',180,19,24,17,285,-2,17,0.62,5,625);

  insert into Items values ('Blink Dagger',0,0,0,0,0,0,0,0,0,'Blink 1200 units','None',2250);
  insert into Items values ('Power Treads(STR)',8,0,0,45,0,9,25,171,0,'Switch Attribute','None',1350);
  insert into Items values ('Power Treads(AGI)',0,8,0,45,1.26,9,34,0,0,'Switch Attribute','None',1350);
  insert into Items values ('Power Treads(INT)',0,0,8,45,0,9,25,0,117,'Switch Attribute','None',1350);
  insert into Items values ('Daedalus',0,0,0,0,0,81,0,0,0,'None','Critical Strike',5520);