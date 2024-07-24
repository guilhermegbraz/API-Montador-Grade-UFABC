CREATE TABLE centro_academico
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) UNIQUE,
    email VARCHAR(50)
);

CREATE TABLE curso
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    campus VARCHAR(5),
    nome VARCHAR(100),
    id_centro_academico INT,
    CHECK (campus LIKE '%SA%' OR campus LIKE '%SBC%'),
    FOREIGN KEY (id_centro_academico) REFERENCES centro_academico (id)
);

CREATE TABLE projeto_pedagogico
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    resolucao VARCHAR(150),
    ano varchar(4)
);

CREATE TABLE categoria
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    sigla VARCHAR(10),
    descricao VARCHAR(255)
);

CREATE TABLE disciplina
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(150),
    sigla VARCHAR(20) UNIQUE,
    tpi VARCHAR(10),
    ementa TEXT
);

CREATE TABLE disciplina_curso
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_disciplina INT,
    id_curso INT,
    id_categoria INT,
    id_projeto_pedagogico INT,
    FOREIGN KEY (id_disciplina) REFERENCES disciplina (id),
    FOREIGN KEY (id_curso) REFERENCES curso (id),
    FOREIGN KEY (id_categoria) REFERENCES categoria (id),
    FOREIGN KEY (id_projeto_pedagogico) REFERENCES projeto_pedagogico (id),
    UNIQUE (id_disciplina, id_curso, id_categoria, id_projeto_pedagogico)
);

CREATE TABLE professor
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    sobrenome VARCHAR(100),
    area VARCHAR(255),
    id_centro_academico INT,
    FOREIGN KEY (id_centro_academico) REFERENCES centro_academico (id)
);

CREATE TABLE periodo
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    periodo VARCHAR(6) UNIQUE
);

CREATE TABLE aluno
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    sobrenome VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    ra VARCHAR(20) UNIQUE
);

CREATE TABLE aluno_curso
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_aluno INT,
    id_curso INT,
    ano_ingresso INT,
    turno VARCHAR(10) NOT NULL,
    CHECK (turno IN ('MATUTINO', 'NOTURNO')),
    FOREIGN KEY (id_aluno) REFERENCES aluno (id),
    FOREIGN KEY (id_curso) REFERENCES curso (id),
    UNIQUE (id_aluno, id_curso, ano_ingresso, turno)
);

CREATE TABLE historico
(
    id_aluno INT PRIMARY KEY NOT NULL,
    id_disciplina INT NOT NULL,
    id_professor_teoria INT NOT NULL,
    id_professor_pratica INT,
    id_periodo INT NOT NULL,
    conceito CHAR(1),
    turno VARCHAR(10) NOT NULL,
    CHECK (conceito IN ('A', 'B', 'C', 'D', 'F', 'O', '-')),
    CHECK (turno IN ('MATUTINO', 'NOTURNO')),
    FOREIGN KEY (id_aluno) REFERENCES aluno (id),
    FOREIGN KEY (id_disciplina) REFERENCES disciplina (id),
    FOREIGN KEY (id_professor_teoria) REFERENCES professor (id),
    FOREIGN KEY (id_professor_pratica) REFERENCES professor (id),
    FOREIGN KEY (id_periodo) REFERENCES periodo (id),
    UNIQUE (id_aluno, id_disciplina, id_professor_teoria, id_professor_pratica, id_periodo)
);

CREATE TABLE oferta_matricula
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    modalidade VARCHAR(20) NOT NULL,
    id_professor_teoria INT ,
    id_professor_pratica INT,
    id_disciplina INT NOT NULL,
    id_periodo INT NOT NULL,
    turno VARCHAR(10) NOT NULL,
    CHECK (modalidade IN ('matricula', 'ajuste', 'reajuste')),
    CHECK (turno IN ('MATUTINO', 'NOTURNO')),
    FOREIGN KEY (id_professor_teoria) REFERENCES professor (id),
    FOREIGN KEY (id_professor_pratica) REFERENCES professor (id),
    FOREIGN KEY (id_disciplina) REFERENCES disciplina (id),
    FOREIGN KEY (id_periodo) REFERENCES periodo (id),
    UNIQUE (id_disciplina, id_professor_teoria, id_professor_pratica, id_periodo, modalidade, turno)
);
