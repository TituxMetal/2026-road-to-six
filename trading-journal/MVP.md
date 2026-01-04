# Trading Journal — MVP Definition

## Overview

A personal trading journal that consolidates trading activity and long-term investments across
multiple brokers into a single dashboard. Serves two purposes: tracking short-term trades for
learning and improvement, and monitoring long-term DCA positions with dividend income.

**Primary User:** Solo trader/investor managing multiple broker accounts **Core Problem:** Brokers
(especially Trade Republic) lack proper portfolio overview, position history, and dividend tracking

## MVP Scope

### What MVP Delivers

- Single source of truth for all trading/investing activity
- Track positions across multiple brokers
- Separate short-term trading from long-term investments via portfolios
- Basic P&L calculations
- Dividend tracking for tax reporting

### What MVP Does NOT Include

- Partial position closes (scaling out)
- Advanced analytics (win rate charts, equity curves, monthly summaries)
- Public read-only dashboard
- Data export (JSON/CSV)
- Advanced filtering (date ranges, multi-select)
- Broker API integrations (all data entered manually)
- Position entry history for DCA tracking (v2 feature)

## Data Model

### Broker

| Field       | Type     | Required | Description                      |
| ----------- | -------- | -------- | -------------------------------- |
| id          | string   | yes      | UUID                             |
| name        | string   | yes      | e.g., "Trade Republic", "DEGIRO" |
| description | string   | no       | Notes about the account          |
| accountType | enum     | yes      | DEMO \| REAL                     |
| createdAt   | datetime | yes      | Auto-generated                   |
| updatedAt   | datetime | yes      | Auto-generated                   |

### Portfolio

| Field       | Type     | Required | Description                               |
| ----------- | -------- | -------- | ----------------------------------------- |
| id          | string   | yes      | UUID                                      |
| name        | string   | yes      | e.g., "Day Trading", "Long-term Holdings" |
| description | string   | no       | Strategy description                      |
| brokerId    | string   | yes      | FK to Broker                              |
| createdAt   | datetime | yes      | Auto-generated                            |
| updatedAt   | datetime | yes      | Auto-generated                            |

### Position

| Field       | Type     | Required | Description                             |
| ----------- | -------- | -------- | --------------------------------------- |
| id          | string   | yes      | UUID                                    |
| ticker      | string   | yes      | e.g., "AAPL", "GOOGL"                   |
| entryPrice  | decimal  | yes      | Price per unit at entry                 |
| entryDate   | datetime | yes      | When position was opened                |
| quantity    | decimal  | yes      | Number of units                         |
| fees        | decimal  | no       | Entry fees (default 0)                  |
| exitPrice   | decimal  | no       | Price per unit at exit (null if open)   |
| exitDate    | datetime | no       | When position was closed (null if open) |
| exitFees    | decimal  | no       | Exit fees (default 0)                   |
| stopLoss    | decimal  | no       | Planned stop loss price                 |
| takeProfit  | decimal  | no       | Planned take profit price               |
| notes       | text     | no       | Free text for observations, rules, etc. |
| status      | enum     | yes      | OPEN \| CLOSED                          |
| portfolioId | string   | yes      | FK to Portfolio                         |
| createdAt   | datetime | yes      | Auto-generated                          |
| updatedAt   | datetime | yes      | Auto-generated                          |

### Dividend

| Field       | Type     | Required | Description              |
| ----------- | -------- | -------- | ------------------------ |
| id          | string   | yes      | UUID                     |
| ticker      | string   | yes      | e.g., "AAPL"             |
| amount      | decimal  | yes      | Dividend amount received |
| paymentDate | datetime | yes      | When dividend was paid   |
| notes       | string   | no       | e.g., "Q1 2026 dividend" |
| portfolioId | string   | yes      | FK to Portfolio          |
| createdAt   | datetime | yes      | Auto-generated           |
| updatedAt   | datetime | yes      | Auto-generated           |

## Features

### Authentication (inherited from sample-project)

- [x] User registration
- [x] User login
- [x] Session management
- [x] Protected routes

### Broker Management

- [ ] Create broker
- [ ] List brokers
- [ ] Edit broker
- [ ] Delete broker (cascade to portfolios)

### Portfolio Management

- [ ] Create portfolio (assign to broker)
- [ ] List portfolios (grouped by broker)
- [ ] Edit portfolio
- [ ] Delete portfolio (cascade to positions/dividends)

### Position Management

- [ ] Create position (assign to portfolio)
- [ ] List positions (filter by portfolio, status)
- [ ] Edit position
- [ ] Close position (set exit price/date)
- [ ] Delete position
- [ ] Auto-calculate P&L on closed positions

### Dividend Management

- [ ] Create dividend (assign to portfolio)
- [ ] List dividends (filter by portfolio)
- [ ] Edit dividend
- [ ] Delete dividend

### Dashboard (basic)

- [ ] Total invested per portfolio
- [ ] Total P&L per portfolio (closed positions)
- [ ] Total dividends received
- [ ] List of open positions

## Calculated Fields (computed, not stored)

| Calculation     | Formula                                               |
| --------------- | ----------------------------------------------------- |
| Position P&L    | (exitPrice - entryPrice) × quantity - fees - exitFees |
| Position P&L %  | ((exitPrice - entryPrice) / entryPrice) × 100         |
| Total Invested  | SUM(entryPrice × quantity + fees) for portfolio       |
| Total Dividends | SUM(amount) for portfolio/period                      |
| Portfolio P&L   | SUM(P&L) of closed positions in portfolio             |

## UI Structure

```text
/                       → Dashboard (summary view)
/brokers                → Broker list
/brokers/new            → Create broker
/brokers/:id/edit       → Edit broker
/portfolios             → Portfolio list (grouped by broker)
/portfolios/new         → Create portfolio
/portfolios/:id         → Portfolio detail (positions + dividends)
/portfolios/:id/edit    → Edit portfolio
/positions/new          → Create position
/positions/:id          → Position detail
/positions/:id/edit     → Edit position
/dividends/new          → Create dividend
/dividends/:id/edit     → Edit dividend
```

## Tech Stack

Inherited from sample-project:

- **Backend:** NestJS 11, Prisma 7, SQLite, Better Auth
- **Frontend:** Astro 5, React 19, TailwindCSS 4
- **Tooling:** Bun, Turbo, TypeScript, ESLint, Prettier

## Success Criteria

MVP is complete when:

1. User can create brokers and portfolios
2. User can log positions (open and close them)
3. User can log dividends
4. User can see total invested and P&L per portfolio
5. User can see total dividends
6. All data is persisted and survives restart
7. Only authenticated user can CRUD data

## Future Iterations (post-MVP)

- **v1.1:** Partial closes for scaling out of positions
- **v1.2:** Advanced analytics (win rate, avg win/loss, charts)
- **v1.3:** Position entry history for DCA tracking
- **v1.4:** Public read-only dashboard
- **v1.5:** Data export (JSON/CSV for tax reporting)
- **v1.6:** Date range filters and advanced search
