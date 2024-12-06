CREATE DATABASE Joins_pII_Ex6;

USE Joins_pII_Ex6;

CREATE TABLE modelo (
    codMod INT PRIMARY KEY,
    nome VARCHAR(40),
    Marca VARCHAR(50)
);

INSERT INTO modelo VALUES 
(1, 'Mercedes Benz', 'Mercedes'),
(2, 'Mercedes Benz G 63 AMG Wallpaper', 'Mercedes'),
(3, 'Rolls-Royce Ghost V 12 by MANSORY NR.733', 'Rolls-Royce');

CREATE TABLE cliente (
    NIF INT PRIMARY KEY,
    Nome VARCHAR(20),
    dtNasc DATE
);

INSERT INTO cliente VALUES 
(1, 'Jorge Almeida', '2006-10-01'),
(2, 'Roberto Batista', '2005-09-16'),
(3, 'Paulo Catigas', '2004-08-07');

CREATE TABLE veiculo (
    Matricula VARCHAR(8) PRIMARY KEY,
    Modelo_codMod INT,
    Cliente_NIF INT,
    cor VARCHAR(10),
    FOREIGN KEY (Modelo_codMod) REFERENCES modelo(codMod),
    FOREIGN KEY (Cliente_NIF) REFERENCES cliente(NIF)
);

INSERT INTO veiculo VALUES 
('21-FC-41', 1, 1, 'Branco'),
('09-PO-IU', 2, 2, 'Cinza'),
('MA-JI-L0', 3, 3, 'Preto');

CREATE TABLE estacionamento (
    Num INT PRIMARY KEY,
    Piso INT,
    Capacidade INT
);

INSERT INTO estacionamento VALUES
(1, 1, 334),
(2, 2, 336),
(3, 3, 338);

CREATE TABLE estaciona (
    cod INT PRIMARY KEY,
    estacionamento_Num INT,
    veiculo_Matricula VARCHAR(8),
    dataEntrada DATE,
    dataSaida DATE,
    horaEntrada TIME,
    horaSaida TIME,
    FOREIGN KEY (estacionamento_Num) REFERENCES estacionamento(Num),
    FOREIGN KEY (veiculo_Matricula) REFERENCES veiculo(Matricula)
);

INSERT INTO estaciona VALUES 
(1, 1, '21-FC-41', '2024-04-16', '2024-04-20', '10:20:00', '10:50:00'),
(2, 2, '09-PO-IU', '2024-07-22', '2024-08-01', '07:06:00', '11:33:00'),
(3, 3, 'MA-JI-L0', '2024-04-16', '2024-04-16', '10:20:00', '18:08:00');


#A
SELECT veiculo_Matricula, Nome
FROM estaciona
JOIN veiculo ON estaciona.veiculo_Matricula = veiculo.Matricula
JOIN cliente ON veiculo.Cliente_NIF = cliente.NIF;

#B
SELECT NIF, Nome, veiculo_Matricula
FROM estaciona
JOIN veiculo ON estaciona.veiculo_Matricula = veiculo.Matricula
JOIN cliente ON veiculo.Cliente_NIF = cliente.NIF
WHERE estaciona.veiculo_Matricula = '21-FC-41';

#C
SELECT cod, veiculo_Matricula, cor
FROM estaciona
JOIN veiculo ON estaciona.veiculo_Matricula = veiculo.Matricula
WHERE estaciona.cod = 1;

#D
SELECT cod, veiculo_Matricula, dtNasc
FROM estaciona
JOIN veiculo ON estaciona.veiculo_Matricula = veiculo.Matricula
JOIN cliente ON veiculo.Cliente_NIF = cliente.NIF
WHERE estaciona.cod = 1;

#E
SELECT horaEntrada, horaSaida, veiculo_Matricula
FROM estaciona
WHERE estaciona.veiculo_Matricula = 'MA-JI-L0';

#F
SELECT NIF, Nome, Cliente_NIF
FROM cliente
JOIN veiculo ON cliente.NIF = veiculo.Cliente_NIF
WHERE cliente.NIF = 1;

#G
SELECT veiculo_Matricula, cor, horaEntrada, horaSaida
FROM estaciona
JOIN veiculo ON estaciona.veiculo_Matricula = veiculo.Matricula
WHERE veiculo.cor = 'Preto';

#H
SELECT cliente.Nome, modelo.Marca, estacionamento.Piso
FROM estaciona
JOIN veiculo ON estaciona.veiculo_Matricula = veiculo.Matricula
JOIN cliente ON veiculo.Cliente_NIF = cliente.NIF
JOIN modelo ON veiculo.Modelo_codMod = modelo.codMod
JOIN estacionamento ON estaciona.estacionamento_Num = estacionamento.Num
WHERE estacionamento.Piso = 2;

#I
SELECT NIF
FROM estaciona
JOIN veiculo ON estaciona.veiculo_Matricula = veiculo.Matricula
JOIN cliente ON veiculo.Cliente_NIF = cliente.NIF
WHERE estaciona.estacionamento_Num = 3;

#J