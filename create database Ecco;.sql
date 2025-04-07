CREATE DATABASE ecco;

CREATE TABLE produto(
    id INT PRIMARY KEY,
    produto VARCHAR(100) NOT NULL,
    tipo VARCHAR(100) NOT NULL,
    quant INT NOT NULL,
    valorunidade DECIMAL(6,2) NOT NULL,
    data_insercao DATE DEFAULT  CURRENT_DATE,
    data_alteracao DATE DEFAULT CURRENT_DATE );

-- Inserindo no banco de dados para teste.
INSERT INTO produto(id, produto,tipo,quant,valorunidade)
VALUES(1225,'Panela de Pressão','Ferro', 5,150.00),
      (1226,'Frigideira ','INOX', 20 , 100.00),
      (1227,'Prato','VIDRO', 15 ,15.00),
      (1228,'Garfo','Inox', 50,10.00),
      (1229,'Colher','Madeira', 8, 26.00);

SELECT id, produto, tipo, quant, valorunidade FROM produto;


UPDATE produto
SET tipo = 'Cerâmica'
WHERE quant = 5;

DELETE FROM produto
WHERE id = 1225;

CREATE TABLE simulacao(
idsimulacao INT PRIMARY KEY AUTO_INCREMENT,
quant INT NOT NULL,
id_estoque INT,
FOREIGN KEY(id_estoque) REFERENCES produto(id)
);
INSERT INTO simulacao(id_estoque, quant)
VALUES(1225, 5  ) --- id do produto comprado e quantidade na tela.


DELETE  FROM simulacao
WHERE idsimulacao;  -- Apaga toda a simulação da compra ao clicar em CANCELAR


CREATE TABLE Pagamento(
   idvenda INT PRIMARY KEY AUTO_INCREMENT,
   quant INT NOT NULL,
   valortotal INT  NOT NULL,
   valorcomdesconto INT NOT NULL,
   datacompra DATE DEFAULT CURRENT_DATE, 
   id_estoque INT,
   FOREIGN KEY(id_estoque) REFERENCES produto(id) ON DELETE CASCADE,
   id_simulacao INT,
   FOREIGN KEY(id_simulacao)  REFERENCES simulacao(idsimulacao) ON DELETE CASCADE
   );


INSERT INTO pagamento (quant, valortotal, valorcomdesconto, id_estoque)
VALUES(225,250.00,225);

SELECT * FROM Pagamento;
--- Insere na tabela Pagamento as Informações vindas da Simulacao. 
INSERT INTO Pagamento (quant, valortotal, valorcomdesconto, id_estoque, id_simulacao)
SELECT 
    s.quant,
    (s.quant * p.valorunidade) AS valortotal,
    ((s.quant * p.valorunidade) * 0.9) AS valorcomdesconto, -- Exemplo de 10% de desconto
    s.id_estoque,
    s.idsimulacao
FROM 
    simulacao s
JOIN 
    produto p ON s.id_estoque = p.id;


-- Iner Join para receber informações na tabela Pagamento.
SELECT 
    Pagamento.idvenda,
    Pagamento.valortotal,
    Pagamento.valorcomdesconto,
    Pagamento.datacompra,
    Pagamento.id_estoque AS id_produto, -- Exibe o ID do produto
    produto.produto AS nome_produto,   -- Exibe o nome do produto
    produto.tipo AS tipo_produto,      -- Exibe o tipo do produto
    simulacao.quant AS quantidade_simulada
FROM 
    Pagamento
JOIN 
    produto ON Pagamento.id_estoque = produto.id
JOIN 
    simulacao ON Pagamento.id_simulacao = simulacao.idsimulacao;



Lógica para calcular o total da compra.

SELECT  valorunidade
FROM produto;
Where Id ( id digitado no textbox id )
Valor = quant(valor digitado na textbox de quantidade) * valorunidade

Total = 0;

Total += Total + valor

Lógica para calcular o valor com desconto

ValorComDesconto = Total - desconto (valor digitado na textbox )

Lógica para calcular o Troco

Troco = Dinheiro (valor digitado na textbox) - ValorComDEsconto ou  Total.


