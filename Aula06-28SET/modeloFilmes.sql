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

DROP TABLE IF EXISTS estudio;
CREATE TABLE estudio (
  codigo INTEGER PRIMARY KEY AUTOINCREMENT,
  nome TEXT NOT NULL,
  ano_fundacao INTEGER
);

INSERT INTO estudio (nome,ano_fundacao) Values 
    ("Paramount",1950),
    ("Disney",1955),
    ("Pixar",2000);

PRAGMA foreign_keys = ON;
 
DROP TABLE IF EXISTS filme;
CREATE TABLE filme (
  cod_filme INTEGER PRIMARY KEY AUTOINCREMENT,
  titulo TEXT NOT NULL,
  ano_lancamento INTEGER CHECK (ano_lancamento > 1888),
  duracao INTEGER CHECK (duracao > 0),
  sinopse TEXT,
  cod_estudio INTEGER NOT NULL,
  cod_class INTEGER NOT NULL,
  cod_pais INTEGER NOT NULL,
  FOREIGN KEY (cod_estudio) REFERENCES estudio (codigo),
  FOREIGN KEY (cod_class) REFERENCES classificacao (codigo),
  FOREIGN KEY (cod_pais) REFERENCES pais (codigo)
);

INSERT INTO filme (   
        titulo,ano_lancamento,duracao, 
        sinopse,cod_estudio,cod_class,cod_pais
    ) 
    VALUES 
        ("Titanic",1997,194,"Um filme rosmantico",2,3,2),
        ("Senhor dos Anéis - O Retorno do Rei",2003,220,"Um filme demorado",3,1,3);
