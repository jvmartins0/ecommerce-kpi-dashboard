-- ============================================================
--  SISTEMA DE E-COMMERCE — DASHBOARD DE KPIs
--  Trabalho Avaliativo — Banco de Dados
--  Aluno(s): [Seu Nome Aqui]
-- ============================================================

-- ============================================================
--  1. CRIAÇÃO DAS TABELAS
-- ============================================================

CREATE TABLE IF NOT EXISTS categorias (
    id        SERIAL PRIMARY KEY,
    nome      VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS produtos (
    id           SERIAL PRIMARY KEY,
    nome         VARCHAR(100) NOT NULL,
    categoria_id INTEGER NOT NULL REFERENCES categorias(id),
    preco        NUMERIC(10,2) NOT NULL CHECK (preco > 0),
    estoque      INTEGER DEFAULT 0
);

CREATE TABLE IF NOT EXISTS clientes (
    id         SERIAL PRIMARY KEY,
    nome       VARCHAR(100) NOT NULL,
    email      VARCHAR(100) UNIQUE,
    cidade     VARCHAR(60),
    cadastro   DATE DEFAULT CURRENT_DATE
);

CREATE TABLE IF NOT EXISTS pedidos (
    id          SERIAL PRIMARY KEY,
    cliente_id  INTEGER NOT NULL REFERENCES clientes(id),
    produto_id  INTEGER NOT NULL REFERENCES produtos(id),
    quantidade  INTEGER NOT NULL CHECK (quantidade > 0),
    valor_total NUMERIC(10,2) NOT NULL,
    status      VARCHAR(20) NOT NULL CHECK (status IN ('concluido','pendente','cancelado')),
    data_pedido DATE NOT NULL
);

-- ============================================================
--  2. DADOS DE EXEMPLO
-- ============================================================

INSERT INTO categorias (nome) VALUES
    ('Eletrônicos'), ('Moda'), ('Casa & Jardim'), ('Esportes'), ('Beleza');

INSERT INTO produtos (nome, categoria_id, preco, estoque) VALUES
    ('Smartphone X12',     1, 1299.00, 45),
    ('Notebook Pro',       1, 3499.00, 18),
    ('Fone Bluetooth',     1,  349.00, 120),
    ('Smartwatch',         1,  899.00, 30),
    ('Tênis Running',      4,  259.00, 80),
    ('Mochila Sport',      4,  189.00, 55),
    ('Camiseta Algodão',   2,   89.00, 200),
    ('Calça Jeans',        2,  169.00, 90),
    ('Luminária LED',      3,  129.00, 60),
    ('Panela Antiaderente',3,  199.00, 40),
    ('Kit Skincare',       5,  219.00, 75),
    ('Protetor Solar SPF', 5,   59.00, 150);

INSERT INTO clientes (nome, email, cidade, cadastro) VALUES
    ('Ana Souza',       'ana@email.com',    'São Paulo',   '2024-01-10'),
    ('Bruno Lima',      'bruno@email.com',  'Rio de Janeiro','2024-01-15'),
    ('Carla Mendes',    'carla@email.com',  'Belo Horizonte','2024-02-03'),
    ('Diego Rocha',     'diego@email.com',  'Curitiba',    '2024-02-20'),
    ('Elisa Cardoso',   'elisa@email.com',  'Porto Alegre','2024-03-05'),
    ('Fábio Nunes',     'fabio@email.com',  'Brasília',    '2024-03-18'),
    ('Gabriela Costa',  'gabi@email.com',   'Fortaleza',   '2024-04-02'),
    ('Henrique Alves',  'henrique@email.com','Recife',      '2024-04-15'),
    ('Isabela Torres',  'isa@email.com',    'Salvador',    '2024-05-01'),
    ('João Pedro',      'joao@email.com',   'Manaus',      '2024-05-22');

INSERT INTO pedidos (cliente_id, produto_id, quantidade, valor_total, status, data_pedido) VALUES
    (1,  1, 1, 1299.00, 'concluido', '2024-01-05'),
    (2,  3, 2,  698.00, 'concluido', '2024-01-12'),
    (3,  7, 3,  267.00, 'concluido', '2024-01-20'),
    (4,  5, 1,  259.00, 'pendente',  '2024-01-28'),
    (5,  2, 1, 3499.00, 'concluido', '2024-02-03'),
    (6,  9, 2,  258.00, 'concluido', '2024-02-10'),
    (7, 11, 1,  219.00, 'cancelado', '2024-02-14'),
    (8,  4, 1,  899.00, 'concluido', '2024-02-22'),
    (9,  8, 2,  338.00, 'pendente',  '2024-03-01'),
    (10, 6, 1,  189.00, 'concluido', '2024-03-08'),
    (1,  12,3,  177.00, 'concluido', '2024-03-15'),
    (2,  10,2,  398.00, 'concluido', '2024-03-22'),
    (3,  1, 1, 1299.00, 'cancelado', '2024-04-02'),
    (4,  3, 1,  349.00, 'concluido', '2024-04-09'),
    (5,  5, 2,  518.00, 'concluido', '2024-04-16'),
    (6,  11,2,  438.00, 'concluido', '2024-04-23'),
    (7,  2, 1, 3499.00, 'pendente',  '2024-05-01'),
    (8,  7, 4,  356.00, 'concluido', '2024-05-08'),
    (9,  4, 1,  899.00, 'concluido', '2024-05-15'),
    (10, 9, 3,  387.00, 'concluido', '2024-05-22'),
    (1,  6, 2,  378.00, 'concluido', '2024-06-01'),
    (2,  1, 1, 1299.00, 'concluido', '2024-06-05'),
    (3,  12,5,  295.00, 'cancelado', '2024-06-10'),
    (4,  10,1,  199.00, 'concluido', '2024-06-15'),
    (5,  3, 3, 1047.00, 'concluido', '2024-06-20'),
    (6,  8, 1,  169.00, 'pendente',  '2024-06-25'),
    (7,  5, 2,  518.00, 'concluido', '2024-06-28'),
    (8,  11,1,  219.00, 'concluido', '2024-06-29'),
    (9,  2, 1, 3499.00, 'concluido', '2024-06-30'),
    (10, 4, 2, 1798.00, 'concluido', '2024-06-30');


-- ============================================================
--  3. CONSULTAS ANALÍTICAS (KPIs do Dashboard)
-- ============================================================

-- ──────────────────────────────────────────────────────────
-- CONSULTA 1 — Resumo geral de KPIs
--   Usa: SUM, COUNT, AVG, MIN, MAX, WHERE (filtro de status)
-- ──────────────────────────────────────────────────────────
SELECT
    COUNT(*)                        AS total_pedidos,
    SUM(valor_total)                AS receita_total,
    ROUND(AVG(valor_total), 2)      AS ticket_medio,
    MAX(valor_total)                AS maior_pedido,
    MIN(valor_total)                AS menor_pedido,
    COUNT(DISTINCT produto_id)      AS skus_vendidos
FROM pedidos
WHERE status = 'concluido';


-- ──────────────────────────────────────────────────────────
-- CONSULTA 2 — Receita e quantidade de pedidos por categoria
--   Usa: JOIN, GROUP BY, SUM, COUNT, ORDER BY DESC
-- ──────────────────────────────────────────────────────────
SELECT
    c.nome                          AS categoria,
    COUNT(pe.id)                    AS total_pedidos,
    SUM(pe.valor_total)             AS receita_total,
    ROUND(AVG(pe.valor_total), 2)   AS ticket_medio
FROM pedidos pe
JOIN produtos pr ON pr.id = pe.produto_id
JOIN categorias c  ON c.id  = pr.categoria_id
WHERE pe.status = 'concluido'
GROUP BY c.nome
ORDER BY receita_total DESC;


-- ──────────────────────────────────────────────────────────
-- CONSULTA 3 — Evolução mensal de vendas (para gráfico de linha)
--   Usa: DATE_TRUNC / EXTRACT, GROUP BY, ORDER BY ASC
-- ──────────────────────────────────────────────────────────
SELECT
    EXTRACT(MONTH FROM data_pedido) AS mes,
    TO_CHAR(data_pedido, 'Mon/YYYY') AS periodo,
    COUNT(*)                         AS total_pedidos,
    SUM(valor_total)                 AS receita_mensal,
    ROUND(AVG(valor_total), 2)       AS ticket_medio_mensal
FROM pedidos
WHERE status IN ('concluido', 'pendente')
GROUP BY mes, periodo
ORDER BY mes ASC;


-- ──────────────────────────────────────────────────────────
-- CONSULTA 4 — Top 5 produtos mais vendidos por receita
--   Usa: JOIN, GROUP BY, SUM, COUNT, ORDER BY DESC, LIMIT
-- ──────────────────────────────────────────────────────────
SELECT
    pr.nome                         AS produto,
    c.nome                          AS categoria,
    SUM(pe.quantidade)              AS unidades_vendidas,
    SUM(pe.valor_total)             AS receita_total,
    ROUND(AVG(pe.valor_total), 2)   AS ticket_medio
FROM pedidos pe
JOIN produtos pr ON pr.id = pe.produto_id
JOIN categorias c  ON c.id  = pr.categoria_id
WHERE pe.status = 'concluido'
GROUP BY pr.nome, c.nome
ORDER BY receita_total DESC
LIMIT 5;


-- ──────────────────────────────────────────────────────────
-- CONSULTA 5 — Distribuição de status dos pedidos
--   Usa: GROUP BY, COUNT, ORDER BY, cálculo de percentual
-- ──────────────────────────────────────────────────────────
SELECT
    status,
    COUNT(*)                                    AS quantidade,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*))
          OVER (), 2)                           AS percentual
