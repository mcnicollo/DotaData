CREATE TABLE [dbo].[Heros] (
    [Id]         INT           IDENTITY (1, 1) NOT NULL,
    [Name]  NVARCHAR (50) NULL,
    [HitPoints]   INT NULL,
    [STR]      INT NULL,
    [AGI]      INT NULL,
    [INT]  INT      NULL,
    [MoveSpeed] INT          NULL,
    [BaseArmor] INT NULL, 
    [BaseDamage] BIGINT NULL, 
    [BaseAttackSpeed] BIGINT NULL, 
    [Abilities] INT NULL, 
    [Gold] INT NULL, 
    CONSTRAINT [PK_Heros] PRIMARY KEY CLUSTERED ([Id] ASC)
);

