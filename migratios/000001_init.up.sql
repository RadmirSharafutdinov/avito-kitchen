CREATE SCHEMA kitchen;

CREATE TABLE kitchen.restaurants(
    id BIGSERIAL PRIMARY KEY,
    version BIGINT NOT NULL DEFAULT 1,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(100) NOT NULL CHECK(char_length(address) BETWEEN 30 AND 100),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE kitchen.menu_items(
    id BIGSERIAL PRIMARY KEY,
    version BIGINT NOT NULL DEFAULT 1,
    restaurant_id BIGINT NOT NULL REFERENCES kitchen.restaurants(id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(100),
    price NUMERIC(10,2) NOT NULL CHECK(price > 0),
    available BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE kitchen.orders(
    id BIGSERIAL PRIMARY KEY,
    version BIGINT NOT NULL DEFAULT 1,
    restaurant_id BIGINT NOT NULL REFERENCES kitchen.restaurants(id),
    status TEXT NOT NULL DEFAULT 'new',
    total_price NUMERIC(10,2) NOT NULL CHECK(total_price > 0),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE kitchen.order_items(
    id BIGSERIAL PRIMARY KEY,
    version BIGINT NOT NULL DEFAULT 1,
    order_id BIGINT NOT NULL REFERENCES kitchen.orders(id) ON DELETE CASCADE,
    menu_item_id BIGINT NOT NULL REFERENCES kitchen.menu_items(id),
    quantity INTEGER NOT NULL CHECK(quantity > 0),
    price NUMERIC(10,2) NOT NULL CHECK(price > 0)
);