CREATE DATABASE Sales;
GO

USE Sales;
GO

CREATE TABLE Clients (
    ClientID INT PRIMARY KEY,
    ClientName NVARCHAR(50)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    ClientID INT FOREIGN KEY REFERENCES Clients(ClientID)
);

INSERT INTO Clients VALUES (1, 'Client1'), (2, 'Client2');
INSERT INTO Orders VALUES (101, '2024-01-18', 1), (102, '2024-01-19', 2);

BACKUP DATABASE Sales TO DISK = 'C:\Path\To\Backup\SalesFullBackup.bak' WITH FORMAT;
GO

INSERT INTO Clients VALUES (3, 'Client3');
INSERT INTO Orders VALUES (103, '2024-01-20', 3);

UPDATE Clients SET ClientName = 'UpdatedClient' WHERE ClientID = 1;
UPDATE Orders SET OrderDate = '2024-01-21' WHERE OrderID = 101;

DELETE FROM Clients WHERE ClientID = 2;
DELETE FROM Orders WHERE OrderID = 102;


BACKUP DATABASE Sales TO DISK = 'C:\Path\To\Backup\SalesDiffBackup.bak' WITH DIFFERENTIAL;
GO

INSERT INTO Clients VALUES (4, 'Client4');
INSERT INTO Orders VALUES (104, '2024-01-22', 4);

UPDATE Clients SET ClientName = 'UpdatedClient2' WHERE ClientID = 3;
UPDATE Orders SET OrderDate = '2024-01-23' WHERE OrderID = 103;

DELETE FROM Clients WHERE ClientID = 1;
DELETE FROM Orders WHERE OrderID = 101;

BACKUP LOG Sales TO DISK = 'C:\Path\To\Backup\SalesLogBackup.trn';
GO

RESTORE DATABASE Sales FROM DISK = 'C:\Path\To\Backup\SalesFullBackup.bak' WITH REPLACE;

RESTORE DATABASE Sales FROM DISK = 'C:\Path\To\Backup\SalesDiffBackup.bak' WITH NORECOVERY;

RESTORE LOG Sales FROM DISK = 'C:\Path\To\Backup\SalesLogBackup.trn' WITH RECOVERY;
