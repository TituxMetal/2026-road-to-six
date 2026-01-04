# GuardStore — MVP Definition

## Overview

A fictional e-commerce application built to learn and demonstrate **granular permission systems**
(RBAC + ABAC). The e-commerce context provides a realistic playground where permissions make sense:
multiple user types performing different actions on various resources.

**Primary goal:** Learn and implement a proper permission system (not just roles, but granular
permissions like `product:read`, `product:create`, `product:delete`).

**Secondary goals:**

- Understand e-commerce basics (catalog, cart, checkout, orders)
- Practice file uploads in a clean architecture context

**UI Language:** English (or French, TBD)

## Core Value

1. **Granular permissions** — Users have roles, roles have permissions, every action is checked
   against permissions
2. **Real-world context** — E-commerce provides meaningful scenarios for permissions (who can manage
   products, who can view orders, who can refund, etc.)
3. **File uploads done right** — Product images handled properly in hexagonal architecture

## Reference

Starting point: Clone from [sample-project](https://github.com/TituxMetal/sample-project)

Better Auth has built-in support for roles and permissions — leverage that.

---

## MVP Scope

### MVP Core (Must Ship — 8-10 weeks)

The permission system fully working, illustrated by a simplified e-commerce.

### MVP Full (Nice to Have)

More complete e-commerce features, more granular permissions scenarios.

---

## MVP Core Features

### 1. Permission System

#### Roles (examples)

- `super-admin` — Can do everything
- `product-manager` — Can manage products and categories
- `order-manager` — Can view and manage orders
- `customer-service` — Can view orders and customers, can issue refunds
- `customer` — Can browse, add to cart, place orders

#### Permissions (examples)

- `product:read`, `product:create`, `product:update`, `product:delete`
- `category:read`, `category:create`, `category:update`, `category:delete`
- `order:read`, `order:update`, `order:refund`
- `user:read`, `user:update`, `user:delete`
- `role:read`, `role:assign`

#### Features

- [ ] Define roles in the system
- [ ] Define permissions per role
- [ ] Assign roles to users
- [ ] Check permissions on every protected action (backend)
- [ ] UI reflects permissions (hide/disable actions user can't perform)
- [ ] Admin UI to manage roles and permissions

### 2. Authentication

- [ ] User registration (email/password)
- [ ] User login/logout
- [ ] Guest session (for cart before login)
- [ ] Convert guest to user at checkout
- [ ] Protected routes based on permissions

### 3. Product Catalog

- [ ] Categories (CRUD — permission protected)
- [ ] Products (CRUD — permission protected)
  - Name, description, price, stock quantity
  - Category assignment
  - Product images (upload)
- [ ] Public product listing (anyone can view)
- [ ] Product detail page

### 4. File Upload (Product Images)

- [ ] Upload image when creating/editing product
- [ ] Store images (local filesystem for MVP, abstracted for easy switch to S3/Cloudinary later)
- [ ] Display images in catalog and product detail
- [ ] Clean architecture: upload is an infrastructure adapter, domain doesn't care about storage
      details

### 5. Shopping Cart

- [ ] Add product to cart
- [ ] Update quantity
- [ ] Remove from cart
- [ ] Cart persists for guests (session/localStorage)
- [ ] Cart transfers to user account on login/registration

### 6. Checkout & Orders

- [ ] Checkout flow (shipping info, confirm order)
- [ ] **Simulated payment** (no real Stripe, just a "Pay" button that succeeds)
- [ ] Order created with status `pending` → `paid` → `shipped` → `delivered`
- [ ] Order confirmation page

### 7. Back-Office

- [ ] Dashboard (overview stats — optional)
- [ ] Product management (list, create, edit, delete — permission protected)
- [ ] Category management (permission protected)
- [ ] Order management (list, view details, update status — permission protected)
- [ ] User management (list, view, assign roles — permission protected)
- [ ] Role & permission management (super-admin only)

---

## MVP Full Features (v1.1)

Everything in MVP Core, plus:

### 8. Enhanced Order Management

- [ ] Refund flow (permission: `order:refund`)
- [ ] Order history for customers
- [ ] Order search/filter by date, status, customer

### 9. Invoice Generation

- [ ] Generate PDF invoice for order
- [ ] Download invoice (customer + order-manager)

### 10. Customer Management

- [ ] Customer list with order history
- [ ] Customer detail view

---

## Out of Scope (for MVP Core & Full)

- Real payment processing (Stripe, PayPal)
- Inventory management (low stock alerts, reorder)
- Shipping calculation / carrier integration
- Product variants (size, color)
- Reviews / ratings
- Wishlist
- Discount codes / promotions
- Email notifications
- Multi-language / multi-currency

---

## Technical Stack

| Layer                     | Technology                                 |
| ------------------------- | ------------------------------------------ |
| Monorepo                  | Turborepo                                  |
| Runtime & Package Manager | Bun 1.3.x                                  |
| Backend                   | NestJS 11.x (Clean/Hexagonal Architecture) |
| Database                  | SQLite (dev & prod for MVP)                |
| ORM                       | Prisma 7.x                                 |
| Auth & Permissions        | Better Auth 1.4.x (with RBAC plugin)       |
| Frontend                  | Astro 5.x + React 19.x                     |
| Styling                   | TailwindCSS v4                             |
| File Storage              | Local filesystem (abstracted via adapter)  |
| Testing                   | Bun test                                   |
| Linting                   | ESLint 9.x + Prettier 3.x                  |
| Git Hooks                 | Husky 9.x + CommitLint 20.x                |
| Deployment                | Docker, docker-compose                     |

### Architecture

- **Backend:** Clean/Hexagonal Architecture
  - Domain: entities, permissions logic
  - Application: use cases with permission checks
  - Infrastructure: file upload adapter, database, auth
- **Frontend:** Feature-based folder structure
- **Testing:** TDD approach

### Git Workflow

- **Branching:** `main` ← `develop` ← `feature/*`, `fix/*`, `hotfix/*`
- **Commits:** Conventional commits, atomic
- **PRs:** Required for merging

---

## Data Model (High-Level)

```text
User
├── id
├── email
├── password (hashed)
├── roles[] (many-to-many)
└── orders[]

Role
├── id
├── name (e.g., "product-manager")
├── permissions[] (many-to-many)
└── users[]

Permission
├── id
├── name (e.g., "product:create")
└── roles[]

Category
├── id
├── name
├── description
└── products[]

Product
├── id
├── name
├── description
├── price
├── stockQuantity
├── categoryId
└── images[]

ProductImage
├── id
├── productId
├── filePath
├── sortOrder

Cart (or CartSession for guests)
├── id
├── userId (nullable for guests)
├── sessionId (for guests)
├── items[]

CartItem
├── id
├── cartId
├── productId
├── quantity

Order
├── id
├── userId
├── status (pending, paid, shipped, delivered, refunded)
├── totalAmount
├── shippingAddress
├── createdAt
└── items[]

OrderItem
├── id
├── orderId
├── productId
├── quantity
├── unitPrice
```

---

## "Done" Criteria

### MVP Core (Required)

- [ ] Deployed to a public URL
- [ ] Permission system works (roles, permissions, checks)
- [ ] Admin can manage roles and assign to users
- [ ] Product catalog with categories and images
- [ ] File upload works for product images
- [ ] Cart works for guests and logged users
- [ ] Checkout flow completes (simulated payment)
- [ ] Orders are created and manageable in back-office
- [ ] All actions respect permissions
- [ ] UI hides/disables actions based on permissions
- [ ] Mobile-friendly
- [ ] Core features tested
- [ ] README with setup instructions

### MVP Full (Stretch Goal)

- [ ] All MVP Core criteria met
- [ ] Refund flow works
- [ ] Invoice PDF generation
- [ ] Customer management in back-office

---

## Build Order (High-Level)

> **Note:** This is a bird's-eye view. Each item = full feature (backend + frontend + tests). Keep
> dev sessions focused on ONE feature.

### MVP Core

1. **Project setup & deploy** — Clone sample-project, rename, configure, deploy skeleton
2. **Permission system** — Roles, permissions, Better Auth config, permission checks
3. **Admin: Role management** — UI to view/create roles, assign permissions
4. **Admin: User management** — List users, assign roles
5. **Categories CRUD** — With permission protection
6. **Products CRUD** — With permission protection
7. **File upload** — Product images, infrastructure adapter
8. **Public catalog** — Product listing, detail pages
9. **Cart** — Guest + logged user, persistence, transfer on login
10. **Checkout & Orders** — Flow, simulated payment, order creation
11. **Admin: Order management** — List, view, update status
12. **Polish** — UI refinements, permission-based UI hiding, mobile

### MVP Full (if time permits)

All of MVP Core, plus:

1. **Refund flow** — Permission-protected refund action
2. **Invoice PDF** — Generate and download
3. **Customer management** — List, detail, order history
