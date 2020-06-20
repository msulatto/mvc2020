

-- Copiando estrutura para tabela dbkirby.categoria
CREATE TABLE IF NOT EXISTS `categoria` (
  `id_cat` int(11) NOT NULL AUTO_INCREMENT,
  `nome_cat` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `disponivel` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id_cat`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Copiando dados para a tabela dbkirby.categoria: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` (`id_cat`, `nome_cat`, `disponivel`) VALUES
	(1, 'DOCES', 1),
	(3, 'BEBIDA', 0),
	(4, 'SALGADOS', 1);
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;

-- Copiando estrutura para tabela dbkirby.pessoa
CREATE TABLE IF NOT EXISTS `pessoa` (
  `idpessoa` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `endereco` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bairro` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cidade` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `estado` char(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cep` char(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`idpessoa`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Copiando dados para a tabela dbkirby.pessoa: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `pessoa` DISABLE KEYS */;
INSERT INTO `pessoa` (`idpessoa`, `nome`, `endereco`, `bairro`, `cidade`, `estado`, `cep`) VALUES
	(1, 'Teste', 'rua', 'bairro', 'jardim', 'sp', '13995001'),
	(3, 'Guilherme Santos', 'Rua Dezoito de Maio', 'Olaria', 'Aracaju', 'SE', '49092070'),
	(4, 'Renata Silva', 'Rua Alameda Cruzeiro', 'Centro America', 'Corumba', 'MS', '79210155'),
	(5, 'Ryan Barbosa', 'Rua Barachelal Biomar', 'Valentina de Figueiredo', 'João Pessoa', 'PB', '79210355');
/*!40000 ALTER TABLE `pessoa` ENABLE KEYS */;

-- Copiando estrutura para tabela dbkirby.produto
CREATE TABLE IF NOT EXISTS `produto` (
  `id_produto` int(11) NOT NULL AUTO_INCREMENT,
  `id_cat` int(11) DEFAULT NULL,
  `quantidade` int(11) DEFAULT NULL,
  `quantidade_min` int(11) DEFAULT NULL,
  `valor_un` decimal(10,0) DEFAULT NULL,
  `produto` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_produto`),
  KEY `id_cat` (`id_cat`),
  CONSTRAINT `produto_ibfk_1` FOREIGN KEY (`id_cat`) REFERENCES `categoria` (`id_cat`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Copiando dados para a tabela dbkirby.produto: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `produto` DISABLE KEYS */;
INSERT INTO `produto` (`id_produto`, `id_cat`, `quantidade`, `quantidade_min`, `valor_un`, `produto`) VALUES
	(6, 3, 30, 5, 6, 'KUAT 2L');
/*!40000 ALTER TABLE `produto` ENABLE KEYS */;

-- Copiando estrutura para procedure dbkirby.sp_d_cat
DELIMITER //
CREATE     PROCEDURE `sp_d_cat`(IN `in_id` INT)
    NO SQL
BEGIN
	DECLARE existe INT;
	SET existe = (SELECT COUNT(id_cat) FROM produto
    WHERE id_cat = in_id);

	IF(existe = 0) THEN
    	DELETE FROM categoria
        WHERE id_cat = in_id;
        SELECT "1" RETORNO, "CATEGORIA DELETADA" MSG;
   	ELSE
    	SELECT "0" RETORNO, "NÃO FOI POSSIVEL DELETAR, PRODUTOS RELACIONADOS." MSG;
    END IF;
END//
DELIMITER ;

-- Copiando estrutura para procedure dbkirby.sp_d_pessoa
DELIMITER //
CREATE      PROCEDURE `sp_d_pessoa`(IN `in_id` INT)
    NO SQL
BEGIN
    DELETE FROM pessoa
    WHERE idpessoa = in_id;

END//
DELIMITER ;

-- Copiando estrutura para procedure dbkirby.sp_d_produto
DELIMITER //
CREATE     PROCEDURE `sp_d_produto`(IN `in_produto` VARCHAR(100))
    NO SQL
BEGIN
	DELETE FROM produto
    WHERE id_produto = in_produto;
END//
DELIMITER ;

-- Copiando estrutura para procedure dbkirby.sp_i_cat
DELIMITER //
CREATE     PROCEDURE `sp_i_cat`(IN `in_nome` VARCHAR(100), IN `in_status` TINYINT(1))
    NO SQL
    COMMENT 'Procedure p cadastro de categorias'
BEGIN
	DECLARE existe INT;
    SET existe = (SELECT COUNT(nome_cat) from categoria
                  where nome_cat = in_nome);
    if(existe <> 0) then
    	select "0" retorno, "categoria ja existe" msg;
    else
		insert into categoria(nome_cat, disponivel)
        values(in_nome, in_status);
        select "1" retorno, "cadastrado com sucesso" msg;
     END IF;
END//
DELIMITER ;

-- Copiando estrutura para procedure dbkirby.sp_i_pessoa
DELIMITER //
CREATE     PROCEDURE `sp_i_pessoa`(IN `in_nome` VARCHAR(100), IN `in_bairro` VARCHAR(100), IN `in_endereco` VARCHAR(100), IN `in_cidade` VARCHAR(100), IN `in_estado` CHAR(2), IN `in_cep` CHAR(8))
    NO SQL
BEGIN
	DECLARE existe INT;
    SET existe = (SELECT COUNT(nome) from pessoa
                  where nome = in_nome);
    if(existe <> 0) then
    	select "0" retorno, "categoria ja existe" msg;
    else
		insert into pessoa(nome, endereco, bairro, cidade, estado, cep)
        values(in_nome, in_endereco, in_bairro, in_cidade, in_estado, in_cep);
        select "1" retorno, "cadastrado com sucesso" msg;
     END IF;
END//
DELIMITER ;

-- Copiando estrutura para procedure dbkirby.sp_i_produto
DELIMITER //
CREATE     PROCEDURE `sp_i_produto`(IN `in_qtd` INT(11), IN `in_qtd_min` INT(11), IN `in_valor_un` DECIMAL(10), IN `in_produto` VARCHAR(100), IN `in_id_cat` INT)
    NO SQL
BEGIN
	DECLARE existe INT;
    SET existe = (SELECT COUNT(produto) from produto
                  where produto = in_produto);
    if(existe <> 0) then
    	select "0" retorno, "produto ja existe" msg;
    else
		insert into produto(quantidade, quantidade_min, valor_un, produto, id_cat)
        values(in_qtd, in_qtd_min, in_valor_un, in_produto, in_id_cat);
        select "1" retorno, "cadastrado com sucesso" msg;
     END IF;
END//
DELIMITER ;

-- Copiando estrutura para procedure dbkirby.sp_u_cat
DELIMITER //
CREATE     PROCEDURE `sp_u_cat`(IN `in_idcat` INT, IN `in_nome` VARCHAR(100), IN `in_disponivel` TINYINT(4))
    NO SQL
BEGIN  
  UPDATE categoria  
  SET    nome_cat=in_nome,  
         disponivel=in_disponivel
  WHERE  id_cat=in_idcat;            
END//
DELIMITER ;

-- Copiando estrutura para procedure dbkirby.sp_u_pessoa
DELIMITER //
CREATE     PROCEDURE `sp_u_pessoa`(IN `in_nome` VARCHAR(100), IN `in_endereco` VARCHAR(100), IN `in_bairro` VARCHAR(100), IN `in_cidade` VARCHAR(100), IN `in_estado` CHAR(2), IN `in_cep` CHAR(8), IN `in_id` INT)
    NO SQL
BEGIN  
  UPDATE pessoa  
  SET    nome=in_nome,  
         endereco=in_endereco,  
         bairro=in_bairro,  
         cidade=in_cidade,
         estado=in_estado,
         cep=in_cep
  WHERE  idpessoa=in_id;            
END//
DELIMITER ;

-- Copiando estrutura para procedure dbkirby.sp_u_produto
DELIMITER //
CREATE     PROCEDURE `sp_u_produto`(IN `in_idproduto` INT, IN `in_cat` INT, IN `in_quantidade` INT, IN `in_qtdmin` INT, IN `in_valorun` DECIMAL(10,0), IN `in_produto` VARCHAR(100))
    NO SQL
BEGIN  
  UPDATE produto  
  SET      
         id_cat=in_cat,  
         quantidade=in_quantidade,
         quantidade_min=in_qtdmin,
         produto=in_produto
  WHERE  id_produto=in_idproduto  ;        
END//
DELIMITER ;

-- Copiando estrutura para tabela dbkirby.track
CREATE TABLE IF NOT EXISTS `track` (
  `id_track` int(11) NOT NULL,
  `msg_status` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data_movimentacao` int(100) DEFAULT NULL,
  `id_venda` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_track`),
  KEY `id_venda` (`id_venda`),
  CONSTRAINT `track_ibfk_1` FOREIGN KEY (`id_venda`) REFERENCES `venda` (`idvenda`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Copiando dados para a tabela dbkirby.track: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `track` DISABLE KEYS */;
/*!40000 ALTER TABLE `track` ENABLE KEYS */;

-- Copiando estrutura para tabela dbkirby.venda
CREATE TABLE IF NOT EXISTS `venda` (
  `idvenda` int(11) NOT NULL AUTO_INCREMENT,
  `total_venda` decimal(10,0) DEFAULT NULL,
  `data_venda` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `idpessoa` int(11) DEFAULT NULL,
  PRIMARY KEY (`idvenda`),
  KEY `idpessoa` (`idpessoa`),
  CONSTRAINT `venda_ibfk_1` FOREIGN KEY (`idpessoa`) REFERENCES `pessoa` (`idpessoa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Copiando dados para a tabela dbkirby.venda: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `venda` DISABLE KEYS */;
/*!40000 ALTER TABLE `venda` ENABLE KEYS */;

-- Copiando estrutura para tabela dbkirby.venda_item
CREATE TABLE IF NOT EXISTS `venda_item` (
  `idvendaitem` int(11) NOT NULL AUTO_INCREMENT,
  `item` int(11) DEFAULT NULL,
  `idvenda` int(11) DEFAULT NULL,
  `idproduto` int(11) DEFAULT NULL,
  PRIMARY KEY (`idvendaitem`),
  KEY `idvenda` (`idvenda`),
  KEY `idproduto` (`idproduto`),
  CONSTRAINT `venda_item_ibfk_1` FOREIGN KEY (`idvenda`) REFERENCES `venda` (`idvenda`),
  CONSTRAINT `venda_item_ibfk_2` FOREIGN KEY (`idproduto`) REFERENCES `produto` (`id_produto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Copiando dados para a tabela dbkirby.venda_item: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `venda_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `venda_item` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
