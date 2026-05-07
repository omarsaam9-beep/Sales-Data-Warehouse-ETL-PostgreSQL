
-- FILE 07: إضافة Primary Keys و Foreign Keys

ALTER TABLE customer_final   ADD PRIMARY KEY (customer_key);
ALTER TABLE item_final       ADD PRIMARY KEY (item_key);
ALTER TABLE store_final      ADD PRIMARY KEY (store_key);
ALTER TABLE time_final       ADD PRIMARY KEY (time_key);
ALTER TABLE trans_final      ADD PRIMARY KEY (payment_key);

-- Foreign Keys
ALTER TABLE fact_table_final
    ADD CONSTRAINT fk_final_customer
    FOREIGN KEY (customer_key) REFERENCES customer_final(customer_key);

ALTER TABLE fact_table_final
    ADD CONSTRAINT fk_final_item
    FOREIGN KEY (item_key) REFERENCES item_final(item_key);

ALTER TABLE fact_table_final
    ADD CONSTRAINT fk_final_store
    FOREIGN KEY (store_key) REFERENCES store_final(store_key);

ALTER TABLE fact_table_final
    ADD CONSTRAINT fk_final_time
    FOREIGN KEY (time_key) REFERENCES time_final(time_key);

ALTER TABLE fact_table_final
    ADD CONSTRAINT fk_final_trans
    FOREIGN KEY (payment_key) REFERENCES trans_final(payment_key);
