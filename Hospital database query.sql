Use DBHospital

CREATE TABLE Dzia³y 
(
[Numer dzia³u] nchar(10) IDENTITY(1, 1) PRIMARY KEY NOT NULL,
[Nazwa dzia³u] nchar(10) NOT NULL,
[Lokalizacja dzia³u] nchar(10) NOT NULL
)
CREATE TABLE [Wykaz wszystkich pracowników] 
(
[Numer pracownika] nchar(10) IDENTITY(1, 1) PRIMARY KEY NOT NULL,
Imiê varchar(25) NOT NULL,
[Drugie imiê] varchar(25) NULL,
Nazwisko varchar(50) NOT NULL,
[Numer dzia³u] nchar(10) FOREIGN KEY ,--NOT NULL,
[Stanowisko pracy] nchar(10) NOT NULL,
[Identyfikator szefa] nchar(10) NULL,
[Data zatrudnienia] nchar(10) NOT NULL,
Pensja nchar(10) NOT NULL
)
CREATE TABLE [Wykaz lekarzy] 
(
[Numer pracownika] nchar(10) FOREIGN KEY-- NOT NULL,
Imiê varchar(25)  NOT NULL,
[Drugie imiê] varchar(25) NULL,
Nazwisko varchar(50)  NOT NULL,
Specjalizacja char(10) NULL,
[PESEL PACJENTA] varchar(20) FOREIGN KEY NOT NULL,
[Numer dzia³u] nchar(10) FOREIGN KEY NOT NULL
)
CREATE TABLE [Wykaz wszystkich pacjentów]
(
PESEL varchar(20) PRIMARY KEY NOT NULL,
Imiê nchar(10) NOT NULL,
[Drugie imiê] nchar(10) NULL,
Nazwisko nchar(10) NOT NULL,
[Data przyjêcia] nchar(10) NOT NULL,
[Data wypisania] nchar(10) NULL,
[Historia leczenia] Bit NULL
)

CREATE VIEW lokacje 
AS
SELECT [Lokalizacja dzia³u]
FROM Dzia³y

CREATE VIEW widok_pacjent_leczony_przez
AS
SELECT [Wykaz lekarzy].[PESEL PACJENTA], [Wykaz wszystkich pacjentów].Imiê, [Wykaz wszystkich pacjentów].Nazwisko,  [Wykaz lekarzy].[Numer pracownika], [Wykaz lekarzy].Imiê, [Wykaz lekarzy].Nazwisko 
FROM [Wykaz lekarzy]
INNER JOIN [Wykaz wszystkich pacjentów]
ON [Wykaz lekarzy].[PESEL PACJENTA] = [Wykaz wszystkich pacjentów].PESEL

Select * FROM lokacje

CREATE VIEW inni_pracownicy ([Numer pracownika], Imiê, Nazwisko, [Stanowisko pracy], Pensja)
AS
SELECT [Numer pracownika], Imiê, Nazwisko, [Stanowisko pracy], Pensja
FROM [Wykaz wszystkich pracowników]
WHERE [Stanowisko pracy] <> 'lekarz'
WITH CHECK OPTION

CREATE TRIGGER tr_po_usunieciu_wp
ON [Wykaz wszystkich pacjentów]
AFTER DELETE
AS
	PRINT 'Usuniêto wskazane dane.';

CREATE TRIGGER tr_nr_prac
ON [Wykaz wszystkich pracowników]
INSTEAD OF INSERT, UPDATE
AS
BEGIN
	SELECT *
	FROM [Wykaz wszystkich pracowników]
	WHERE [Numer pracownika] = (select [Numer pracownika] FROM INSERTED)
END

