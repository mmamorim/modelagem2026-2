DROP TABLE IF EXISTS Pais;
CREATE TABLE Pais (
	codigo	INTEGER PRIMARY KEY AUTOINCREMENT,
	nome	TEXT
);

INSERT INTO Pais (nome) VALUES ("Brasil");
INSERT INTO Pais (nome) VALUES ("USA");
INSERT INTO Pais (nome) VALUES ("França");
INSERT INTO Pais (nome) VALUES ("França");
INSERT INTO Pais (nome) VALUES ("Alemanha");

DROP TABLE IF EXISTS Genero;
CREATE TABLE Genero (
	codigo INTEGER PRIMARY KEY AUTOINCREMENT,
	nome TEXT NOT NULL
);

INSERT INTO Genero (nome) Values 
    ("Ação"), ("Suspense"), ("Terror"),
    ("Romance"), ("Comédia");

DROP TABLE IF EXISTS classificacao;
CREATE TABLE classificacao (
  codigo INTEGER PRIMARY KEY AUTOINCREMENT,
  descricao TEXT NOT NULL
);

INSERT INTO classificacao (descricao) Values 
    ("Livre"), ("16 anos"), ("18 anos");