FROM pedidos
GROUP BY status
ORDER BY quantidade DESC;


-- ──────────────────────────────────────────────────────────
-- CONSULTA 6 — Clientes com maior valor total gasto
--   Usa: JOIN múltiplo, GROUP BY, SUM, ORDER BY DESC, LIMIT
-- ──────────────────────────────────────────────────────────
SELECT
    cl.nome                         AS cliente,
    cl.cidade,
    COUNT(pe.id)                    AS total_pedidos,
    SUM(pe.valor_total)             AS gasto_total,
    ROUND(AVG(pe.valor_total), 2)   AS ticket_medio
FROM pedidos pe
JOIN clientes cl ON cl.id = pe.cliente_id
WHERE pe.status = 'concluido'
GROUP BY cl.nome, cl.cidade
ORDER BY gasto_total DESC
LIMIT 10;


-- ──────────────────────────────────────────────────────────
-- CONSULTA 7 — Filtro dinâmico: pedidos por mês e categoria
--   Usa: WHERE com múltiplos filtros, JOIN, ORDER BY DESC
-- ──────────────────────────────────────────────────────────
SELECT
    pe.id,
    cl.nome                         AS cliente,
    pr.nome                         AS produto,
    c.nome                          AS categoria,
    pe.quantidade,
    pe.valor_total,
    pe.status,
    pe.data_pedido
