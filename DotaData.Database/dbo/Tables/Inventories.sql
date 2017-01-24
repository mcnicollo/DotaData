CREATE TABLE [dbo].[Inventories] (
    [Id]         INT           IDENTITY (1, 1) NOT NULL,
    [heroId]  INT NULL,
    [Slot1]   INT NULL,
    [Slot2]      INT NULL,
    [Slot3]      INT NULL,
    [Slot4]  INT      NULL,
    [Slot5] INT          NULL,
    [Slot6] INT NULL, 
    CONSTRAINT [PK_Inventories] PRIMARY KEY CLUSTERED ([Id] ASC),
	CONSTRAINT [FK_Inventories_Hero] FOREIGN KEY ([heroId]) REFERENCES [Heros]([Id]),
	CONSTRAINT [FK_Inventories_Slot1] FOREIGN KEY ([Slot1]) REFERENCES [Items]([Id]),
	CONSTRAINT [FK_Inventories_Slot2] FOREIGN KEY ([Slot2]) REFERENCES [Items]([Id]),
	CONSTRAINT [FK_Inventories_Slot3] FOREIGN KEY ([Slot3]) REFERENCES [Items]([Id]),
	CONSTRAINT [FK_Inventories_Slot4] FOREIGN KEY ([Slot4]) REFERENCES [Items]([Id]),
	CONSTRAINT [FK_Inventories_Slot5] FOREIGN KEY ([Slot5]) REFERENCES [Items]([Id]),
	CONSTRAINT [FK_Inventories_Slot6] FOREIGN KEY ([Slot6]) REFERENCES [Items]([Id])
);

