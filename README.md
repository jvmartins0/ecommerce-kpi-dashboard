#  Dashboard de KPIs — E-commerce

> Trabalho Avaliativo — Disciplina de Banco de Dados  
> Dashboard interativo de indicadores comerciais com consultas SQL em tempo real.

---

##  Demo

Abra o arquivo [`dashboard.html`](./dashboard.html) diretamente no navegador — **nenhuma instalação necessária**.

O banco de dados SQLite roda inteiramente no browser via **WebAssembly (sql.js)**, executando consultas SQL reais a cada interação com os filtros.

---

##  Estrutura do Repositório

```
ecommerce-kpi-dashboard/
│
├── dashboard.html          # Dashboard completo (standalone, abre no browser)
│
├── sql/
│   └── ecommerce_dashboard.sql   # DDL + DML + 8 consultas analíticas comentadas
│
├── docs/
│   └── descricao_sistema.md      # Descrição do sistema (entrega)
│
└── README.md
```

---

##  Estrutura do Banco de Dados

```sql
categorias (id, nome)
     │
     └── produtos (id, nome, categoria_id, preco, estoque)
                       │
                       └── pedidos (id, cliente_id, produto_id,
                                    quantidade, valor_total, status, data_pedido)
                                        │
                              clientes (id, nome, email, cidade, cadastro)
```

| Tabela        | Registros | Descrição                                          |
|---------------|-----------|----------------------------------------------------|
| `categorias`  | 5         | Eletrônicos, Moda, Casa & Jardim, Esportes, Beleza |
| `produtos`    | 12        | Itens com preço, estoque e vínculo à categoria     |
| `clientes`    | 10        | Dados do comprador e cidade de origem              |
| `pedidos`     | 30+       | Transações com status, data, quantidade e valor    |

---

##  KPIs do Dashboard

| Indicador        | Função SQL                    |
|------------------|-------------------------------|
| Receita total    | `SUM(valor_total)`            |
| Total de pedidos | `COUNT(*)`                    |
| Ticket médio     | `AVG(valor_total)`            |
| Maior pedido     | `MAX(valor_total)`            |
| Menor pedido     | `MIN(valor_total)`            |
| SKUs únicos      | `COUNT(DISTINCT produto_id)`  |

---

##  Gráficos

| Tipo              | Dado visualizado                              |
|-------------------|-----------------------------------------------|
| Donut             | Receita por categoria (`GROUP BY categoria`)  |
| Barras horizontais| Ticket médio por segmento (`AVG`)             |
| Linha dupla       | Evolução mensal: receita + nº de pedidos      |
| Donut             | Distribuição de status dos pedidos            |
| Tabela + sparkbar | Top 5 produtos por receita acumulada          |

---

##  Consultas SQL Implementadas

O arquivo [`sql/ecommerce_dashboard.sql`](./sql/ecommerce_dashboard.sql) contém **8 consultas analíticas** comentadas, cobrindo todos os requisitos:

- `SELECT` com `WHERE` — filtros por mês, categoria e status
- Agregações — `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`
- `GROUP BY` — por categoria, mês, status e produto
- `ORDER BY ASC e DESC`
- `JOIN` múltiplo (até 3 tabelas)
- `CTE (WITH)` — análise de metas mensais
- `CASE WHEN` — classificação de status de meta
- `COUNT(DISTINCT)` — SKUs únicos vendidos

---

##  Filtros Dinâmicos

O dashboard recalcula todos os KPIs e gráficos ao aplicar filtros combinados por:

- **Mês** — Janeiro a Junho
- **Categoria** — 5 segmentos de produtos
- **Status** — Concluído / Pendente / Cancelado

---

##  Tecnologias

| Camada         | Tecnologia                         |
|----------------|------------------------------------|
| Banco de dados | SQL padrão ANSI (PostgreSQL-compatible) |
| Runtime browser| [sql.js](https://sql.js.org/) 1.10.2 — SQLite via WebAssembly |
| Gráficos       | [Chart.js](https://www.chartjs.org/) 4.4.1 |
| Interface      | HTML5 + CSS3 (dark mode nativo)    |
| Ícones         | [Tabler Icons](https://tabler.io/icons) |

---

*Trabalho Avaliativo — 3ª Avaliação | Banco de Dados*