FROM pedidos pe
JOIN produtos pr  ON pr.id = pe.produto_id
JOIN categorias c ON c.id  = pr.categoria_id
JOIN clientes cl  ON cl.id = pe.cliente_id
WHERE
    EXTRACT(MONTH FROM pe.data_pedido) = 6   -- filtro de mês
    AND c.nome = 'Eletrônicos'               -- filtro de categoria
    -- AND pe.status = 'concluido'           -- filtro de status (opcional)
ORDER BY pe.data_pedido DESC;


-- ──────────────────────────────────────────────────────────
-- CONSULTA 8 — Comparativo de receita vs meta mensal
--   Usa: CTE, SUM, CASE WHEN, GROUP BY
-- ──────────────────────────────────────────────────────────
WITH receita_mensal AS (
    SELECT
        EXTRACT(MONTH FROM data_pedido) AS mes,
        SUM(valor_total) AS receita
    FROM pedidos
    WHERE status = 'concluido'
    GROUP BY mes
)
SELECT
    mes,
    receita,
    5000 AS meta,
    ROUND((receita / 5000) * 100, 1) AS percentual_meta,
    CASE
        WHEN receita >= 5000 THEN 'Atingida'
        WHEN receita >= 3500 THEN 'Próximo'
        ELSE 'Abaixo'
    END AS status_meta
FROM receita_mensal
ORDER BY mes ASC;
