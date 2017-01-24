CREATE TABLE [dbo].[Items] (
    [Id]         INT           IDENTITY (1, 1) NOT NULL,
    [Name]  NVARCHAR (50) NULL,
    [STR]   INT NULL,
    [AGI]      INT NULL,
    [INT]      INT NULL,
    [MoveSpeed]  INT      NULL,
    [Armor] INT          NULL,
    [AttackDamage] INT NULL, 
    [AttackSpeed] INT NULL, 
    [HitPoints] INT NULL, 
    [ManaPoints] INT NULL, 
    [Active] NVARCHAR(50) NULL, 
    [Passive] NVARCHAR(50) NULL, 
    [GoldCost] INT NULL, 
    CONSTRAINT [PK_Items] PRIMARY KEY CLUSTERED ([Id] ASC)
);

