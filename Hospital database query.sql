Use DBHospital

CREATE TABLE Dzia�y 
(
[Numer dzia�u] nchar(10) IDENTITY(1, 1) PRIMARY KEY NOT NULL,
[Nazwa dzia�u] nchar(10) NOT NULL,
[Lokalizacja dzia�u] nchar(10) NOT NULL
)
CREATE TABLE [Wykaz wszystkich pracownik�w] 
(
[Numer pracownika] nchar(10) IDENTITY(1, 1) PRIMARY KEY NOT NULL,
Imi� varchar(25) NOT NULL,
[Drugie imi�] varchar(25) NULL,
Nazwisko varchar(50) NOT NULL,
[Numer dzia�u] nchar(10) FOREIGN KEY ,--NOT NULL,
[Stanowisko pracy] nchar(10) NOT NULL,
[Identyfikator szefa] nchar(10) NULL,
[Data zatrudnienia] nchar(10) NOT NULL,
Pensja nchar(10) NOT NULL
)
CREATE TABLE [Wykaz lekarzy] 
(
[Numer pracownika] nchar(10) FOREIGN KEY-- NOT NULL,
Imi� varchar(25)  NOT NULL,
[Drugie imi�] varchar(25) NULL,
Nazwisko varchar(50)  NOT NULL,
Specjalizacja char(10) NULL,
[PESEL PACJENTA] varchar(20) FOREIGN KEY NOT NULL,
[Numer dzia�u] nchar(10) FOREIGN KEY NOT NULL
)
CREATE TABLE [Wykaz wszystkich pacjent�w]
(
PESEL varchar(20) PRIMARY KEY NOT NULL,
Imi� nchar(10) NOT NULL,
[Drugie imi�] nchar(10) NULL,
Nazwisko nchar(10) NOT NULL,
[Data przyj�cia] nchar(10) NOT NULL,
[Data wypisania] nchar(10) NULL,
[Historia leczenia] Bit NULL
)

CREATE VIEW lokacje 
AS
SELECT [Lokalizacja dzia�u]
FROM Dzia�y

CREATE VIEW widok_pacjent_leczony_przez
AS
SELECT [Wykaz lekarzy].[PESEL PACJENTA], [Wykaz wszystkich pacjent�w].Imi�, [Wykaz wszystkich pacjent�w].Nazwisko,  [Wykaz lekarzy].[Numer pracownika], [Wykaz lekarzy].Imi�, [Wykaz lekarzy].Nazwisko 
FROM [Wykaz lekarzy]
INNER JOIN [Wykaz wszystkich pacjent�w]
ON [Wykaz lekarzy].[PESEL PACJENTA] = [Wykaz wszystkich pacjent�w].PESEL

Select * FROM lokacje

CREATE VIEW inni_pracownicy ([Numer pracownika], Imi�, Nazwisko, [Stanowisko pracy], Pensja)
AS
SELECT [Numer pracownika], Imi�, Nazwisko, [Stanowisko pracy], Pensja
FROM [Wykaz wszystkich pracownik�w]
WHERE [Stanowisko pracy] <> 'lekarz'
WITH CHECK OPTION

CREATE TRIGGER tr_po_usunieciu_wp
ON [Wykaz wszystkich pacjent�w]
AFTER DELETE
AS
	PRINT 'Usuni�to wskazane dane.';

CREATE TRIGGER tr_nr_prac
ON [Wykaz wszystkich pracownik�w]
INSTEAD OF INSERT, UPDATE
AS
BEGIN
	SELECT *
	FROM [Wykaz wszystkich pracownik�w]
	WHERE [Numer pracownika] = (select [Numer pracownika] FROM INSERTED)
END

