-- ============================================================
-- Catálogo de Filmes — Modelo Físico (SQLite)
-- Script de criação das tabelas
-- ============================================================

-- Ativa a verificação de chaves estrangeiras (no SQLite vem desligada
-- por padrão e precisa ser ativada a cada conexão)
PRAGMA foreign_keys = ON;

-- ------------------------------------------------------------
-- Limpeza: remove as tabelas na ordem inversa das dependências
-- (permite rodar o script várias vezes durante a aula)
-- ------------------------------------------------------------
DROP TABLE IF EXISTS comentario;
DROP TABLE IF EXISTS favorito;
DROP TABLE IF EXISTS usuario;
DROP TABLE IF EXISTS direcao;
DROP TABLE IF EXISTS atuacao;
DROP TABLE IF EXISTS filme_genero;
DROP TABLE IF EXISTS profissional;
DROP TABLE IF EXISTS filme;
DROP TABLE IF EXISTS estudio;
DROP TABLE IF EXISTS genero;
DROP TABLE IF EXISTS classificacao;
DROP TABLE IF EXISTS pais;

-- ------------------------------------------------------------
-- 1) Tabelas independentes (sem chave estrangeira)
-- ------------------------------------------------------------
CREATE TABLE pais (
  cod_pais INTEGER PRIMARY KEY,
  nome TEXT NOT NULL
);

CREATE TABLE classificacao (
  cod_class INTEGER PRIMARY KEY,
  descricao TEXT NOT NULL
);

CREATE TABLE genero (
  cod_genero INTEGER PRIMARY KEY,
  nome TEXT NOT NULL
);

CREATE TABLE estudio (
  cod_estudio INTEGER PRIMARY KEY,
  nome TEXT NOT NULL,
  ano_fundacao INTEGER
);

-- ------------------------------------------------------------
-- 2) Relacionamentos 1:N (adição de coluna) e restrições de domínio
-- ------------------------------------------------------------
CREATE TABLE filme (
  cod_filme INTEGER PRIMARY KEY,
  titulo TEXT NOT NULL,
  ano_lancamento INTEGER CHECK (ano_lancamento > 1888),
  duracao INTEGER CHECK (duracao > 0),
  sinopse TEXT,
  cod_estudio INTEGER NOT NULL,
  cod_class INTEGER NOT NULL,
  cod_pais INTEGER NOT NULL,
  FOREIGN KEY (cod_estudio) REFERENCES estudio (cod_estudio),
  FOREIGN KEY (cod_class) REFERENCES classificacao (cod_class),
  FOREIGN KEY (cod_pais) REFERENCES pais (cod_pais)
);

CREATE TABLE profissional (
  cod_prof INTEGER PRIMARY KEY,
  nome TEXT NOT NULL,
  nascimento TEXT,  -- formato 'AAAA-MM-DD'
  cod_pais INTEGER,
  FOREIGN KEY (cod_pais) REFERENCES pais (cod_pais)
);

-- ------------------------------------------------------------
-- 3) Relacionamentos N:N (tabela própria, chave primária composta)
-- ------------------------------------------------------------
CREATE TABLE filme_genero (
  cod_filme INTEGER,
  cod_genero INTEGER,
  PRIMARY KEY (cod_filme, cod_genero),
  FOREIGN KEY (cod_filme) REFERENCES filme (cod_filme),
  FOREIGN KEY (cod_genero) REFERENCES genero (cod_genero)
);

CREATE TABLE atuacao (
  cod_filme INTEGER,
  cod_prof INTEGER,
  personagem TEXT,
  PRIMARY KEY (cod_filme, cod_prof),
  FOREIGN KEY (cod_filme) REFERENCES filme (cod_filme),
  FOREIGN KEY (cod_prof) REFERENCES profissional (cod_prof)
);

CREATE TABLE direcao (
  cod_filme INTEGER,
  cod_prof INTEGER,
  PRIMARY KEY (cod_filme, cod_prof),
  FOREIGN KEY (cod_filme) REFERENCES filme (cod_filme),
  FOREIGN KEY (cod_prof) REFERENCES profissional (cod_prof)
);

-- ------------------------------------------------------------
-- 4) Usuários, favoritos e comentários
-- ------------------------------------------------------------
CREATE TABLE usuario (
  cod_usuario INTEGER PRIMARY KEY,
  nome TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  data_cadastro TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE favorito (
  cod_usuario INTEGER,
  cod_filme INTEGER,
  data_adicao TEXT DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (cod_usuario, cod_filme),
  FOREIGN KEY (cod_usuario) REFERENCES usuario (cod_usuario),
  FOREIGN KEY (cod_filme) REFERENCES filme (cod_filme)
);

CREATE TABLE comentario (
  cod_coment INTEGER PRIMARY KEY,
  texto TEXT,
  nota INTEGER NOT NULL CHECK (nota BETWEEN 1 AND 5),
  data_public TEXT DEFAULT CURRENT_TIMESTAMP,
  cod_usuario INTEGER NOT NULL,
  cod_filme INTEGER NOT NULL,
  FOREIGN KEY (cod_usuario) REFERENCES usuario (cod_usuario),
  FOREIGN KEY (cod_filme) REFERENCES filme (cod_filme)
);
