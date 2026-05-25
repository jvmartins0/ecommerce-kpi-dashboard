# Dashboard de KPIs — Sistema de E-commerce

## Descrição do Sistema

O projeto simula o sistema de vendas de uma loja virtual (e-commerce) com quatro tabelas relacionadas entre si: **categorias**, **produtos**, **clientes** e **pedidos**. O banco de dados contém registros de Janeiro a Junho de 2024, com produtos de cinco segmentos distintos, permitindo análises comerciais representativas de um cenário real de varejo digital.

---

## Estrutura do Banco de Dados

| Tabela       | Registros | Descrição                                            |
|--------------|-----------|------------------------------------------------------|
| `categorias` | 5         | Eletrônicos, Moda, Casa & Jardim, Esportes, Beleza  |
| `produtos`   | 12        | Itens com preço, estoque e categoria associada       |
| `clientes`   | 10        | Dados do comprador e cidade de origem                |
| `pedidos`    | 30+       | Transações com status, data, quantidade e valor      |

**Relacionamentos:** `pedidos` → `produtos` → `categorias`; `pedidos` → `clientes`

---

## KPIs do Dashboard

| Indicador        | Consulta SQL utilizada         |
|------------------|-------------------------------|
| Receita total    | `SUM(valor_total)`            |
| Total de pedidos | `COUNT(*)`                    |
| Ticket médio     | `AVG(valor_total)`            |
| Maior pedido     | `MAX(valor_total)`            |
| Menor pedido     | `MIN(valor_total)`            |
| SKUs únicos      | `COUNT(DISTINCT produto_id)`  |

---

## Consultas SQL Avançadas

O projeto inclui **8 consultas analíticas** cobrindo todos os requisitos obrigatórios:

- `SELECT` com `WHERE` (filtros por mês, categoria e status)
- Agregações: `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`
- `GROUP BY` (categoria, mês, status, produto)
- `ORDER BY ASC e DESC`
- `JOIN` múltiplo (até 3 tabelas)
- CTE (`WITH`) para análise de metas mensais
- `CASE WHEN` para classificação de status

---

## Gráficos

| Tipo         | Dado visualizado                           |
|--------------|--------------------------------------------|
| Donut/Pizza  | Receita por categoria de produto           |
| Barras horiz.| Ticket médio por categoria (AVG)           |
| Linha dupla  | Evolução mensal: receita + nº de pedidos   |
| Donut        | Distribuição de status dos pedidos         |
| Tabela + barra | Top 5 produtos por unidades vendidas    |

---

## Filtros Dinâmicos

O dashboard permite filtrar simultaneamente por:
- **Mês** (Janeiro a Junho)
- **Categoria** (5 segmentos)
- **Status** (Concluído, Pendente, Cancelado)

Todos os KPIs e gráficos atualizam automaticamente com base nos filtros selecionados, recalculando as consultas SQL em tempo real via banco SQLite embutido no navegador.

---

## Tecnologias Utilizadas

- **Banco de dados:** SQL padrão ANSI (compatível com PostgreSQL/Supabase)
- **Runtime no browser:** sql.js (SQLite via WebAssembly)
- **Gráficos:** Chart.js 4.4
- **Interface:** HTML5 + CSS com variáveis de tema

---

*Trabalho Avaliativo – 3ª Avaliação | Aluno(s): ___________________*
