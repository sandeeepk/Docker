--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.11
-- Dumped by pg_dump version 9.5.11

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: accounts; Type: SCHEMA; Schema: -; Owner: java
--

CREATE SCHEMA accounts;


ALTER SCHEMA accounts OWNER TO java;

--
-- Name: SCHEMA accounts; Type: COMMENT; Schema: -; Owner: java
--

COMMENT ON SCHEMA accounts IS 'HITA accounting solution schema';


--
-- Name: invoices; Type: SCHEMA; Schema: -; Owner: java
--

CREATE SCHEMA invoices;


ALTER SCHEMA invoices OWNER TO java;

--
-- Name: SCHEMA invoices; Type: COMMENT; Schema: -; Owner: java
--

COMMENT ON SCHEMA invoices IS 'HITA invoice application schema';


--
-- Name: user_master; Type: SCHEMA; Schema: -; Owner: java
--

CREATE SCHEMA user_master;


ALTER SCHEMA user_master OWNER TO java;

--
-- Name: user_masterbackup; Type: SCHEMA; Schema: -; Owner: java
--

CREATE SCHEMA user_masterbackup;


ALTER SCHEMA user_masterbackup OWNER TO java;

--
-- Name: SCHEMA user_masterbackup; Type: COMMENT; Schema: -; Owner: java
--

COMMENT ON SCHEMA user_masterbackup IS 'User management master schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = accounts, pg_catalog;

--
-- Name: account_seq; Type: SEQUENCE; Schema: accounts; Owner: java
--

CREATE SEQUENCE account_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE account_seq OWNER TO java;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: account_type; Type: TABLE; Schema: accounts; Owner: java
--

CREATE TABLE account_type (
    id integer NOT NULL,
    code character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE account_type OWNER TO java;

--
-- Name: account_type_seq; Type: SEQUENCE; Schema: accounts; Owner: java
--

CREATE SEQUENCE account_type_seq
    START WITH 1000
    INCREMENT BY 1
    MINVALUE 1000
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE account_type_seq OWNER TO java;

--
-- Name: accounting_events; Type: TABLE; Schema: accounts; Owner: java
--

CREATE TABLE accounting_events (
    id integer NOT NULL,
    code character varying(255) NOT NULL,
    description character varying(1000) NOT NULL,
    doc_class character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE accounting_events OWNER TO java;

--
-- Name: accounting_events_seq; Type: SEQUENCE; Schema: accounts; Owner: java
--

CREATE SEQUENCE accounting_events_seq
    START WITH 1000
    INCREMENT BY 1
    MINVALUE 1000
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE accounting_events_seq OWNER TO java;

--
-- Name: accounts; Type: TABLE; Schema: accounts; Owner: java
--

CREATE TABLE accounts (
    id integer NOT NULL,
    account_no integer NOT NULL,
    chart_of_account_id integer NOT NULL,
    account_name character varying(255) NOT NULL,
    amount numeric(15,2) NOT NULL,
    balance_type character varying(100) NOT NULL,
    user_id integer,
    party_id integer,
    status_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE accounts OWNER TO java;

--
-- Name: accounts_seq; Type: SEQUENCE; Schema: accounts; Owner: java
--

CREATE SEQUENCE accounts_seq
    START WITH 1000
    INCREMENT BY 1
    MINVALUE 1000
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE accounts_seq OWNER TO java;

--
-- Name: batch_job_execution; Type: TABLE; Schema: accounts; Owner: java
--

CREATE TABLE batch_job_execution (
    job_execution_id bigint NOT NULL,
    version bigint,
    job_instance_id bigint NOT NULL,
    create_time timestamp without time zone NOT NULL,
    start_time timestamp without time zone,
    end_time timestamp without time zone,
    status character varying(10),
    exit_code character varying(2500),
    exit_message character varying(2500),
    last_updated timestamp without time zone,
    job_configuration_location character varying(2500)
);


ALTER TABLE batch_job_execution OWNER TO java;

--
-- Name: batch_job_execution_context; Type: TABLE; Schema: accounts; Owner: java
--

CREATE TABLE batch_job_execution_context (
    job_execution_id bigint NOT NULL,
    short_context character varying(2500) NOT NULL,
    serialized_context text
);


ALTER TABLE batch_job_execution_context OWNER TO java;

--
-- Name: batch_job_execution_params; Type: TABLE; Schema: accounts; Owner: java
--

CREATE TABLE batch_job_execution_params (
    job_execution_id bigint NOT NULL,
    type_cd character varying(6) NOT NULL,
    key_name character varying(100) NOT NULL,
    string_val character varying(250),
    date_val timestamp without time zone,
    long_val bigint,
    double_val double precision,
    identifying character(1) NOT NULL
);


ALTER TABLE batch_job_execution_params OWNER TO java;

--
-- Name: batch_job_execution_seq; Type: SEQUENCE; Schema: accounts; Owner: java
--

CREATE SEQUENCE batch_job_execution_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE batch_job_execution_seq OWNER TO java;

--
-- Name: batch_job_instance; Type: TABLE; Schema: accounts; Owner: java
--

CREATE TABLE batch_job_instance (
    job_instance_id bigint NOT NULL,
    version bigint,
    job_name character varying(100) NOT NULL,
    job_key character varying(32) NOT NULL
);


ALTER TABLE batch_job_instance OWNER TO java;

--
-- Name: batch_job_seq; Type: SEQUENCE; Schema: accounts; Owner: java
--

CREATE SEQUENCE batch_job_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE batch_job_seq OWNER TO java;

--
-- Name: batch_step_execution; Type: TABLE; Schema: accounts; Owner: java
--

CREATE TABLE batch_step_execution (
    step_execution_id bigint NOT NULL,
    version bigint NOT NULL,
    step_name character varying(100) NOT NULL,
    job_execution_id bigint NOT NULL,
    start_time timestamp without time zone NOT NULL,
    end_time timestamp without time zone,
    status character varying(10),
    commit_count bigint,
    read_count bigint,
    filter_count bigint,
    write_count bigint,
    read_skip_count bigint,
    write_skip_count bigint,
    process_skip_count bigint,
    rollback_count bigint,
    exit_code character varying(2500),
    exit_message character varying(2500),
    last_updated timestamp without time zone
);


ALTER TABLE batch_step_execution OWNER TO java;

--
-- Name: batch_step_execution_context; Type: TABLE; Schema: accounts; Owner: java
--

CREATE TABLE batch_step_execution_context (
    step_execution_id bigint NOT NULL,
    short_context character varying(2500) NOT NULL,
    serialized_context text
);


ALTER TABLE batch_step_execution_context OWNER TO java;

--
-- Name: batch_step_execution_seq; Type: SEQUENCE; Schema: accounts; Owner: java
--

CREATE SEQUENCE batch_step_execution_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE batch_step_execution_seq OWNER TO java;

--
-- Name: calendar; Type: TABLE; Schema: accounts; Owner: java
--

CREATE TABLE calendar (
    id integer NOT NULL,
    period_type character varying(100) NOT NULL,
    financial_year character varying(100) NOT NULL,
    description character varying(1000) NOT NULL,
    status_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE calendar OWNER TO java;

--
-- Name: calendar_seq; Type: SEQUENCE; Schema: accounts; Owner: java
--

CREATE SEQUENCE calendar_seq
    START WITH 1000
    INCREMENT BY 1
    MINVALUE 1000
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE calendar_seq OWNER TO java;

--
-- Name: calender_seq; Type: SEQUENCE; Schema: accounts; Owner: java
--

CREATE SEQUENCE calender_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE calender_seq OWNER TO java;

--
-- Name: chart_of_accounts; Type: TABLE; Schema: accounts; Owner: java
--

CREATE TABLE chart_of_accounts (
    id integer NOT NULL,
    account_code integer NOT NULL,
    account_name character varying(255) NOT NULL,
    account_type_id integer NOT NULL,
    account_group character varying(255) NOT NULL,
    sub_group character varying(255) NOT NULL,
    financial_statement character varying(255) NOT NULL,
    bal_type character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE chart_of_accounts OWNER TO java;

--
-- Name: chart_of_accounts_seq; Type: SEQUENCE; Schema: accounts; Owner: java
--

CREATE SEQUENCE chart_of_accounts_seq
    START WITH 1000
    INCREMENT BY 1
    MINVALUE 1000
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE chart_of_accounts_seq OWNER TO java;

--
-- Name: config; Type: TABLE; Schema: accounts; Owner: java
--

CREATE TABLE config (
    id integer NOT NULL,
    description character varying(255),
    flag boolean,
    name character varying(255),
    value integer
);


ALTER TABLE config OWNER TO java;

--
-- Name: controls; Type: TABLE; Schema: accounts; Owner: java
--

CREATE TABLE controls (
    id integer NOT NULL,
    category character varying(255) NOT NULL,
    account_name character varying(255) NOT NULL,
    control_type character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    chart_of_account_id integer
);


ALTER TABLE controls OWNER TO java;

--
-- Name: COLUMN controls.chart_of_account_id; Type: COMMENT; Schema: accounts; Owner: java
--

COMMENT ON COLUMN controls.chart_of_account_id IS 'Default Chart of Account for each party when created.';


--
-- Name: controls_seq; Type: SEQUENCE; Schema: accounts; Owner: java
--

CREATE SEQUENCE controls_seq
    START WITH 1000
    INCREMENT BY 1
    MINVALUE 1000
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE controls_seq OWNER TO java;

--
-- Name: customerreport; Type: TABLE; Schema: accounts; Owner: java
--

CREATE TABLE customerreport (
    id integer NOT NULL,
    amount double precision,
    due_date timestamp without time zone,
    invoice_date timestamp without time zone,
    invoice_number character varying(255),
    unpaid_balance double precision
);


ALTER TABLE customerreport OWNER TO java;

--
-- Name: journals; Type: TABLE; Schema: accounts; Owner: java
--

CREATE TABLE journals (
    id integer NOT NULL,
    transaction_id integer NOT NULL,
    journal_date timestamp without time zone NOT NULL,
    account_id integer NOT NULL,
    debit_amt numeric,
    credit_amt numeric,
    period_id integer NOT NULL,
    txn_type character varying(100) NOT NULL,
    description character varying(1000),
    notes character varying(1000),
    user_id integer NOT NULL,
    party_id integer NOT NULL,
    batch_name character varying(100),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE journals OWNER TO java;

--
-- Name: journals_seq; Type: SEQUENCE; Schema: accounts; Owner: java
--

CREATE SEQUENCE journals_seq
    START WITH 1000
    INCREMENT BY 1
    MINVALUE 1000
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE journals_seq OWNER TO java;

--
-- Name: party_account_control; Type: TABLE; Schema: accounts; Owner: java
--

CREATE TABLE party_account_control (
    id integer NOT NULL,
    control_id integer NOT NULL,
    party_id integer NOT NULL,
    chart_of_account_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE party_account_control OWNER TO java;

--
-- Name: party_account_control_seq; Type: SEQUENCE; Schema: accounts; Owner: java
--

CREATE SEQUENCE party_account_control_seq
    START WITH 1000
    INCREMENT BY 1
    MINVALUE 1000
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE party_account_control_seq OWNER TO java;

--
-- Name: payment_transaction; Type: TABLE; Schema: accounts; Owner: java
--

CREATE TABLE payment_transaction (
    id integer NOT NULL,
    vendor_name character varying NOT NULL,
    invoice_number character varying NOT NULL,
    invoice_type character varying NOT NULL,
    account_type character varying NOT NULL,
    journal_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    balance double precision,
    invoice_date timestamp without time zone,
    is_paid boolean,
    paid double precision,
    payment_due_date timestamp without time zone,
    un_paid double precision,
    customer_id character varying(255),
    remaing_amount double precision
);


ALTER TABLE payment_transaction OWNER TO java;

--
-- Name: payment_transaction_seq; Type: SEQUENCE; Schema: accounts; Owner: java
--

CREATE SEQUENCE payment_transaction_seq
    START WITH 1000
    INCREMENT BY 1
    MINVALUE 1000
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE payment_transaction_seq OWNER TO java;

--
-- Name: payments; Type: TABLE; Schema: accounts; Owner: java
--

CREATE TABLE payments (
    id integer NOT NULL,
    amount numeric NOT NULL,
    payment_txn_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE payments OWNER TO java;

--
-- Name: payments_seq; Type: SEQUENCE; Schema: accounts; Owner: java
--

CREATE SEQUENCE payments_seq
    START WITH 1000
    INCREMENT BY 1
    MINVALUE 1000
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE payments_seq OWNER TO java;

--
-- Name: period_end_process; Type: TABLE; Schema: accounts; Owner: java
--

CREATE TABLE period_end_process (
    id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    account_code integer,
    account_group character varying(255),
    account_name character varying(255),
    bal_amt numeric(19,2),
    bal_type character varying(255),
    bal_type_prefix character varying(255),
    financial_statement character varying(255),
    gstin integer,
    j_date character varying(255),
    party_id integer,
    period character varying(255),
    sub_group character varying(255),
    sum_credit numeric(19,2),
    sum_debit numeric(19,2),
    type character varying(255)
);


ALTER TABLE period_end_process OWNER TO java;

--
-- Name: periods; Type: TABLE; Schema: accounts; Owner: java
--

CREATE TABLE periods (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    period_value character varying(100) NOT NULL,
    calendar_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE periods OWNER TO java;

--
-- Name: periods_seq; Type: SEQUENCE; Schema: accounts; Owner: java
--

CREATE SEQUENCE periods_seq
    START WITH 1000
    INCREMENT BY 1
    MINVALUE 1000
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE periods_seq OWNER TO java;

--
-- Name: statuses; Type: TABLE; Schema: accounts; Owner: java
--

CREATE TABLE statuses (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(1000) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE statuses OWNER TO java;

--
-- Name: statuses_seq; Type: SEQUENCE; Schema: accounts; Owner: java
--

CREATE SEQUENCE statuses_seq
    START WITH 1000
    INCREMENT BY 1
    MINVALUE 1000
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE statuses_seq OWNER TO java;

--
-- Name: summary; Type: TABLE; Schema: accounts; Owner: java
--

CREATE TABLE summary (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE summary OWNER TO java;

--
-- Name: summary_seq; Type: SEQUENCE; Schema: accounts; Owner: java
--

CREATE SEQUENCE summary_seq
    START WITH 1000
    INCREMENT BY 1
    MINVALUE 1000
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE summary_seq OWNER TO java;

--
-- Name: transactions; Type: TABLE; Schema: accounts; Owner: java
--

CREATE TABLE transactions (
    id integer NOT NULL,
    ref_no character varying(60) NOT NULL,
    gstin character varying(15),
    sotre_id integer,
    journal_no character varying NOT NULL,
    accounting_event_id integer NOT NULL,
    txn_type character varying(255) NOT NULL,
    description character varying(1000) NOT NULL,
    txn_date timestamp without time zone NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    ref_invoice_number character varying
);


ALTER TABLE transactions OWNER TO java;

--
-- Name: transactions_seq; Type: SEQUENCE; Schema: accounts; Owner: java
--

CREATE SEQUENCE transactions_seq
    START WITH 1000
    INCREMENT BY 1
    MINVALUE 1000
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE transactions_seq OWNER TO java;

--
-- Name: user_info; Type: TABLE; Schema: accounts; Owner: java
--

CREATE TABLE user_info (
    id integer NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(1000) NOT NULL
);


ALTER TABLE user_info OWNER TO java;

--
-- Name: user_info_seq; Type: SEQUENCE; Schema: accounts; Owner: java
--

CREATE SEQUENCE user_info_seq
    START WITH 1000
    INCREMENT BY 1
    MINVALUE 1000
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE user_info_seq OWNER TO java;

SET search_path = invoices, pg_catalog;

--
-- Name: addresses; Type: TABLE; Schema: invoices; Owner: java
--

CREATE TABLE addresses (
    id integer NOT NULL,
    address_line1 character varying(255),
    address_line2 character varying(255),
    address_type character varying(255),
    city character varying(255),
    country character varying(255),
    created_at timestamp without time zone,
    district character varying(255),
    pincode character varying(255),
    ref_id integer,
    state character varying(255),
    statecode character varying(255),
    updated_at timestamp without time zone
);


ALTER TABLE addresses OWNER TO java;

--
-- Name: catalog_master; Type: TABLE; Schema: invoices; Owner: java
--

CREATE TABLE catalog_master (
    category_id integer NOT NULL,
    category character varying(255),
    description character varying(255),
    catalog character varying
);


ALTER TABLE catalog_master OWNER TO java;

--
-- Name: cities; Type: TABLE; Schema: invoices; Owner: java
--

CREATE TABLE cities (
    city_id integer,
    city_name character varying(100),
    state_code character varying(100)
);


ALTER TABLE cities OWNER TO java;

--
-- Name: classsification_codes; Type: TABLE; Schema: invoices; Owner: java
--

CREATE TABLE classsification_codes (
    id integer NOT NULL,
    category character varying(255),
    classification_code character varying(255),
    classification_type character varying(255),
    description text,
    flag boolean NOT NULL,
    product_type character varying(255)
);


ALTER TABLE classsification_codes OWNER TO java;

--
-- Name: config; Type: TABLE; Schema: invoices; Owner: java
--

CREATE TABLE config (
    id integer NOT NULL,
    description character varying(255),
    flag boolean,
    name character varying(255),
    value character varying
);


ALTER TABLE config OWNER TO java;

--
-- Name: document_sequences; Type: TABLE; Schema: invoices; Owner: java
--

CREATE TABLE document_sequences (
    id integer NOT NULL,
    doc_type character varying(255),
    doc_subclass character varying(255),
    effective_from timestamp without time zone,
    effective_to timestamp without time zone,
    end_number integer NOT NULL,
    gstin character varying(255),
    last_number integer NOT NULL,
    organization_name character varying(255),
    prefix character varying(255),
    start_number integer NOT NULL,
    auto_generated boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    active boolean DEFAULT false NOT NULL
);


ALTER TABLE document_sequences OWNER TO java;

--
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: invoices; Owner: java
--

CREATE SEQUENCE hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hibernate_sequence OWNER TO java;

--
-- Name: hsn_party; Type: TABLE; Schema: invoices; Owner: java
--

CREATE TABLE hsn_party (
    id integer NOT NULL,
    category character varying(255),
    classfication_id integer NOT NULL,
    classification_code character varying(255),
    classification_type character varying(255),
    description character varying(255),
    flag boolean NOT NULL,
    gstin character varying(255),
    product_type character varying(255)
);


ALTER TABLE hsn_party OWNER TO java;

--
-- Name: invoice; Type: TABLE; Schema: invoices; Owner: java
--

CREATE TABLE invoice (
    id integer NOT NULL,
    adjusted_document_date timestamp without time zone,
    adjusted_document_number character varying(255),
    advance_amount_applied double precision,
    advance_reference_number character varying(255),
    chargeglaccount character varying(255),
    counter_partygstin character varying(255),
    counter_party_name character varying(255),
    counter_party_state character varying(255),
    counterparty_type character varying(255),
    create_date_time timestamp without time zone,
    customer_number character varying(255),
    document_class character varying(255),
    document_sequence_name character varying(255),
    document_sub_class character varying(255),
    ecommerce_partygstin character varying(255),
    first_partygstin character varying(255),
    first_party_name character varying(255),
    first_party_state character varying(255),
    gst_prc character varying(255),
    invoice_date timestamp without time zone,
    invoice_number character varying(255),
    merchantid character varying(255),
    original_counter_partygstin character varying(255),
    original_customer_state character varying(255),
    original_invoice_amount double precision,
    original_invoice_date timestamp without time zone,
    original_invoice_number character varying(255),
    payment_due_date timestamp without time zone,
    payment_method character varying(255),
    placeof_supply character varying(255),
    port_code character varying(255),
    reason_code character varying(255),
    reverse_charge_supply character varying(255),
    ship_to_country character varying(255),
    shipping_billor_billof_exportnumber character varying(255),
    shippingbillorbillofexportdate timestamp without time zone,
    status character varying(255),
    store_id bigint,
    supplytosezor_deemeded_export character varying(255),
    taxpayment_doc_num character varying(255),
    timeof_supply timestamp without time zone,
    total_amount double precision,
    totalcgst double precision,
    total_discount double precision,
    total_gst double precision,
    totaligst double precision,
    total_price double precision,
    totalsgst double precision,
    transportation_mode character varying(255),
    update_date_time timestamp without time zone,
    vehicle_number character varying(255),
    customer_gstin character varying(255),
    online character varying(255),
    is_accounting character(1) DEFAULT 'N'::bpchar,
    cds boolean,
    export boolean,
    original_invoice_id bigint,
    balance_amt double precision,
    source character varying(255),
    comments character varying(255),
    cash_discount double precision,
    trade_discount double precision
);


ALTER TABLE invoice OWNER TO java;

--
-- Name: invoice_lines; Type: TABLE; Schema: invoices; Owner: java
--

CREATE TABLE invoice_lines (
    id bigint NOT NULL,
    amount double precision NOT NULL,
    cgstamount double precision NOT NULL,
    cgstitcamount double precision NOT NULL,
    cgstrate double precision NOT NULL,
    cess_amount double precision NOT NULL,
    cessitcamount double precision NOT NULL,
    cess_rate double precision NOT NULL,
    credit_reversal_type bigint NOT NULL,
    discount double precision NOT NULL,
    goods_received_date timestamp without time zone,
    goods_type character varying(255),
    gst double precision NOT NULL,
    hsn_code character varying(255),
    igstamount double precision NOT NULL,
    igstitcamount double precision NOT NULL,
    igstrate double precision NOT NULL,
    invoice_id integer,
    invoice_number character varying(255),
    item_code character varying(255),
    item_description text,
    item_id_info character varying(255),
    line_number bigint,
    line_status character varying(255),
    line_type character varying(255),
    originalhsnorsac character varying(255),
    original_line_type character varying(255),
    provisional_assessment character varying(255),
    quantity double precision NOT NULL,
    sgstamount double precision NOT NULL,
    sgstitcamount double precision NOT NULL,
    sgstrate double precision NOT NULL,
    tcscgstamount double precision NOT NULL,
    tcscgstrate double precision NOT NULL,
    tcsigstamount double precision NOT NULL,
    tcsigstrate double precision NOT NULL,
    tcssgstamount double precision NOT NULL,
    tcssgstrate double precision NOT NULL,
    tdscgstamount double precision NOT NULL,
    tdscgstrate double precision NOT NULL,
    tdsigstamount double precision NOT NULL,
    tdsigstrate double precision NOT NULL,
    tdssgstamount double precision NOT NULL,
    tdssgstrate double precision NOT NULL,
    taxable_value double precision NOT NULL,
    total_price double precision,
    unit_price double precision NOT NULL,
    uom character varying(255),
    original_invoice_line_id bigint
);


ALTER TABLE invoice_lines OWNER TO java;

--
-- Name: item; Type: TABLE; Schema: invoices; Owner: java
--

CREATE TABLE item (
    id integer NOT NULL,
    barcode character varying(255),
    category character varying(255),
    classification_code character varying(255),
    classificationid integer,
    first_party_gstin character varying(255),
    item_code character varying(255),
    item_description character varying(255),
    item_name character varying(255),
    mrp character varying(255),
    mrp_status character varying(255),
    packsize character varying(255),
    product_type character varying(255),
    store_id bigint,
    sub_category character varying(255),
    sub_category1 character varying(255),
    third_party_organization character varying(255),
    unit_price double precision,
    uom character varying(255),
    stock_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE item OWNER TO java;

--
-- Name: item_prices; Type: TABLE; Schema: invoices; Owner: java
--

CREATE TABLE item_prices (
    id integer NOT NULL,
    active boolean,
    created_date timestamp without time zone,
    created_by character varying(255),
    end_date timestamp without time zone,
    item_code character varying(255),
    mrp character varying(255),
    start_date timestamp without time zone,
    store_id bigint,
    third_party_organization character varying(255),
    unit_price double precision,
    uom character varying(255)
);


ALTER TABLE item_prices OWNER TO java;

--
-- Name: item_trnasactions; Type: TABLE; Schema: invoices; Owner: java
--

CREATE TABLE item_trnasactions (
    id bigint NOT NULL,
    classification_code character varying(255),
    created_date timestamp without time zone,
    created_by character varying(255),
    gstin character varying(255),
    item_code character varying(255),
    open_stcok numeric(19,2),
    item_price double precision,
    qty_on_hand numeric(19,2),
    sales_qty numeric(19,2),
    total_price double precision,
    update_date timestamp without time zone,
    invoice_id integer,
    txn_type bigint,
    store_id bigint
);


ALTER TABLE item_trnasactions OWNER TO java;

--
-- Name: order_lines; Type: TABLE; Schema: invoices; Owner: java
--

CREATE TABLE order_lines (
    id bigint NOT NULL,
    amount double precision,
    cgstamount double precision,
    cgstitcamount double precision,
    cgstrate double precision,
    cess_amount double precision,
    cessitcamount double precision,
    cess_rate double precision,
    create_date_time timestamp without time zone,
    credit_reversal_type bigint NOT NULL,
    discount double precision,
    first_partygstin character varying(255),
    freightand_other_charges double precision,
    goods_received_date timestamp without time zone,
    goods_type character varying(255),
    gst double precision,
    hsn_code character varying(255),
    igstamount double precision,
    igstitcamount double precision,
    igstrate double precision,
    invoice_number character varying(255),
    item_code character varying(255),
    item_description text,
    line_number bigint,
    line_status character varying(255),
    line_type character varying(255),
    originalhsnorsac character varying(255),
    original_line_type character varying(255),
    provisional_assessment character varying(255),
    quantity double precision,
    sgstamount double precision,
    sgstitcamount double precision,
    sgstrate double precision,
    tcscgstamount double precision,
    tcscgstrate double precision,
    tcsigstamount double precision,
    tcsigstrate double precision,
    tcssgstamount double precision,
    tcssgstrate double precision,
    tdscgstamount double precision,
    tdscgstrate double precision,
    tdsigstamount double precision,
    tdsigstrate double precision,
    tdssgstamount double precision,
    tdssgstrate double precision,
    tax_rate double precision,
    taxable_value double precision,
    total_price double precision,
    unit_price double precision,
    uom character varying(255),
    update_date_time timestamp without time zone,
    orders_id integer,
    ordered_qty double precision,
    pending_qty double precision,
    item_id_info character varying(255)
);


ALTER TABLE order_lines OWNER TO java;

--
-- Name: order_transaction; Type: TABLE; Schema: invoices; Owner: java
--

CREATE TABLE order_transaction (
    id bigint NOT NULL,
    ordered_qty double precision,
    recieved_qty double precision,
    invoice_id integer,
    orders_id integer
);


ALTER TABLE order_transaction OWNER TO java;

--
-- Name: orders; Type: TABLE; Schema: invoices; Owner: java
--

CREATE TABLE orders (
    id integer NOT NULL,
    adjusted_document_date timestamp without time zone,
    adjusted_document_number character varying(255),
    advance_amount_applied double precision,
    advance_reference_number character varying(255),
    chargeglaccount character varying(255),
    counter_partygstin character varying(255),
    counter_party_name character varying(255),
    counter_party_state character varying(255),
    counterparty_type character varying(255),
    create_date_time timestamp without time zone,
    customer_number character varying(255),
    document_class character varying(255),
    document_sequence_name character varying(255),
    document_sub_class character varying(255),
    ecommerce_partygstin character varying(255),
    first_partygstin character varying(255),
    first_party_name character varying(255),
    first_party_state character varying(255),
    gst_prc character varying(255),
    invoice_date timestamp without time zone,
    invoice_number character varying(255),
    merchantid character varying(255),
    original_counter_partygstin character varying(255),
    original_customer_state character varying(255),
    original_invoice_amount double precision,
    original_invoice_date timestamp without time zone,
    original_invoice_number character varying(255),
    payment_due_date timestamp without time zone,
    payment_method character varying(255),
    placeof_supply character varying(255),
    port_code character varying(255),
    reason_code character varying(255),
    reverse_charge_supply character varying(255),
    ship_to_country character varying(255),
    shipping_billor_billof_exportnumber character varying(255),
    shippingbillorbillofexportdate timestamp without time zone,
    status character varying(255),
    store_id bigint,
    supplytosezor_deemeded_export character varying(255),
    taxpayment_doc_num character varying(255),
    timeof_supply timestamp without time zone,
    total_amount double precision,
    totalcgst double precision,
    total_discount double precision,
    total_gst double precision,
    totaligst double precision,
    total_price double precision,
    totalsgst double precision,
    transportation_mode character varying(255),
    update_date_time timestamp without time zone,
    vehicle_number character varying(255),
    customer_gstin character varying(255)
);


ALTER TABLE orders OWNER TO java;

--
-- Name: organisations; Type: TABLE; Schema: invoices; Owner: java
--

CREATE TABLE organisations (
    id integer NOT NULL,
    active boolean,
    created_at timestamp without time zone,
    end_date date,
    gstin character varying(255),
    location_id integer,
    organisation_name character varying(255),
    organisation_type character varying(255),
    pan_no character varying(255),
    party_id integer,
    registration_date date,
    registration_type character varying(255),
    state character varying(255),
    updated_at timestamp without time zone
);


ALTER TABLE organisations OWNER TO java;

--
-- Name: organisations_users; Type: TABLE; Schema: invoices; Owner: java
--

CREATE TABLE organisations_users (
    organisation_id integer NOT NULL,
    user_id integer
);


ALTER TABLE organisations_users OWNER TO java;

--
-- Name: parties; Type: TABLE; Schema: invoices; Owner: java
--

CREATE TABLE parties (
    id integer NOT NULL,
    active boolean,
    created_at timestamp without time zone,
    gstin character varying(255),
    pan_no character varying(255),
    parent_id integer,
    party_location_id integer,
    party_name character varying(255),
    party_type character varying(255),
    primary_contact_name character varying(255),
    primary_contact_number character varying(255),
    registration_date date,
    registration_type character varying(255),
    updated_at timestamp without time zone,
    website character varying(255)
);


ALTER TABLE parties OWNER TO java;

--
-- Name: partytypes; Type: TABLE; Schema: invoices; Owner: java
--

CREATE TABLE partytypes (
    id integer NOT NULL,
    created_at timestamp without time zone,
    description character varying(255),
    partytype character varying(255),
    updated_at timestamp without time zone
);


ALTER TABLE partytypes OWNER TO java;

--
-- Name: product_label; Type: TABLE; Schema: invoices; Owner: java
--

CREATE TABLE product_label (
    id integer NOT NULL,
    bar_code character varying(255),
    content oid,
    gstin character varying(255),
    item_code character varying(255),
    item_name character varying(255)
);


ALTER TABLE product_label OWNER TO java;

--
-- Name: product_master; Type: TABLE; Schema: invoices; Owner: java
--

CREATE TABLE product_master (
    id integer NOT NULL,
    barcode character varying(255),
    color character varying(255),
    created_on timestamp without time zone,
    description character varying(255),
    discount double precision,
    effective_from timestamp without time zone,
    effective_to timestamp without time zone,
    hsn_code character varying(255),
    igst_rate double precision,
    industry_classification character varying(255),
    item_code character varying(255),
    item_name character varying(255),
    last_updated_date timestamp without time zone,
    mrp character varying(255),
    packaging character varying(255),
    rtl_price double precision,
    size character varying(255),
    sku integer,
    sub_category1 integer,
    unique_identifiers integer,
    uom character varying(255),
    whl_sle_price double precision,
    category_id integer,
    sub_category_id integer
);


ALTER TABLE product_master OWNER TO java;

--
-- Name: sku_list; Type: TABLE; Schema: invoices; Owner: java
--

CREATE TABLE sku_list (
    id integer NOT NULL
);


ALTER TABLE sku_list OWNER TO java;

--
-- Name: states; Type: TABLE; Schema: invoices; Owner: java
--

CREATE TABLE states (
    state_id character varying(255) NOT NULL,
    state_name character varying(255)
);


ALTER TABLE states OWNER TO java;

--
-- Name: states_inv; Type: TABLE; Schema: invoices; Owner: java
--

CREATE TABLE states_inv (
    id integer NOT NULL,
    state_id character varying(255),
    state_name character varying(255)
);


ALTER TABLE states_inv OWNER TO java;

--
-- Name: stock; Type: TABLE; Schema: invoices; Owner: java
--

CREATE TABLE stock (
    id integer NOT NULL,
    additional1 character varying(255),
    additional2 character varying(255),
    base_uom character varying(255),
    created_date timestamp without time zone,
    first_party_gstin character varying(255),
    item_description character varying(255),
    item_id_info character varying(255),
    location_id character varying(255),
    qty_on_hand numeric(19,2),
    re_order_level numeric(19,2),
    reserved_qty numeric(19,2),
    saftey_stock numeric(19,2),
    update_date timestamp without time zone,
    store_id bigint
);


ALTER TABLE stock OWNER TO java;

--
-- Name: stock_transfer; Type: TABLE; Schema: invoices; Owner: java
--

CREATE TABLE stock_transfer (
    id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    from_store_id bigint,
    item_code character varying(255),
    quantity double precision NOT NULL,
    quantity_transfer double precision NOT NULL,
    status character varying(255),
    to_store_id bigint
);


ALTER TABLE stock_transfer OWNER TO java;

--
-- Name: sub_catalog; Type: TABLE; Schema: invoices; Owner: java
--

CREATE TABLE sub_catalog (
    sub_category_id integer NOT NULL,
    description character varying(255),
    sub_category character varying(255),
    category_id integer
);


ALTER TABLE sub_catalog OWNER TO java;

--
-- Name: tax_rates; Type: TABLE; Schema: invoices; Owner: java
--

CREATE TABLE tax_rates (
    id integer NOT NULL,
    cgstrate double precision,
    classification_code character varying(255),
    classificationid integer,
    effective_from timestamp without time zone,
    effective_to timestamp without time zone,
    igstrate double precision,
    sgstrate double precision,
    state_code character varying(255)
);


ALTER TABLE tax_rates OWNER TO java;

--
-- Name: third_party_address; Type: TABLE; Schema: invoices; Owner: java
--

CREATE TABLE third_party_address (
    address_id integer NOT NULL,
    address_line1 character varying(255),
    address_line2 character varying(255),
    address_type character varying(255),
    city character varying(255),
    country character varying(255),
    create_date_time timestamp without time zone,
    created_by character varying(255),
    customer_gstin character varying(255),
    party_id character varying(255),
    state character varying(255),
    update_date_time timestamp without time zone,
    updated_by character varying(255),
    zip_code character varying(255)
);


ALTER TABLE third_party_address OWNER TO java;

--
-- Name: third_party_organizations; Type: TABLE; Schema: invoices; Owner: java
--

CREATE TABLE third_party_organizations (
    customer_gstin character varying(255) NOT NULL,
    address_line1 character varying(255),
    address_line2 character varying(255),
    city character varying(255),
    country character varying(255),
    create_date_time timestamp without time zone,
    created_by character varying(255),
    customer_id integer,
    first_party_gstin character varying(255),
    organization_type character varying(255),
    party_type character varying(255),
    primary_contact_email character varying(255),
    primary_contact_name character varying(255),
    primary_contact_number character varying(255),
    primary_contact_type character varying(255),
    registration_number character varying(255),
    secondary_contact_email character varying(255),
    secondary_contact_name character varying(255),
    secondary_contact_number character varying(255),
    secondary_contact_type character varying(255),
    state character varying(255),
    third_party_organization character varying(255),
    third_party_type character varying(255),
    update_date_time timestamp without time zone,
    updated_by character varying(255),
    usage character varying(255),
    trade_discount double precision
);


ALTER TABLE third_party_organizations OWNER TO java;

--
-- Name: transaction_events; Type: TABLE; Schema: invoices; Owner: java
--

CREATE TABLE transaction_events (
    id bigint NOT NULL,
    txn_type character varying(255)
);


ALTER TABLE transaction_events OWNER TO java;

--
-- Name: upload_info; Type: TABLE; Schema: invoices; Owner: java
--

CREATE TABLE upload_info (
    file_name character varying(255) NOT NULL,
    id bigint,
    type character varying(255)
);


ALTER TABLE upload_info OWNER TO java;

--
-- Name: user_hsn; Type: TABLE; Schema: invoices; Owner: java
--

CREATE TABLE user_hsn (
    id integer NOT NULL,
    cgstrate double precision,
    category character varying(255),
    classification_code character varying(255),
    classification_type character varying(255),
    classificationid integer,
    create_date_time timestamp without time zone,
    created_by character varying(255),
    description text,
    effective_from timestamp without time zone,
    effective_to timestamp without time zone,
    gstin character varying(255),
    igstrate double precision,
    product_type character varying(255),
    sgstrate double precision,
    state_code character varying(255),
    update_date_time timestamp without time zone,
    updated_by character varying(255)
);


ALTER TABLE user_hsn OWNER TO java;

--
-- Name: users; Type: TABLE; Schema: invoices; Owner: java
--

CREATE TABLE users (
    id integer NOT NULL,
    contact_number character varying(255),
    created_at timestamp without time zone,
    crypted_password character varying(255),
    email character varying(255),
    end_date date,
    name character varying(255),
    party_id integer,
    password_reset_token character varying(255),
    password_salt character varying(255),
    role character varying(255),
    start_date date,
    updated_at timestamp without time zone,
    username character varying(255),
    verification_token character varying(255),
    verification_token_expiry timestamp without time zone
);


ALTER TABLE users OWNER TO java;

--
-- Name: utils_info; Type: TABLE; Schema: invoices; Owner: java
--

CREATE TABLE utils_info (
    gstin character varying(255) NOT NULL,
    tandc character varying(255)
);


ALTER TABLE utils_info OWNER TO java;

SET search_path = public, pg_catalog;

--
-- Name: account_type_seq; Type: SEQUENCE; Schema: public; Owner: java
--

CREATE SEQUENCE account_type_seq
    START WITH 1000
    INCREMENT BY 1
    MINVALUE 1000
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE account_type_seq OWNER TO java;

--
-- Name: accounting_events_seq; Type: SEQUENCE; Schema: public; Owner: java
--

CREATE SEQUENCE accounting_events_seq
    START WITH 1000
    INCREMENT BY 1
    MINVALUE 1000
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE accounting_events_seq OWNER TO java;

--
-- Name: accounts_seq; Type: SEQUENCE; Schema: public; Owner: java
--

CREATE SEQUENCE accounts_seq
    START WITH 1000
    INCREMENT BY 1
    MINVALUE 1000
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE accounts_seq OWNER TO java;

--
-- Name: addresses; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE addresses (
    id integer NOT NULL,
    address_line1 text,
    address_line2 text,
    city character varying,
    district character varying,
    state character varying,
    statecode character varying,
    country character varying,
    pincode character varying,
    address_type character varying,
    ref_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE addresses OWNER TO java;

--
-- Name: batch_job_execution; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE batch_job_execution (
    job_execution_id bigint NOT NULL,
    version bigint,
    job_instance_id bigint NOT NULL,
    create_time timestamp without time zone NOT NULL,
    start_time timestamp without time zone,
    end_time timestamp without time zone,
    status character varying(10),
    exit_code character varying(2500),
    exit_message character varying(2500),
    last_updated timestamp without time zone,
    job_configuration_location character varying(2500)
);


ALTER TABLE batch_job_execution OWNER TO java;

--
-- Name: batch_job_execution_context; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE batch_job_execution_context (
    job_execution_id bigint NOT NULL,
    short_context character varying(2500) NOT NULL,
    serialized_context text
);


ALTER TABLE batch_job_execution_context OWNER TO java;

--
-- Name: batch_job_execution_params; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE batch_job_execution_params (
    job_execution_id bigint NOT NULL,
    type_cd character varying(6) NOT NULL,
    key_name character varying(100) NOT NULL,
    string_val character varying(250),
    date_val timestamp without time zone,
    long_val bigint,
    double_val double precision,
    identifying character(1) NOT NULL
);


ALTER TABLE batch_job_execution_params OWNER TO java;

--
-- Name: batch_job_execution_seq; Type: SEQUENCE; Schema: public; Owner: java
--

CREATE SEQUENCE batch_job_execution_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE batch_job_execution_seq OWNER TO java;

--
-- Name: batch_job_instance; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE batch_job_instance (
    job_instance_id bigint NOT NULL,
    version bigint,
    job_name character varying(100) NOT NULL,
    job_key character varying(32) NOT NULL
);


ALTER TABLE batch_job_instance OWNER TO java;

--
-- Name: batch_job_seq; Type: SEQUENCE; Schema: public; Owner: java
--

CREATE SEQUENCE batch_job_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE batch_job_seq OWNER TO java;

--
-- Name: batch_step_execution; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE batch_step_execution (
    step_execution_id bigint NOT NULL,
    version bigint NOT NULL,
    step_name character varying(100) NOT NULL,
    job_execution_id bigint NOT NULL,
    start_time timestamp without time zone NOT NULL,
    end_time timestamp without time zone,
    status character varying(10),
    commit_count bigint,
    read_count bigint,
    filter_count bigint,
    write_count bigint,
    read_skip_count bigint,
    write_skip_count bigint,
    process_skip_count bigint,
    rollback_count bigint,
    exit_code character varying(2500),
    exit_message character varying(2500),
    last_updated timestamp without time zone
);


ALTER TABLE batch_step_execution OWNER TO java;

--
-- Name: batch_step_execution_context; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE batch_step_execution_context (
    step_execution_id bigint NOT NULL,
    short_context character varying(2500) NOT NULL,
    serialized_context text
);


ALTER TABLE batch_step_execution_context OWNER TO java;

--
-- Name: batch_step_execution_seq; Type: SEQUENCE; Schema: public; Owner: java
--

CREATE SEQUENCE batch_step_execution_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE batch_step_execution_seq OWNER TO java;

--
-- Name: calendar_seq; Type: SEQUENCE; Schema: public; Owner: java
--

CREATE SEQUENCE calendar_seq
    START WITH 1000
    INCREMENT BY 1
    MINVALUE 1000
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE calendar_seq OWNER TO java;

--
-- Name: catalog_list; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE catalog_list (
    id integer NOT NULL,
    category_descp character varying(255),
    category_id integer,
    category_type character varying(255),
    catagory_descp character varying(255),
    catagory_type character varying(255),
    catagory_name character varying(255),
    category_name character varying(255)
);


ALTER TABLE catalog_list OWNER TO java;

--
-- Name: catalog_master; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE catalog_master (
    category_id integer NOT NULL,
    catalog character varying(255),
    description character varying(255),
    category character varying(255)
);


ALTER TABLE catalog_master OWNER TO java;

--
-- Name: chart_of_accounts_seq; Type: SEQUENCE; Schema: public; Owner: java
--

CREATE SEQUENCE chart_of_accounts_seq
    START WITH 1000
    INCREMENT BY 1
    MINVALUE 1000
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE chart_of_accounts_seq OWNER TO java;

--
-- Name: cities; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE cities (
    city_id integer NOT NULL,
    city_name character varying(100) NOT NULL,
    state_code character varying(100) NOT NULL
);


ALTER TABLE cities OWNER TO java;

--
-- Name: classsification_codes; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE classsification_codes (
    classification_code character varying(255) NOT NULL,
    category character varying(255),
    classification_type character varying(255),
    description text,
    id integer NOT NULL,
    product_type character varying(255),
    flag character varying
);


ALTER TABLE classsification_codes OWNER TO java;

--
-- Name: config; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE config (
    id integer NOT NULL,
    description character varying(255),
    flag boolean,
    name character varying(255),
    value integer
);


ALTER TABLE config OWNER TO java;

--
-- Name: document_sequences; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE document_sequences (
    id integer NOT NULL,
    doc_subclass character varying(255),
    effective_from timestamp without time zone,
    effective_to timestamp without time zone,
    end_number integer NOT NULL,
    organization_name character varying(255),
    prefix character varying(255) NOT NULL,
    start_number integer NOT NULL,
    last_number integer,
    gstin character varying(255) NOT NULL,
    doc_type character varying(255)
);


ALTER TABLE document_sequences OWNER TO java;

--
-- Name: file_event; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE file_event (
    id bigint NOT NULL,
    end_time timestamp without time zone,
    falied_records_count integer,
    file_name character varying(255),
    gstin character varying(255),
    start_time timestamp without time zone,
    status character varying(255),
    success_records_count integer,
    total_records_count integer,
    uploaded_by character varying(255),
    uploaded_on timestamp without time zone
);


ALTER TABLE file_event OWNER TO java;

--
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: public; Owner: java
--

CREATE SEQUENCE hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hibernate_sequence OWNER TO java;

--
-- Name: hsn_codes; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE hsn_codes (
    id integer,
    hsn_code integer,
    "name of commodity" character varying,
    chapter character varying,
    sch character varying,
    gst character varying
);


ALTER TABLE hsn_codes OWNER TO java;

--
-- Name: hsn_party; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE hsn_party (
    id integer NOT NULL,
    category character varying(255),
    classfication_id integer NOT NULL,
    classification_code character varying(255),
    classification_type character varying(255),
    description character varying(255),
    flag boolean NOT NULL,
    gstin character varying(255),
    product_type character varying(255)
);


ALTER TABLE hsn_party OWNER TO java;

--
-- Name: invalid_invoices; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE invalid_invoices (
    id integer NOT NULL,
    file_event_id bigint,
    gstin character varying(255),
    invoice_json text,
    created_date timestamp without time zone,
    update_date timestamp without time zone
);


ALTER TABLE invalid_invoices OWNER TO java;

--
-- Name: invoice; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE invoice (
    invoice_number character varying(255) NOT NULL,
    counter_partygstin character varying(255),
    counter_party_name character varying(255),
    create_date_time timestamp without time zone,
    document_class character varying(255),
    gst_prc character varying,
    id integer NOT NULL,
    invoice_date timestamp without time zone,
    placeof_supply character varying(255),
    timeof_supply timestamp without time zone,
    transportation_mode character varying(255),
    update_date_time timestamp without time zone,
    vehicle_number character varying(255),
    customer_number character varying(255),
    first_partygstin character varying(255),
    first_party_name character varying(255),
    original_invoice_date timestamp without time zone,
    status character varying(255),
    total_amount double precision,
    totalcgst double precision,
    total_discount double precision,
    total_gst double precision,
    totaligst double precision,
    totalsgst double precision,
    customer_gstin character varying(255),
    total_price double precision,
    adjusted_document_date timestamp without time zone,
    adjusted_document_number character varying(255),
    advance_amount_applied double precision,
    advance_reference_number character varying(255),
    chargeglaccount character varying(255),
    counter_party_state character varying(255),
    counterparty_type character varying(255),
    document_sequence_name character varying(255),
    document_sub_class character varying(255),
    ecommerce_partygstin character varying(255),
    merchantid character varying(255),
    original_counter_partygstin character varying(255),
    original_customer_state character varying(255),
    original_invoice_amount double precision,
    original_invoice_number character varying(255),
    payment_method character varying(255),
    port_code character varying(255),
    reason_code character varying(255),
    reverse_charge_supply character varying(255),
    ship_to_country character varying(255),
    shipping_billor_billof_exportnumber character varying(255),
    shippingbillorbillofexportdate timestamp without time zone,
    supplytosezor_deemeded_export character varying(255),
    taxpayment_doc_num character varying(255),
    payment_due_date timestamp without time zone,
    first_party_state character varying(255),
    additional_info character varying(255),
    counter_partypocemail_id character varying(255),
    file_event_id bigint,
    invoice_category character varying(255),
    invoice_type character varying(255),
    is_validated character varying(255),
    pre_gst character varying(255),
    retperiod character varying(255),
    validation_response bytea,
    vendorgstin character varying(255),
    store_id bigint,
    online character varying(255),
    is_accounting character(1) DEFAULT 'N'::bpchar
);


ALTER TABLE invoice OWNER TO java;

--
-- Name: invoice_lines; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE invoice_lines (
    id bigint NOT NULL,
    amount double precision NOT NULL,
    cgstamount double precision NOT NULL,
    cgstitcamount double precision NOT NULL,
    cgstrate double precision NOT NULL,
    cess_amount double precision NOT NULL,
    cessitcamount double precision NOT NULL,
    cess_rate double precision NOT NULL,
    credit_reversal_type bigint NOT NULL,
    discount double precision NOT NULL,
    goods_received_date timestamp without time zone,
    goods_type character varying(255),
    gst double precision NOT NULL,
    hsn_code character varying(255),
    igstamount double precision NOT NULL,
    igstitcamount double precision NOT NULL,
    igstrate double precision NOT NULL,
    invoice_number character varying(255),
    item_code text,
    item_description text,
    line_number bigint,
    line_status character varying(255),
    line_type character varying(255),
    originalhsnorsac character varying(255),
    original_line_type character varying(255),
    provisional_assessment character varying(255),
    quantity double precision NOT NULL,
    sgstamount double precision NOT NULL,
    sgstitcamount double precision NOT NULL,
    sgstrate double precision NOT NULL,
    tcscgstamount double precision NOT NULL,
    tcscgstrate double precision NOT NULL,
    tcsigstamount double precision NOT NULL,
    tcsigstrate double precision NOT NULL,
    tcssgstamount double precision NOT NULL,
    tcssgstrate double precision NOT NULL,
    tdscgstamount double precision NOT NULL,
    tdscgstrate double precision NOT NULL,
    tdsigstamount double precision NOT NULL,
    tdsigstrate double precision NOT NULL,
    tdssgstamount double precision NOT NULL,
    tdssgstrate double precision NOT NULL,
    taxable_value double precision NOT NULL,
    total_price double precision,
    unit_price integer NOT NULL,
    uom character varying(255),
    invoice_id integer,
    create_date_time timestamp without time zone,
    first_partygstin character varying(255),
    freightand_other_charges double precision,
    invoice bytea,
    update_date_time timestamp without time zone,
    tax_rate double precision,
    item_id_info character varying(255)
);


ALTER TABLE invoice_lines OWNER TO java;

--
-- Name: item; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE item (
    item_code character varying(255) NOT NULL,
    classification_code character varying(255),
    item_description character varying(255),
    classificationid integer,
    item_name character varying,
    gstin character varying(255),
    third_party_organization character varying(255),
    unit_price double precision,
    uom character varying(255),
    first_party_gstin character varying(255),
    product_type character varying(255),
    id integer NOT NULL,
    stock_id integer,
    barcode character varying(255),
    category character varying(255),
    mrp character varying(255),
    packsize character varying(255),
    sub_category character varying(255),
    sub_category1 character varying(255),
    mrp_status character varying(255),
    store_id bigint
);


ALTER TABLE item OWNER TO java;

--
-- Name: item_id_seq; Type: SEQUENCE; Schema: public; Owner: java
--

CREATE SEQUENCE item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE item_id_seq OWNER TO java;

--
-- Name: item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: java
--

ALTER SEQUENCE item_id_seq OWNED BY item.id;


--
-- Name: item_prices; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE item_prices (
    item_code character varying(255) NOT NULL,
    id integer NOT NULL,
    third_party_organization character varying(255),
    uom character varying(255),
    unit_price bigint NOT NULL,
    active boolean,
    created_date timestamp without time zone,
    created_by character varying(255),
    end_date timestamp without time zone,
    mrp character varying(255),
    start_date timestamp without time zone,
    store_id bigint
);


ALTER TABLE item_prices OWNER TO java;

--
-- Name: item_trnasactions; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE item_trnasactions (
    id bigint NOT NULL,
    created_by character varying(255),
    created_on timestamp without time zone,
    updated_on timestamp without time zone,
    invoice_id integer,
    txn_type bigint,
    item_id integer,
    created_date timestamp without time zone,
    gstin character varying(255),
    item_code character varying(255),
    open_stcok numeric(19,2),
    qty_on_hand numeric(19,2),
    sales_qty numeric(19,2),
    update_date timestamp without time zone,
    item_price double precision,
    total_price double precision,
    classification_code character varying(255),
    store_id bigint
);


ALTER TABLE item_trnasactions OWNER TO java;

--
-- Name: journals_seq; Type: SEQUENCE; Schema: public; Owner: java
--

CREATE SEQUENCE journals_seq
    START WITH 1000
    INCREMENT BY 1
    MINVALUE 1000
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE journals_seq OWNER TO java;

--
-- Name: order_lines; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE order_lines (
    id bigint NOT NULL,
    amount double precision,
    cgstamount double precision,
    cgstitcamount double precision,
    cgstrate double precision,
    cess_amount double precision,
    cessitcamount double precision,
    cess_rate double precision,
    create_date_time timestamp without time zone,
    credit_reversal_type bigint NOT NULL,
    discount double precision,
    first_partygstin character varying(255),
    freightand_other_charges double precision,
    goods_received_date timestamp without time zone,
    goods_type character varying(255),
    gst double precision,
    hsn_code character varying(255),
    igstamount double precision,
    igstitcamount double precision,
    igstrate double precision,
    invoice_id integer,
    invoice_number character varying(255),
    item_code character varying(255),
    item_description text,
    line_number bigint,
    line_status character varying(255),
    line_type character varying(255),
    originalhsnorsac character varying(255),
    original_line_type character varying(255),
    provisional_assessment character varying(255),
    quantity double precision,
    sgstamount double precision,
    sgstitcamount double precision,
    sgstrate double precision,
    tcscgstamount double precision,
    tcscgstrate double precision,
    tcsigstamount double precision,
    tcsigstrate double precision,
    tcssgstamount double precision,
    tcssgstrate double precision,
    tdscgstamount double precision,
    tdscgstrate double precision,
    tdsigstamount double precision,
    tdsigstrate double precision,
    tdssgstamount double precision,
    tdssgstrate double precision,
    tax_rate double precision,
    taxable_value double precision,
    total_price double precision,
    unit_price double precision,
    uom character varying(255),
    update_date_time timestamp without time zone
);


ALTER TABLE order_lines OWNER TO java;

--
-- Name: orders; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE orders (
    id integer NOT NULL,
    adjusted_document_date timestamp without time zone,
    adjusted_document_number character varying(255),
    advance_amount_applied double precision,
    advance_reference_number character varying(255),
    chargeglaccount character varying(255),
    counter_partygstin character varying(255),
    counter_party_name character varying(255),
    counter_party_state character varying(255),
    counterparty_type character varying(255),
    create_date_time timestamp without time zone,
    customer_number character varying(255),
    document_class character varying(255),
    document_sequence_name character varying(255),
    document_sub_class character varying(255),
    ecommerce_partygstin character varying(255),
    first_partygstin character varying(255),
    first_party_name character varying(255),
    first_party_state character varying(255),
    gst_prc character varying(255),
    invoice_date timestamp without time zone,
    invoice_number character varying(255),
    merchantid character varying(255),
    original_counter_partygstin character varying(255),
    original_customer_state character varying(255),
    original_invoice_amount double precision,
    original_invoice_date timestamp without time zone,
    original_invoice_number character varying(255),
    payment_due_date timestamp without time zone,
    payment_method character varying(255),
    placeof_supply character varying(255),
    port_code character varying(255),
    reason_code character varying(255),
    reverse_charge_supply character varying(255),
    ship_to_country character varying(255),
    shipping_billor_billof_exportnumber character varying(255),
    shippingbillorbillofexportdate timestamp without time zone,
    status character varying(255),
    store_id bigint,
    supplytosezor_deemeded_export character varying(255),
    taxpayment_doc_num character varying(255),
    timeof_supply timestamp without time zone,
    total_amount double precision,
    totalcgst double precision,
    total_discount double precision,
    total_gst double precision,
    totaligst double precision,
    total_price double precision,
    totalsgst double precision,
    transportation_mode character varying(255),
    update_date_time timestamp without time zone,
    vehicle_number character varying(255),
    customer_gstin character varying(255)
);


ALTER TABLE orders OWNER TO java;

--
-- Name: organisations; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE organisations (
    id integer NOT NULL,
    party_id integer,
    organisation_type character varying,
    organisation_name character varying,
    registration_type character varying,
    pan_no character varying,
    gstin character varying,
    registration_date date,
    active boolean,
    location_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    end_date date,
    state character varying,
    customer_id integer NOT NULL
);


ALTER TABLE organisations OWNER TO java;

--
-- Name: organisations_users; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE organisations_users (
    organisation_id integer,
    user_id integer
);


ALTER TABLE organisations_users OWNER TO java;

--
-- Name: parties; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE parties (
    id integer NOT NULL,
    party_name character varying,
    party_type character varying,
    registration_date date,
    active boolean,
    party_location_id integer,
    primary_contact_name character varying,
    primary_contact_number character varying,
    website character varying,
    pan_no character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    registration_type character varying,
    gstin character varying,
    parent_id integer
);


ALTER TABLE parties OWNER TO java;

--
-- Name: party_account_control_seq; Type: SEQUENCE; Schema: public; Owner: java
--

CREATE SEQUENCE party_account_control_seq
    START WITH 1000
    INCREMENT BY 1
    MINVALUE 1000
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE party_account_control_seq OWNER TO java;

--
-- Name: partytypes; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE partytypes (
    id integer NOT NULL,
    created_at timestamp without time zone,
    description character varying(255),
    partytype character varying(255),
    updated_at timestamp without time zone
);


ALTER TABLE partytypes OWNER TO java;

--
-- Name: periods_seq; Type: SEQUENCE; Schema: public; Owner: java
--

CREATE SEQUENCE periods_seq
    START WITH 1000
    INCREMENT BY 1
    MINVALUE 1000
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE periods_seq OWNER TO java;

--
-- Name: product_label; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE product_label (
    id integer NOT NULL,
    bar_code character varying(255),
    gstin character varying(255),
    item_code character varying(255),
    content oid,
    item_name character varying(255)
);


ALTER TABLE product_label OWNER TO java;

--
-- Name: product_master; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE product_master (
    id integer NOT NULL,
    barcode character varying(255),
    color character varying(255),
    created_on timestamp without time zone,
    description character varying(255),
    discount double precision,
    effective_from timestamp without time zone,
    effective_to timestamp without time zone,
    hsn_code character varying(255),
    industry_classification character varying(255),
    item_code character varying(255),
    item_name character varying(255),
    last_updated_date timestamp without time zone,
    mrp character varying(255),
    packaging character varying(255),
    rtl_price double precision,
    size character varying(255),
    sku integer,
    unique_identifiers integer,
    uom character varying(255),
    whl_sle_price double precision,
    category_id integer,
    sub_category_id integer,
    igst_rate integer,
    sub_category1 integer
);


ALTER TABLE product_master OWNER TO java;

--
-- Name: reasoncode; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE reasoncode (
    id integer NOT NULL,
    reason_code character varying(255),
    reasoncode_id integer NOT NULL
);


ALTER TABLE reasoncode OWNER TO java;

--
-- Name: states; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE states (
    state_id integer NOT NULL,
    state_name character varying
);


ALTER TABLE states OWNER TO java;

--
-- Name: states_inv; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE states_inv (
    id integer NOT NULL,
    state_id character varying(255),
    state_name character varying(255)
);


ALTER TABLE states_inv OWNER TO java;

--
-- Name: statuses_seq; Type: SEQUENCE; Schema: public; Owner: java
--

CREATE SEQUENCE statuses_seq
    START WITH 1000
    INCREMENT BY 1
    MINVALUE 1000
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE statuses_seq OWNER TO java;

--
-- Name: stock; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE stock (
    id integer NOT NULL,
    additional1 character varying(255),
    additional2 character varying(255),
    base_uom character varying(255),
    created_date timestamp without time zone,
    first_party_gstin character varying(255),
    item_description character varying(255),
    item_id_info character varying(255),
    location_id character varying(255),
    qty_on_hand numeric(19,2),
    re_order_level numeric(19,2),
    reserved_qty numeric(19,2),
    saftey_stock numeric(19,2),
    update_date timestamp without time zone,
    store_id bigint
);


ALTER TABLE stock OWNER TO java;

--
-- Name: sub_catalog; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE sub_catalog (
    sub_category_id integer NOT NULL,
    category_id integer,
    description character varying(255),
    sub_category character varying(255)
);


ALTER TABLE sub_catalog OWNER TO java;

--
-- Name: summary_seq; Type: SEQUENCE; Schema: public; Owner: java
--

CREATE SEQUENCE summary_seq
    START WITH 1000
    INCREMENT BY 1
    MINVALUE 1000
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE summary_seq OWNER TO java;

--
-- Name: tax_rates; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE tax_rates (
    id integer NOT NULL,
    cgstrate character varying(255),
    classification_code character varying(255),
    effective_from timestamp without time zone,
    effective_to timestamp without time zone,
    igstrate character varying(255),
    sgstrate character varying(255),
    state_code character varying(255),
    classification_id integer NOT NULL,
    classificationid integer
);


ALTER TABLE tax_rates OWNER TO java;

--
-- Name: third_party_address; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE third_party_address (
    address_line1 character varying(255),
    address_line2 character varying(255),
    address_type character varying(255),
    city character varying(255),
    country character varying(255),
    create_date_time timestamp without time zone,
    created_by character varying(255),
    customer_gstin character varying(255),
    party_id character varying(255),
    state character varying(255),
    update_date_time timestamp without time zone,
    updated_by character varying(255),
    zip_code character varying(255),
    address_id integer NOT NULL
);


ALTER TABLE third_party_address OWNER TO java;

--
-- Name: third_party_organizations; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE third_party_organizations (
    customer_id integer NOT NULL,
    address_line1 character varying(255),
    address_line2 character varying(255),
    city character varying(255),
    country character varying(255),
    organization_type character varying(255),
    party_type character varying(255),
    primary_contact_email character varying(255),
    primary_contact_name character varying(255),
    primary_contact_number character varying(255),
    primary_contact_type character varying(255),
    registration_number character varying(255),
    secondary_contact_email character varying(255),
    secondary_contact_name character varying(255),
    secondary_contact_number character varying(255),
    secondary_contact_type character varying(255),
    state character varying(255),
    third_party_organization text,
    usage character varying(255),
    customer_gstin character varying NOT NULL,
    create_date_time timestamp without time zone,
    created_by character varying(255),
    update_date_time timestamp without time zone,
    updated_by character varying(255),
    first_party_gstin character varying(255),
    third_party_type character varying(255)
);


ALTER TABLE third_party_organizations OWNER TO java;

--
-- Name: thrid_party_price; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE thrid_party_price (
    id integer
);


ALTER TABLE thrid_party_price OWNER TO java;

--
-- Name: transaction_events; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE transaction_events (
    id bigint NOT NULL,
    txn_type character varying(255)
);


ALTER TABLE transaction_events OWNER TO java;

--
-- Name: transactions_seq; Type: SEQUENCE; Schema: public; Owner: java
--

CREATE SEQUENCE transactions_seq
    START WITH 1000
    INCREMENT BY 1
    MINVALUE 1000
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE transactions_seq OWNER TO java;

--
-- Name: unitofmeasurements; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE unitofmeasurements (
    id integer NOT NULL,
    uom_code character varying(255),
    uom_name character varying(255)
);


ALTER TABLE unitofmeasurements OWNER TO java;

--
-- Name: upload_info; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE upload_info (
    file_name character varying(255) NOT NULL,
    id bigint,
    type character varying(255)
);


ALTER TABLE upload_info OWNER TO java;

--
-- Name: user_hsn; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE user_hsn (
    id integer NOT NULL,
    cgstrate character varying(255),
    category character varying(255),
    classification_code character varying(255),
    classification_type character varying(255),
    create_date_time timestamp without time zone,
    created_by character varying(255),
    description text,
    effective_from timestamp without time zone,
    effective_to timestamp without time zone,
    gstin character varying(255),
    igstrate character varying(255),
    product_type character varying(255),
    sgstrate character varying(255),
    state_code character varying(255),
    update_date_time timestamp without time zone,
    updated_by character varying(255),
    classificationid integer
);


ALTER TABLE user_hsn OWNER TO java;

--
-- Name: user_info_seq; Type: SEQUENCE; Schema: public; Owner: java
--

CREATE SEQUENCE user_info_seq
    START WITH 1000
    INCREMENT BY 1
    MINVALUE 1000
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE user_info_seq OWNER TO java;

--
-- Name: users; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE users (
    id integer NOT NULL,
    name character varying,
    username character varying(255),
    email character varying(255),
    contact_number character varying,
    password_salt character varying,
    crypted_password character varying,
    party_id integer,
    verification_token character varying,
    verification_token_expiry timestamp without time zone,
    password_reset_token character varying,
    end_date date,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    role character varying,
    start_date date
);


ALTER TABLE users OWNER TO java;

--
-- Name: utils_info; Type: TABLE; Schema: public; Owner: java
--

CREATE TABLE utils_info (
    gstin character varying(255) NOT NULL,
    tandc character varying(255)
);


ALTER TABLE utils_info OWNER TO java;

SET search_path = user_master, pg_catalog;

--
-- Name: addresses; Type: TABLE; Schema: user_master; Owner: java
--

CREATE TABLE addresses (
    id integer NOT NULL,
    address_line1 character varying(255),
    address_line2 character varying(255),
    address_type character varying(255),
    city character varying(255),
    country character varying(255),
    created_at timestamp without time zone,
    district character varying(255),
    location character varying(255),
    pincode character varying(255),
    ref_id integer,
    state character varying(255),
    statecode character varying(255),
    updated_at timestamp without time zone
);


ALTER TABLE addresses OWNER TO java;

--
-- Name: app_module; Type: TABLE; Schema: user_master; Owner: java
--

CREATE TABLE app_module (
    id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    active boolean,
    module_name character varying(255),
    scope character varying(255),
    subscription_plans_id integer
);


ALTER TABLE app_module OWNER TO java;

--
-- Name: app_module_master; Type: TABLE; Schema: user_master; Owner: java
--

CREATE TABLE app_module_master (
    id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    active boolean,
    module_name character varying(255),
    scope character varying(255)
);


ALTER TABLE app_module_master OWNER TO java;

--
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: user_master; Owner: java
--

CREATE SEQUENCE hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hibernate_sequence OWNER TO java;

--
-- Name: industries; Type: TABLE; Schema: user_master; Owner: java
--

CREATE TABLE industries (
    id integer NOT NULL,
    industry_name character varying(255)
);


ALTER TABLE industries OWNER TO java;

--
-- Name: organisation_region; Type: TABLE; Schema: user_master; Owner: java
--

CREATE TABLE organisation_region (
    id integer NOT NULL,
    region character varying(255),
    party integer
);


ALTER TABLE organisation_region OWNER TO java;

--
-- Name: organisations; Type: TABLE; Schema: user_master; Owner: java
--

CREATE TABLE organisations (
    id integer NOT NULL,
    active boolean,
    created_at timestamp without time zone,
    current_gross_turnover numeric(19,2),
    data_mismatch_tolerance double precision,
    end_date date,
    gstin character varying(255),
    gstn_user_name character varying(255),
    location_id integer,
    organisation_name character varying(255),
    organisation_type character varying(255),
    pan_no character varying(255),
    party_id_ref integer,
    previous_gross_turnover numeric(19,2),
    registration_date date,
    registration_type character varying(255),
    source character varying(255),
    state character varying(255),
    updated_at timestamp without time zone,
    address_id integer,
    party_id integer,
    region_id_ref integer
);


ALTER TABLE organisations OWNER TO java;

--
-- Name: organisations_users; Type: TABLE; Schema: user_master; Owner: java
--

CREATE TABLE organisations_users (
    organisation_id integer NOT NULL,
    user_id integer
);


ALTER TABLE organisations_users OWNER TO java;

--
-- Name: parties; Type: TABLE; Schema: user_master; Owner: java
--

CREATE TABLE parties (
    id integer NOT NULL,
    active boolean,
    branch_name character varying(255),
    business_size character varying(255),
    created_at timestamp without time zone,
    gstin character varying(255),
    image_data character varying(255),
    licence_id character varying(255),
    pan_no character varying(255),
    parent_id integer,
    partner integer,
    partner_code character varying(255),
    party_location_id integer,
    party_name character varying(255),
    party_type character varying(255),
    primary_contact_name character varying(255),
    primary_contact_number character varying(255),
    refund numeric(19,2),
    registration_date date,
    registration_number character varying(255),
    registration_type character varying(255),
    source character varying(255),
    updated_at timestamp without time zone,
    website character varying(255),
    subscription_usage_id integer,
    user_id integer
);


ALTER TABLE parties OWNER TO java;

--
-- Name: partners; Type: TABLE; Schema: user_master; Owner: java
--

CREATE TABLE partners (
    id integer NOT NULL,
    code character varying(255),
    created_at timestamp without time zone,
    effective_from date,
    effective_to date,
    encrypted_code character varying(255),
    logo_content_type character varying(255),
    logo_file_name character varying(255),
    logo_file_size integer,
    logo_type character varying(255),
    logo_updated_at timestamp without time zone,
    name character varying(255),
    token character varying(255),
    updated_at timestamp without time zone
);


ALTER TABLE partners OWNER TO java;

--
-- Name: party_logo; Type: TABLE; Schema: user_master; Owner: java
--

CREATE TABLE party_logo (
    id bigint NOT NULL,
    gstin character varying(255),
    logo bytea,
    logo_name character varying(255)
);


ALTER TABLE party_logo OWNER TO java;

--
-- Name: party_logo_id_seq; Type: SEQUENCE; Schema: user_master; Owner: java
--

CREATE SEQUENCE party_logo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE party_logo_id_seq OWNER TO java;

--
-- Name: party_logo_id_seq; Type: SEQUENCE OWNED BY; Schema: user_master; Owner: java
--

ALTER SEQUENCE party_logo_id_seq OWNED BY party_logo.id;


--
-- Name: party_partners; Type: TABLE; Schema: user_master; Owner: java
--

CREATE TABLE party_partners (
    id integer NOT NULL,
    created_at timestamp without time zone,
    effective_from date,
    effective_to date,
    partner_code character varying(255),
    partner_id integer,
    partner_type character varying(255),
    party_id integer,
    updated_at timestamp without time zone
);


ALTER TABLE party_partners OWNER TO java;

--
-- Name: party_references; Type: TABLE; Schema: user_master; Owner: java
--

CREATE TABLE party_references (
    id integer NOT NULL,
    common_user_id integer,
    email character varying(255),
    first_party_gstin character varying(255),
    inv_party_id integer,
    ret_party_id integer
);


ALTER TABLE party_references OWNER TO java;

--
-- Name: party_roles; Type: TABLE; Schema: user_master; Owner: java
--

CREATE TABLE party_roles (
    id bigint NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    application character varying(255),
    description character varying(255),
    name character varying(255),
    party_id integer
);


ALTER TABLE party_roles OWNER TO java;

--
-- Name: privileges; Type: TABLE; Schema: user_master; Owner: java
--

CREATE TABLE privileges (
    id bigint NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    active boolean,
    code character varying(255),
    privilege_name character varying(255),
    app_module_id integer,
    application character varying(255),
    name character varying(255)
);


ALTER TABLE privileges OWNER TO java;

--
-- Name: privileges_master; Type: TABLE; Schema: user_master; Owner: java
--

CREATE TABLE privileges_master (
    id bigint NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    active boolean,
    code character varying(255),
    privilege_name character varying(255),
    app_module_master_id integer
);


ALTER TABLE privileges_master OWNER TO java;

--
-- Name: role_privileges; Type: TABLE; Schema: user_master; Owner: java
--

CREATE TABLE role_privileges (
    id bigint NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    active boolean NOT NULL,
    code character varying(255),
    plan_id bigint,
    plan_name character varying(255),
    privilege_id bigint,
    privilege_name character varying(255),
    role_id bigint,
    role_name character varying(255),
    module_active boolean DEFAULT false,
    module_id bigint,
    module_name character varying(255)
);


ALTER TABLE role_privileges OWNER TO java;

--
-- Name: roles; Type: TABLE; Schema: user_master; Owner: java
--

CREATE TABLE roles (
    id bigint NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    application character varying(255),
    description character varying(255),
    name character varying(255)
);


ALTER TABLE roles OWNER TO java;

--
-- Name: store; Type: TABLE; Schema: user_master; Owner: java
--

CREATE TABLE store (
    id bigint NOT NULL,
    store_name character varying(255),
    address_id integer,
    org_id integer
);


ALTER TABLE store OWNER TO java;

--
-- Name: store_users; Type: TABLE; Schema: user_master; Owner: java
--

CREATE TABLE store_users (
    store_id integer NOT NULL,
    organisation_id integer,
    user_id integer
);


ALTER TABLE store_users OWNER TO java;

--
-- Name: subscription_plans; Type: TABLE; Schema: user_master; Owner: java
--

CREATE TABLE subscription_plans (
    id integer NOT NULL,
    active boolean NOT NULL,
    child_offering_code character varying(255),
    created_at timestamp without time zone,
    description character varying(255),
    end_date timestamp without time zone,
    max_gstins integer,
    max_transactions integer,
    offering_code character varying(255),
    offering_name character varying(255),
    offering_price double precision,
    offering_type character varying(255),
    offering_validity integer,
    product_catalog integer,
    start_date timestamp without time zone,
    updated_at timestamp without time zone,
    partner_id integer,
    scope character varying(255),
    max_users integer
);


ALTER TABLE subscription_plans OWNER TO java;

--
-- Name: subscription_usage; Type: TABLE; Schema: user_master; Owner: java
--

CREATE TABLE subscription_usage (
    id integer NOT NULL,
    active boolean NOT NULL,
    available_catalog integer,
    available_gstins integer,
    available_transactions integer,
    created_at timestamp without time zone,
    subscription_end_date timestamp without time zone,
    subscription_start_date timestamp without time zone,
    updated_at timestamp without time zone,
    partner_id integer,
    party_id integer,
    subscribed_plan_id integer,
    available_users integer
);


ALTER TABLE subscription_usage OWNER TO java;

--
-- Name: user_session; Type: TABLE; Schema: user_master; Owner: java
--

CREATE TABLE user_session (
    id integer NOT NULL,
    device_key character varying(255),
    expiry_time timestamp without time zone,
    start_time timestamp without time zone,
    status character varying(255),
    token character varying(255),
    user_id integer
);


ALTER TABLE user_session OWNER TO java;

--
-- Name: users; Type: TABLE; Schema: user_master; Owner: java
--

CREATE TABLE users (
    id integer NOT NULL,
    contact_number character varying(255),
    created_at timestamp without time zone,
    crypted_password character varying(255),
    email character varying(255),
    end_date date,
    name character varying(255),
    org_id integer,
    party_id integer,
    password_reset_token character varying(255),
    password_salt character varying(255),
    plan integer,
    role character varying(255),
    start_date date,
    store_id integer,
    updated_at timestamp without time zone,
    username character varying(255),
    verification_token character varying(255),
    verification_token_expiry timestamp without time zone,
    source character varying(255),
    token character varying(255),
    user_type character varying(255),
    salt_key character varying(255),
    otp character varying(255),
    otp_status boolean DEFAULT false NOT NULL,
    verifiy_otp_expiry timestamp without time zone,
    orgregionid character varying(255),
    org_region_id integer
);


ALTER TABLE users OWNER TO java;

SET search_path = user_masterbackup, pg_catalog;

--
-- Name: addresses; Type: TABLE; Schema: user_masterbackup; Owner: java
--

CREATE TABLE addresses (
    id integer NOT NULL,
    address_line1 character varying(255),
    address_line2 character varying(255),
    address_type character varying(255),
    city character varying(255),
    country character varying(255),
    created_at timestamp without time zone,
    district character varying(255),
    location character varying(255),
    pincode character varying(255),
    ref_id integer,
    state character varying(255),
    statecode character varying(255),
    updated_at timestamp without time zone
);


ALTER TABLE addresses OWNER TO java;

--
-- Name: application_features; Type: TABLE; Schema: user_masterbackup; Owner: java
--

CREATE TABLE application_features (
    id bigint NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    active boolean,
    feature_name character varying(255),
    planid integer,
    plan_name character varying(255)
);


ALTER TABLE application_features OWNER TO java;

--
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: user_masterbackup; Owner: java
--

CREATE SEQUENCE hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hibernate_sequence OWNER TO java;

--
-- Name: organisations; Type: TABLE; Schema: user_masterbackup; Owner: java
--

CREATE TABLE organisations (
    id integer NOT NULL,
    active boolean,
    created_at timestamp without time zone,
    current_gross_turnover numeric(19,2),
    data_mismatch_tolerance double precision,
    end_date date,
    gstin character varying(255),
    gstn_user_name character varying(255),
    location_id integer,
    organisation_name character varying(255),
    organisation_type character varying(255),
    pan_no character varying(255),
    party_id_ref integer,
    previous_gross_turnover numeric(19,2),
    registration_date date,
    registration_type character varying(255),
    state character varying(255),
    updated_at timestamp without time zone,
    address_id integer,
    party_id integer,
    source character varying(255)
);


ALTER TABLE organisations OWNER TO java;

--
-- Name: organisations_users; Type: TABLE; Schema: user_masterbackup; Owner: java
--

CREATE TABLE organisations_users (
    organisation_id integer NOT NULL,
    user_id integer
);


ALTER TABLE organisations_users OWNER TO java;

--
-- Name: parties; Type: TABLE; Schema: user_masterbackup; Owner: java
--

CREATE TABLE parties (
    id integer NOT NULL,
    active boolean,
    branch_name character varying(255),
    business_size character varying(255),
    created_at timestamp without time zone,
    gstin character varying(255),
    image_data character varying(255),
    licence_id character varying(255),
    pan_no character varying(255),
    parent_id integer,
    partner_code character varying(255),
    party_location_id integer,
    party_name character varying(255),
    party_type character varying(255),
    primary_contact_name character varying(255),
    primary_contact_number character varying(255),
    refund numeric(19,2),
    registration_date date,
    registration_number character varying(255),
    registration_type character varying(255),
    updated_at timestamp without time zone,
    website character varying(255),
    user_id integer,
    source character varying(255),
    subscription_usage_id integer
);


ALTER TABLE parties OWNER TO java;

--
-- Name: partners; Type: TABLE; Schema: user_masterbackup; Owner: java
--

CREATE TABLE partners (
    id integer NOT NULL,
    code character varying(255),
    created_at timestamp without time zone,
    effective_from date,
    effective_to date,
    encrypted_code character varying(255),
    logo_content_type character varying(255),
    logo_file_name character varying(255),
    logo_file_size integer,
    logo_type character varying(255),
    logo_updated_at timestamp without time zone,
    name character varying(255),
    updated_at timestamp without time zone
);


ALTER TABLE partners OWNER TO java;

--
-- Name: party_logo; Type: TABLE; Schema: user_masterbackup; Owner: java
--

CREATE TABLE party_logo (
    id bigint NOT NULL,
    gstin character varying(255),
    logo bytea,
    logo_name character varying(255)
);


ALTER TABLE party_logo OWNER TO java;

--
-- Name: party_logo_id_seq; Type: SEQUENCE; Schema: user_masterbackup; Owner: java
--

CREATE SEQUENCE party_logo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE party_logo_id_seq OWNER TO java;

--
-- Name: party_logo_id_seq; Type: SEQUENCE OWNED BY; Schema: user_masterbackup; Owner: java
--

ALTER SEQUENCE party_logo_id_seq OWNED BY party_logo.id;


--
-- Name: party_partners; Type: TABLE; Schema: user_masterbackup; Owner: java
--

CREATE TABLE party_partners (
    id integer NOT NULL,
    created_at timestamp without time zone,
    effective_from date,
    effective_to date,
    partner_code character varying(255),
    partner_id integer,
    partner_type character varying(255),
    party_id integer,
    updated_at timestamp without time zone
);


ALTER TABLE party_partners OWNER TO java;

--
-- Name: party_references; Type: TABLE; Schema: user_masterbackup; Owner: java
--

CREATE TABLE party_references (
    id integer NOT NULL,
    common_user_id integer,
    email character varying(255),
    first_party_gstin character varying(255),
    inv_party_id integer,
    ret_party_id integer
);


ALTER TABLE party_references OWNER TO java;

--
-- Name: party_roles; Type: TABLE; Schema: user_masterbackup; Owner: java
--

CREATE TABLE party_roles (
    id bigint NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    application character varying(255),
    description character varying(255),
    name character varying(255),
    party_id integer
);


ALTER TABLE party_roles OWNER TO java;

--
-- Name: privileges; Type: TABLE; Schema: user_masterbackup; Owner: java
--

CREATE TABLE privileges (
    id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    active boolean,
    code character varying(255),
    name character varying(255),
    application character varying(255),
    feature_id bigint,
    feature_name character varying(255),
    privilege_name character varying(255)
);


ALTER TABLE privileges OWNER TO java;

--
-- Name: role_privileges; Type: TABLE; Schema: user_masterbackup; Owner: java
--

CREATE TABLE role_privileges (
    id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    privilege_id integer,
    role_id integer
);


ALTER TABLE role_privileges OWNER TO java;

--
-- Name: roles; Type: TABLE; Schema: user_masterbackup; Owner: java
--

CREATE TABLE roles (
    id integer NOT NULL,
    created_at timestamp without time zone,
    description character varying(255),
    name character varying(255),
    updated_at timestamp without time zone,
    application character varying(255)
);


ALTER TABLE roles OWNER TO java;

--
-- Name: store; Type: TABLE; Schema: user_masterbackup; Owner: java
--

CREATE TABLE store (
    id bigint NOT NULL,
    store_name character varying(255),
    address_id integer,
    org_id integer
);


ALTER TABLE store OWNER TO java;

--
-- Name: store_users; Type: TABLE; Schema: user_masterbackup; Owner: java
--

CREATE TABLE store_users (
    store_id integer NOT NULL,
    organisation_id integer,
    user_id integer
);


ALTER TABLE store_users OWNER TO java;

--
-- Name: subscription_plans; Type: TABLE; Schema: user_masterbackup; Owner: java
--

CREATE TABLE subscription_plans (
    id integer NOT NULL,
    accounting boolean NOT NULL,
    active boolean NOT NULL,
    child_offering_code character varying(255),
    created_at timestamp without time zone,
    default_package boolean,
    end_date timestamp without time zone,
    gst_compliant_billing boolean NOT NULL,
    gst_returns boolean NOT NULL,
    inventory_management boolean NOT NULL,
    max_gstins integer,
    max_transactions integer,
    multi_store boolean NOT NULL,
    offering_code character varying(255),
    offering_name character varying(255),
    offering_price double precision,
    offering_type character varying(255),
    offering_validity integer,
    procurement boolean NOT NULL,
    product_catalog integer,
    real_time_data_sharing boolean NOT NULL,
    receiveables_and_payables boolean NOT NULL,
    start_date timestamp without time zone,
    updated_at timestamp without time zone,
    partner_id integer
);


ALTER TABLE subscription_plans OWNER TO java;

--
-- Name: subscription_usage; Type: TABLE; Schema: user_masterbackup; Owner: java
--

CREATE TABLE subscription_usage (
    id integer NOT NULL,
    active boolean NOT NULL,
    available_catalog integer,
    available_gstins integer,
    available_transactions integer,
    created_at timestamp without time zone,
    subscription_end_date timestamp without time zone,
    subscription_start_date timestamp without time zone,
    updated_at timestamp without time zone,
    partner_id integer,
    party_id integer,
    subscribed_plan_id integer
);


ALTER TABLE subscription_usage OWNER TO java;

--
-- Name: user_image; Type: TABLE; Schema: user_masterbackup; Owner: java
--

CREATE TABLE user_image (
    id integer NOT NULL,
    content_type character varying(255),
    logo character varying(255),
    name character varying(255)
);


ALTER TABLE user_image OWNER TO java;

--
-- Name: users; Type: TABLE; Schema: user_masterbackup; Owner: java
--

CREATE TABLE users (
    id integer NOT NULL,
    contact_number character varying(255),
    created_at timestamp without time zone,
    crypted_password character varying(255),
    email character varying(255),
    end_date date,
    name character varying(255),
    org_id integer,
    party_id integer,
    password_reset_token character varying(255),
    password_salt character varying(255),
    role character varying(255),
    start_date date,
    store_id integer,
    updated_at timestamp without time zone,
    username character varying(255),
    verification_token character varying(255),
    verification_token_expiry timestamp without time zone,
    source character varying(255),
    user_type character varying(255),
    salt_key character varying(255),
    token character varying(255)
);


ALTER TABLE users OWNER TO java;

SET search_path = public, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: java
--

ALTER TABLE ONLY item ALTER COLUMN id SET DEFAULT nextval('item_id_seq'::regclass);


SET search_path = user_master, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: user_master; Owner: java
--

ALTER TABLE ONLY party_logo ALTER COLUMN id SET DEFAULT nextval('party_logo_id_seq'::regclass);


SET search_path = user_masterbackup, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: user_masterbackup; Owner: java
--

ALTER TABLE ONLY party_logo ALTER COLUMN id SET DEFAULT nextval('party_logo_id_seq'::regclass);


SET search_path = accounts, pg_catalog;

--
-- Name: account_type_pkey; Type: CONSTRAINT; Schema: accounts; Owner: java
--

ALTER TABLE ONLY account_type
    ADD CONSTRAINT account_type_pkey PRIMARY KEY (id);


--
-- Name: accounting_events_pkey; Type: CONSTRAINT; Schema: accounts; Owner: java
--

ALTER TABLE ONLY accounting_events
    ADD CONSTRAINT accounting_events_pkey PRIMARY KEY (id);


--
-- Name: accounts_pkey; Type: CONSTRAINT; Schema: accounts; Owner: java
--

ALTER TABLE ONLY accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);


--
-- Name: batch_job_execution_context_pkey; Type: CONSTRAINT; Schema: accounts; Owner: java
--

ALTER TABLE ONLY batch_job_execution_context
    ADD CONSTRAINT batch_job_execution_context_pkey PRIMARY KEY (job_execution_id);


--
-- Name: batch_job_execution_pkey; Type: CONSTRAINT; Schema: accounts; Owner: java
--

ALTER TABLE ONLY batch_job_execution
    ADD CONSTRAINT batch_job_execution_pkey PRIMARY KEY (job_execution_id);


--
-- Name: batch_job_instance_pkey; Type: CONSTRAINT; Schema: accounts; Owner: java
--

ALTER TABLE ONLY batch_job_instance
    ADD CONSTRAINT batch_job_instance_pkey PRIMARY KEY (job_instance_id);


--
-- Name: batch_step_execution_context_pkey; Type: CONSTRAINT; Schema: accounts; Owner: java
--

ALTER TABLE ONLY batch_step_execution_context
    ADD CONSTRAINT batch_step_execution_context_pkey PRIMARY KEY (step_execution_id);


--
-- Name: batch_step_execution_pkey; Type: CONSTRAINT; Schema: accounts; Owner: java
--

ALTER TABLE ONLY batch_step_execution
    ADD CONSTRAINT batch_step_execution_pkey PRIMARY KEY (step_execution_id);


--
-- Name: calendar_pkey; Type: CONSTRAINT; Schema: accounts; Owner: java
--

ALTER TABLE ONLY calendar
    ADD CONSTRAINT calendar_pkey PRIMARY KEY (id);


--
-- Name: chart_of_accounts_pkey; Type: CONSTRAINT; Schema: accounts; Owner: java
--

ALTER TABLE ONLY chart_of_accounts
    ADD CONSTRAINT chart_of_accounts_pkey PRIMARY KEY (id);


--
-- Name: config_pkey; Type: CONSTRAINT; Schema: accounts; Owner: java
--

ALTER TABLE ONLY config
    ADD CONSTRAINT config_pkey PRIMARY KEY (id);


--
-- Name: controls_pkey; Type: CONSTRAINT; Schema: accounts; Owner: java
--

ALTER TABLE ONLY controls
    ADD CONSTRAINT controls_pkey PRIMARY KEY (id);


--
-- Name: customerreport_pkey; Type: CONSTRAINT; Schema: accounts; Owner: java
--

ALTER TABLE ONLY customerreport
    ADD CONSTRAINT customerreport_pkey PRIMARY KEY (id);


--
-- Name: job_inst_un; Type: CONSTRAINT; Schema: accounts; Owner: java
--

ALTER TABLE ONLY batch_job_instance
    ADD CONSTRAINT job_inst_un UNIQUE (job_name, job_key);


--
-- Name: journals_pkey; Type: CONSTRAINT; Schema: accounts; Owner: java
--

ALTER TABLE ONLY journals
    ADD CONSTRAINT journals_pkey PRIMARY KEY (id);


--
-- Name: party_account_control_pkey; Type: CONSTRAINT; Schema: accounts; Owner: java
--

ALTER TABLE ONLY party_account_control
    ADD CONSTRAINT party_account_control_pkey PRIMARY KEY (id);


--
-- Name: payment_transaction_pkey; Type: CONSTRAINT; Schema: accounts; Owner: java
--

ALTER TABLE ONLY payment_transaction
    ADD CONSTRAINT payment_transaction_pkey PRIMARY KEY (id);


--
-- Name: payments_pkey; Type: CONSTRAINT; Schema: accounts; Owner: java
--

ALTER TABLE ONLY payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: period_end_process_pkey; Type: CONSTRAINT; Schema: accounts; Owner: java
--

ALTER TABLE ONLY period_end_process
    ADD CONSTRAINT period_end_process_pkey PRIMARY KEY (id);


--
-- Name: periods_pkey; Type: CONSTRAINT; Schema: accounts; Owner: java
--

ALTER TABLE ONLY periods
    ADD CONSTRAINT periods_pkey PRIMARY KEY (id);


--
-- Name: statuses_pkey; Type: CONSTRAINT; Schema: accounts; Owner: java
--

ALTER TABLE ONLY statuses
    ADD CONSTRAINT statuses_pkey PRIMARY KEY (id);


--
-- Name: summary_pkey; Type: CONSTRAINT; Schema: accounts; Owner: java
--

ALTER TABLE ONLY summary
    ADD CONSTRAINT summary_pkey PRIMARY KEY (id);


--
-- Name: transactions_pkey; Type: CONSTRAINT; Schema: accounts; Owner: java
--

ALTER TABLE ONLY transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- Name: user_info_pkey; Type: CONSTRAINT; Schema: accounts; Owner: java
--

ALTER TABLE ONLY user_info
    ADD CONSTRAINT user_info_pkey PRIMARY KEY (id);


SET search_path = invoices, pg_catalog;

--
-- Name: addresses_pkey; Type: CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- Name: catalog_master_pkey; Type: CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY catalog_master
    ADD CONSTRAINT catalog_master_pkey PRIMARY KEY (category_id);


--
-- Name: classsification_codes_pkey; Type: CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY classsification_codes
    ADD CONSTRAINT classsification_codes_pkey PRIMARY KEY (id);


--
-- Name: config_pkey; Type: CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY config
    ADD CONSTRAINT config_pkey PRIMARY KEY (id);


--
-- Name: document_sequences_pkey; Type: CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY document_sequences
    ADD CONSTRAINT document_sequences_pkey PRIMARY KEY (id);


--
-- Name: hsn_party_pkey; Type: CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY hsn_party
    ADD CONSTRAINT hsn_party_pkey PRIMARY KEY (id);


--
-- Name: invoice_lines_pkey; Type: CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY invoice_lines
    ADD CONSTRAINT invoice_lines_pkey PRIMARY KEY (id);


--
-- Name: invoice_pkey; Type: CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY invoice
    ADD CONSTRAINT invoice_pkey PRIMARY KEY (id);


--
-- Name: item_pkey; Type: CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY item
    ADD CONSTRAINT item_pkey PRIMARY KEY (id);


--
-- Name: item_prices_pkey; Type: CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY item_prices
    ADD CONSTRAINT item_prices_pkey PRIMARY KEY (id);


--
-- Name: item_trnasactions_pkey; Type: CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY item_trnasactions
    ADD CONSTRAINT item_trnasactions_pkey PRIMARY KEY (id);


--
-- Name: order_lines_pkey; Type: CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY order_lines
    ADD CONSTRAINT order_lines_pkey PRIMARY KEY (id);


--
-- Name: order_transaction_pkey; Type: CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY order_transaction
    ADD CONSTRAINT order_transaction_pkey PRIMARY KEY (id);


--
-- Name: orders_pkey; Type: CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: organisations_pkey; Type: CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY organisations
    ADD CONSTRAINT organisations_pkey PRIMARY KEY (id);


--
-- Name: organisations_users_pkey; Type: CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY organisations_users
    ADD CONSTRAINT organisations_users_pkey PRIMARY KEY (organisation_id);


--
-- Name: parties_pkey; Type: CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY parties
    ADD CONSTRAINT parties_pkey PRIMARY KEY (id);


--
-- Name: partytypes_pkey; Type: CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY partytypes
    ADD CONSTRAINT partytypes_pkey PRIMARY KEY (id);


--
-- Name: product_label_pkey; Type: CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY product_label
    ADD CONSTRAINT product_label_pkey PRIMARY KEY (id);


--
-- Name: product_master_pkey; Type: CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY product_master
    ADD CONSTRAINT product_master_pkey PRIMARY KEY (id);


--
-- Name: sku_list_pkey; Type: CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY sku_list
    ADD CONSTRAINT sku_list_pkey PRIMARY KEY (id);


--
-- Name: states_inv_pkey; Type: CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY states_inv
    ADD CONSTRAINT states_inv_pkey PRIMARY KEY (id);


--
-- Name: states_pkey; Type: CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY states
    ADD CONSTRAINT states_pkey PRIMARY KEY (state_id);


--
-- Name: stock_pkey; Type: CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY stock
    ADD CONSTRAINT stock_pkey PRIMARY KEY (id);


--
-- Name: stock_transfer_pkey; Type: CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY stock_transfer
    ADD CONSTRAINT stock_transfer_pkey PRIMARY KEY (id);


--
-- Name: sub_catalog_pkey; Type: CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY sub_catalog
    ADD CONSTRAINT sub_catalog_pkey PRIMARY KEY (sub_category_id);


--
-- Name: tax_rates_pkey; Type: CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY tax_rates
    ADD CONSTRAINT tax_rates_pkey PRIMARY KEY (id);


--
-- Name: third_party_address_pkey; Type: CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY third_party_address
    ADD CONSTRAINT third_party_address_pkey PRIMARY KEY (address_id);


--
-- Name: third_party_organizations_pkey; Type: CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY third_party_organizations
    ADD CONSTRAINT third_party_organizations_pkey PRIMARY KEY (customer_gstin);


--
-- Name: transaction_events_pkey; Type: CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY transaction_events
    ADD CONSTRAINT transaction_events_pkey PRIMARY KEY (id);


--
-- Name: upload_info_pkey; Type: CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY upload_info
    ADD CONSTRAINT upload_info_pkey PRIMARY KEY (file_name);


--
-- Name: user_hsn_pkey; Type: CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY user_hsn
    ADD CONSTRAINT user_hsn_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: utils_info_pkey; Type: CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY utils_info
    ADD CONSTRAINT utils_info_pkey PRIMARY KEY (gstin);


SET search_path = public, pg_catalog;

--
-- Name: address_id; Type: CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY third_party_address
    ADD CONSTRAINT address_id PRIMARY KEY (address_id);


--
-- Name: addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- Name: batch_job_execution_context_pkey; Type: CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY batch_job_execution_context
    ADD CONSTRAINT batch_job_execution_context_pkey PRIMARY KEY (job_execution_id);


--
-- Name: batch_job_execution_pkey; Type: CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY batch_job_execution
    ADD CONSTRAINT batch_job_execution_pkey PRIMARY KEY (job_execution_id);


--
-- Name: batch_job_instance_pkey; Type: CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY batch_job_instance
    ADD CONSTRAINT batch_job_instance_pkey PRIMARY KEY (job_instance_id);


--
-- Name: batch_step_execution_context_pkey; Type: CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY batch_step_execution_context
    ADD CONSTRAINT batch_step_execution_context_pkey PRIMARY KEY (step_execution_id);


--
-- Name: batch_step_execution_pkey; Type: CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY batch_step_execution
    ADD CONSTRAINT batch_step_execution_pkey PRIMARY KEY (step_execution_id);


--
-- Name: catalog_list_pkey; Type: CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY catalog_list
    ADD CONSTRAINT catalog_list_pkey PRIMARY KEY (id);


--
-- Name: catalog_master_pkey; Type: CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY catalog_master
    ADD CONSTRAINT catalog_master_pkey PRIMARY KEY (category_id);


--
-- Name: cities_pkey; Type: CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (city_id);


--
-- Name: config_pkey; Type: CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY config
    ADD CONSTRAINT config_pkey PRIMARY KEY (id);


--
-- Name: customer; Type: CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY third_party_organizations
    ADD CONSTRAINT customer PRIMARY KEY (customer_gstin);


--
-- Name: document_sequences_pkey; Type: CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY document_sequences
    ADD CONSTRAINT document_sequences_pkey PRIMARY KEY (id);


--
-- Name: file_event_pkey; Type: CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY file_event
    ADD CONSTRAINT file_event_pkey PRIMARY KEY (id);


--
-- Name: hsn_party_pkey; Type: CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY hsn_party
    ADD CONSTRAINT hsn_party_pkey PRIMARY KEY (id);


--
-- Name: id; Type: CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY classsification_codes
    ADD CONSTRAINT id PRIMARY KEY (id);


--
-- Name: invalid_invoices_pkey; Type: CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY invalid_invoices
    ADD CONSTRAINT invalid_invoices_pkey PRIMARY KEY (id);


--
-- Name: invoice_lines_pkey; Type: CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY invoice_lines
    ADD CONSTRAINT invoice_lines_pkey PRIMARY KEY (id);


--
-- Name: invoice_pkey; Type: CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY invoice
    ADD CONSTRAINT invoice_pkey PRIMARY KEY (id);


--
-- Name: item_pkey; Type: CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY item
    ADD CONSTRAINT item_pkey PRIMARY KEY (id);


--
-- Name: item_prices_pkey; Type: CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY item_prices
    ADD CONSTRAINT item_prices_pkey PRIMARY KEY (id);


--
-- Name: item_trnasactions_pkey; Type: CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY item_trnasactions
    ADD CONSTRAINT item_trnasactions_pkey PRIMARY KEY (id);


--
-- Name: job_inst_un; Type: CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY batch_job_instance
    ADD CONSTRAINT job_inst_un UNIQUE (job_name, job_key);


--
-- Name: order_lines_pkey; Type: CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY order_lines
    ADD CONSTRAINT order_lines_pkey PRIMARY KEY (id);


--
-- Name: orders_pkey; Type: CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: organisations_pkey; Type: CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY organisations
    ADD CONSTRAINT organisations_pkey PRIMARY KEY (id);


--
-- Name: parties_pkey; Type: CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY parties
    ADD CONSTRAINT parties_pkey PRIMARY KEY (id);


--
-- Name: partytypes_pkey; Type: CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY partytypes
    ADD CONSTRAINT partytypes_pkey PRIMARY KEY (id);


--
-- Name: product_label_pkey; Type: CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY product_label
    ADD CONSTRAINT product_label_pkey PRIMARY KEY (id);


--
-- Name: product_master_pkey; Type: CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY product_master
    ADD CONSTRAINT product_master_pkey PRIMARY KEY (id);


--
-- Name: reasoncode_pkey; Type: CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY reasoncode
    ADD CONSTRAINT reasoncode_pkey PRIMARY KEY (id);


--
-- Name: states_inv_pkey; Type: CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY states_inv
    ADD CONSTRAINT states_inv_pkey PRIMARY KEY (id);


--
-- Name: states_pkey; Type: CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY states
    ADD CONSTRAINT states_pkey PRIMARY KEY (state_id);


--
-- Name: stock_pkey; Type: CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY stock
    ADD CONSTRAINT stock_pkey PRIMARY KEY (id);


--
-- Name: sub_catalog_pkey; Type: CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY sub_catalog
    ADD CONSTRAINT sub_catalog_pkey PRIMARY KEY (sub_category_id);


--
-- Name: tax_rates_pkey; Type: CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY tax_rates
    ADD CONSTRAINT tax_rates_pkey PRIMARY KEY (id);


--
-- Name: transaction_events_pkey; Type: CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY transaction_events
    ADD CONSTRAINT transaction_events_pkey PRIMARY KEY (id);


--
-- Name: unitofmeasurements_pkey; Type: CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY unitofmeasurements
    ADD CONSTRAINT unitofmeasurements_pkey PRIMARY KEY (id);


--
-- Name: upload_info_pkey; Type: CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY upload_info
    ADD CONSTRAINT upload_info_pkey PRIMARY KEY (file_name);


--
-- Name: user_hsn_pkey; Type: CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY user_hsn
    ADD CONSTRAINT user_hsn_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: utils_info_pkey; Type: CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY utils_info
    ADD CONSTRAINT utils_info_pkey PRIMARY KEY (gstin);


SET search_path = user_master, pg_catalog;

--
-- Name: addresses_pkey; Type: CONSTRAINT; Schema: user_master; Owner: java
--

ALTER TABLE ONLY addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- Name: app_module_master_pkey; Type: CONSTRAINT; Schema: user_master; Owner: java
--

ALTER TABLE ONLY app_module_master
    ADD CONSTRAINT app_module_master_pkey PRIMARY KEY (id);


--
-- Name: app_module_pkey; Type: CONSTRAINT; Schema: user_master; Owner: java
--

ALTER TABLE ONLY app_module
    ADD CONSTRAINT app_module_pkey PRIMARY KEY (id);


--
-- Name: industries_pkey; Type: CONSTRAINT; Schema: user_master; Owner: java
--

ALTER TABLE ONLY industries
    ADD CONSTRAINT industries_pkey PRIMARY KEY (id);


--
-- Name: organisation_region_pkey; Type: CONSTRAINT; Schema: user_master; Owner: java
--

ALTER TABLE ONLY organisation_region
    ADD CONSTRAINT organisation_region_pkey PRIMARY KEY (id);


--
-- Name: organisations_pkey; Type: CONSTRAINT; Schema: user_master; Owner: java
--

ALTER TABLE ONLY organisations
    ADD CONSTRAINT organisations_pkey PRIMARY KEY (id);


--
-- Name: organisations_users_pkey; Type: CONSTRAINT; Schema: user_master; Owner: java
--

ALTER TABLE ONLY organisations_users
    ADD CONSTRAINT organisations_users_pkey PRIMARY KEY (organisation_id);


--
-- Name: parties_pkey; Type: CONSTRAINT; Schema: user_master; Owner: java
--

ALTER TABLE ONLY parties
    ADD CONSTRAINT parties_pkey PRIMARY KEY (id);


--
-- Name: partners_pkey; Type: CONSTRAINT; Schema: user_master; Owner: java
--

ALTER TABLE ONLY partners
    ADD CONSTRAINT partners_pkey PRIMARY KEY (id);


--
-- Name: party_logo_pkey; Type: CONSTRAINT; Schema: user_master; Owner: java
--

ALTER TABLE ONLY party_logo
    ADD CONSTRAINT party_logo_pkey PRIMARY KEY (id);


--
-- Name: party_partners_pkey; Type: CONSTRAINT; Schema: user_master; Owner: java
--

ALTER TABLE ONLY party_partners
    ADD CONSTRAINT party_partners_pkey PRIMARY KEY (id);


--
-- Name: party_references_pkey; Type: CONSTRAINT; Schema: user_master; Owner: java
--

ALTER TABLE ONLY party_references
    ADD CONSTRAINT party_references_pkey PRIMARY KEY (id);


--
-- Name: party_roles_pkey; Type: CONSTRAINT; Schema: user_master; Owner: java
--

ALTER TABLE ONLY party_roles
    ADD CONSTRAINT party_roles_pkey PRIMARY KEY (id);


--
-- Name: privileges_master_pkey; Type: CONSTRAINT; Schema: user_master; Owner: java
--

ALTER TABLE ONLY privileges_master
    ADD CONSTRAINT privileges_master_pkey PRIMARY KEY (id);


--
-- Name: privileges_pkey; Type: CONSTRAINT; Schema: user_master; Owner: java
--

ALTER TABLE ONLY privileges
    ADD CONSTRAINT privileges_pkey PRIMARY KEY (id);


--
-- Name: role_privileges_pkey; Type: CONSTRAINT; Schema: user_master; Owner: java
--

ALTER TABLE ONLY role_privileges
    ADD CONSTRAINT role_privileges_pkey PRIMARY KEY (id);


--
-- Name: roles_pkey; Type: CONSTRAINT; Schema: user_master; Owner: java
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: store_pkey; Type: CONSTRAINT; Schema: user_master; Owner: java
--

ALTER TABLE ONLY store
    ADD CONSTRAINT store_pkey PRIMARY KEY (id);


--
-- Name: store_users_pkey; Type: CONSTRAINT; Schema: user_master; Owner: java
--

ALTER TABLE ONLY store_users
    ADD CONSTRAINT store_users_pkey PRIMARY KEY (store_id);


--
-- Name: subscription_plans_pkey; Type: CONSTRAINT; Schema: user_master; Owner: java
--

ALTER TABLE ONLY subscription_plans
    ADD CONSTRAINT subscription_plans_pkey PRIMARY KEY (id);


--
-- Name: subscription_usage_pkey; Type: CONSTRAINT; Schema: user_master; Owner: java
--

ALTER TABLE ONLY subscription_usage
    ADD CONSTRAINT subscription_usage_pkey PRIMARY KEY (id);


--
-- Name: user_session_pkey; Type: CONSTRAINT; Schema: user_master; Owner: java
--

ALTER TABLE ONLY user_session
    ADD CONSTRAINT user_session_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: user_master; Owner: java
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


SET search_path = user_masterbackup, pg_catalog;

--
-- Name: addresses_pkey; Type: CONSTRAINT; Schema: user_masterbackup; Owner: java
--

ALTER TABLE ONLY addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- Name: application_features_pkey; Type: CONSTRAINT; Schema: user_masterbackup; Owner: java
--

ALTER TABLE ONLY application_features
    ADD CONSTRAINT application_features_pkey PRIMARY KEY (id);


--
-- Name: organisations_pkey; Type: CONSTRAINT; Schema: user_masterbackup; Owner: java
--

ALTER TABLE ONLY organisations
    ADD CONSTRAINT organisations_pkey PRIMARY KEY (id);


--
-- Name: organisations_users_pkey; Type: CONSTRAINT; Schema: user_masterbackup; Owner: java
--

ALTER TABLE ONLY organisations_users
    ADD CONSTRAINT organisations_users_pkey PRIMARY KEY (organisation_id);


--
-- Name: parties_pkey; Type: CONSTRAINT; Schema: user_masterbackup; Owner: java
--

ALTER TABLE ONLY parties
    ADD CONSTRAINT parties_pkey PRIMARY KEY (id);


--
-- Name: partners_pkey; Type: CONSTRAINT; Schema: user_masterbackup; Owner: java
--

ALTER TABLE ONLY partners
    ADD CONSTRAINT partners_pkey PRIMARY KEY (id);


--
-- Name: party_logo_pkey; Type: CONSTRAINT; Schema: user_masterbackup; Owner: java
--

ALTER TABLE ONLY party_logo
    ADD CONSTRAINT party_logo_pkey PRIMARY KEY (id);


--
-- Name: party_partners_pkey; Type: CONSTRAINT; Schema: user_masterbackup; Owner: java
--

ALTER TABLE ONLY party_partners
    ADD CONSTRAINT party_partners_pkey PRIMARY KEY (id);


--
-- Name: party_references_pkey; Type: CONSTRAINT; Schema: user_masterbackup; Owner: java
--

ALTER TABLE ONLY party_references
    ADD CONSTRAINT party_references_pkey PRIMARY KEY (id);


--
-- Name: party_roles_pkey; Type: CONSTRAINT; Schema: user_masterbackup; Owner: java
--

ALTER TABLE ONLY party_roles
    ADD CONSTRAINT party_roles_pkey PRIMARY KEY (id);


--
-- Name: privileges_pkey; Type: CONSTRAINT; Schema: user_masterbackup; Owner: java
--

ALTER TABLE ONLY privileges
    ADD CONSTRAINT privileges_pkey PRIMARY KEY (id);


--
-- Name: role_privileges_pkey; Type: CONSTRAINT; Schema: user_masterbackup; Owner: java
--

ALTER TABLE ONLY role_privileges
    ADD CONSTRAINT role_privileges_pkey PRIMARY KEY (id);


--
-- Name: roles_pkey; Type: CONSTRAINT; Schema: user_masterbackup; Owner: java
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: store_pkey; Type: CONSTRAINT; Schema: user_masterbackup; Owner: java
--

ALTER TABLE ONLY store
    ADD CONSTRAINT store_pkey PRIMARY KEY (id);


--
-- Name: store_users_pkey; Type: CONSTRAINT; Schema: user_masterbackup; Owner: java
--

ALTER TABLE ONLY store_users
    ADD CONSTRAINT store_users_pkey PRIMARY KEY (store_id);


--
-- Name: subscription_plans_pkey; Type: CONSTRAINT; Schema: user_masterbackup; Owner: java
--

ALTER TABLE ONLY subscription_plans
    ADD CONSTRAINT subscription_plans_pkey PRIMARY KEY (id);


--
-- Name: subscription_usage_pkey; Type: CONSTRAINT; Schema: user_masterbackup; Owner: java
--

ALTER TABLE ONLY subscription_usage
    ADD CONSTRAINT subscription_usage_pkey PRIMARY KEY (id);


--
-- Name: user_image_pkey; Type: CONSTRAINT; Schema: user_masterbackup; Owner: java
--

ALTER TABLE ONLY user_image
    ADD CONSTRAINT user_image_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: user_masterbackup; Owner: java
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


SET search_path = accounts, pg_catalog;

--
-- Name: accounts_chart_of_accounts_fk; Type: FK CONSTRAINT; Schema: accounts; Owner: java
--

ALTER TABLE ONLY accounts
    ADD CONSTRAINT accounts_chart_of_accounts_fk FOREIGN KEY (chart_of_account_id) REFERENCES chart_of_accounts(id) MATCH FULL;


--
-- Name: accounts_status_fk; Type: FK CONSTRAINT; Schema: accounts; Owner: java
--

ALTER TABLE ONLY accounts
    ADD CONSTRAINT accounts_status_fk FOREIGN KEY (status_id) REFERENCES statuses(id) MATCH FULL;


--
-- Name: chart_of_accounts_account_type_fk; Type: FK CONSTRAINT; Schema: accounts; Owner: java
--

ALTER TABLE ONLY chart_of_accounts
    ADD CONSTRAINT chart_of_accounts_account_type_fk FOREIGN KEY (account_type_id) REFERENCES account_type(id) MATCH FULL;


--
-- Name: job_exec_ctx_fk; Type: FK CONSTRAINT; Schema: accounts; Owner: java
--

ALTER TABLE ONLY batch_job_execution_context
    ADD CONSTRAINT job_exec_ctx_fk FOREIGN KEY (job_execution_id) REFERENCES public.batch_job_execution(job_execution_id);


--
-- Name: job_exec_params_fk; Type: FK CONSTRAINT; Schema: accounts; Owner: java
--

ALTER TABLE ONLY batch_job_execution_params
    ADD CONSTRAINT job_exec_params_fk FOREIGN KEY (job_execution_id) REFERENCES public.batch_job_execution(job_execution_id);


--
-- Name: job_exec_step_fk; Type: FK CONSTRAINT; Schema: accounts; Owner: java
--

ALTER TABLE ONLY batch_step_execution
    ADD CONSTRAINT job_exec_step_fk FOREIGN KEY (job_execution_id) REFERENCES public.batch_job_execution(job_execution_id);


--
-- Name: job_inst_exec_fk; Type: FK CONSTRAINT; Schema: accounts; Owner: java
--

ALTER TABLE ONLY batch_job_execution
    ADD CONSTRAINT job_inst_exec_fk FOREIGN KEY (job_instance_id) REFERENCES public.batch_job_instance(job_instance_id);


--
-- Name: journals_period_fk; Type: FK CONSTRAINT; Schema: accounts; Owner: java
--

ALTER TABLE ONLY journals
    ADD CONSTRAINT journals_period_fk FOREIGN KEY (period_id) REFERENCES periods(id) MATCH FULL;


--
-- Name: journals_transactions_event_fk; Type: FK CONSTRAINT; Schema: accounts; Owner: java
--

ALTER TABLE ONLY journals
    ADD CONSTRAINT journals_transactions_event_fk FOREIGN KEY (transaction_id) REFERENCES transactions(id) MATCH FULL;


--
-- Name: journals_transactions_fk; Type: FK CONSTRAINT; Schema: accounts; Owner: java
--

ALTER TABLE ONLY journals
    ADD CONSTRAINT journals_transactions_fk FOREIGN KEY (transaction_id) REFERENCES transactions(id) MATCH FULL;


--
-- Name: party_account_contrl_controls_fk; Type: FK CONSTRAINT; Schema: accounts; Owner: java
--

ALTER TABLE ONLY party_account_control
    ADD CONSTRAINT party_account_contrl_controls_fk FOREIGN KEY (control_id) REFERENCES controls(id) MATCH FULL;


--
-- Name: party_account_control_coacc_fk; Type: FK CONSTRAINT; Schema: accounts; Owner: java
--

ALTER TABLE ONLY party_account_control
    ADD CONSTRAINT party_account_control_coacc_fk FOREIGN KEY (chart_of_account_id) REFERENCES chart_of_accounts(id) MATCH FULL;


--
-- Name: payment_txn_journal_fk; Type: FK CONSTRAINT; Schema: accounts; Owner: java
--

ALTER TABLE ONLY payment_transaction
    ADD CONSTRAINT payment_txn_journal_fk FOREIGN KEY (journal_id) REFERENCES journals(id) MATCH FULL;


--
-- Name: payments_payment_trans_fk; Type: FK CONSTRAINT; Schema: accounts; Owner: java
--

ALTER TABLE ONLY payments
    ADD CONSTRAINT payments_payment_trans_fk FOREIGN KEY (payment_txn_id) REFERENCES payment_transaction(id) MATCH FULL;


--
-- Name: periods_calendar_fk; Type: FK CONSTRAINT; Schema: accounts; Owner: java
--

ALTER TABLE ONLY periods
    ADD CONSTRAINT periods_calendar_fk FOREIGN KEY (calendar_id) REFERENCES calendar(id) MATCH FULL;


--
-- Name: step_exec_ctx_fk; Type: FK CONSTRAINT; Schema: accounts; Owner: java
--

ALTER TABLE ONLY batch_step_execution_context
    ADD CONSTRAINT step_exec_ctx_fk FOREIGN KEY (step_execution_id) REFERENCES public.batch_step_execution(step_execution_id);


--
-- Name: transactions_accounting_event_fk; Type: FK CONSTRAINT; Schema: accounts; Owner: java
--

ALTER TABLE ONLY transactions
    ADD CONSTRAINT transactions_accounting_event_fk FOREIGN KEY (accounting_event_id) REFERENCES accounting_events(id) MATCH FULL;


SET search_path = invoices, pg_catalog;

--
-- Name: fk3npxkpdam0mxyeiwhwtt8e2au; Type: FK CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY product_master
    ADD CONSTRAINT fk3npxkpdam0mxyeiwhwtt8e2au FOREIGN KEY (sub_category_id) REFERENCES sub_catalog(sub_category_id);


--
-- Name: fk722le2loqp5l4vms0dld3a02s; Type: FK CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY item_trnasactions
    ADD CONSTRAINT fk722le2loqp5l4vms0dld3a02s FOREIGN KEY (invoice_id) REFERENCES invoice(id);


--
-- Name: fk7kk938lt30fhvrgfecsujd10o; Type: FK CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY invoice_lines
    ADD CONSTRAINT fk7kk938lt30fhvrgfecsujd10o FOREIGN KEY (invoice_id) REFERENCES invoice(id);


--
-- Name: fk87qgdesah1gjcsh3bgb22dk4y; Type: FK CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY order_transaction
    ADD CONSTRAINT fk87qgdesah1gjcsh3bgb22dk4y FOREIGN KEY (orders_id) REFERENCES orders(id);


--
-- Name: fkatwtce9t38mwsb6jl14kd35e0; Type: FK CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY order_lines
    ADD CONSTRAINT fkatwtce9t38mwsb6jl14kd35e0 FOREIGN KEY (orders_id) REFERENCES orders(id);


--
-- Name: fkc5xnxgxbxskykxmvmb3mwiogk; Type: FK CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY item
    ADD CONSTRAINT fkc5xnxgxbxskykxmvmb3mwiogk FOREIGN KEY (stock_id) REFERENCES stock(id);


--
-- Name: fkcustomer; Type: FK CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT fkcustomer FOREIGN KEY (customer_gstin) REFERENCES third_party_organizations(customer_gstin);


--
-- Name: fkhrkewhjkiet660f19islp47sw; Type: FK CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY sub_catalog
    ADD CONSTRAINT fkhrkewhjkiet660f19islp47sw FOREIGN KEY (category_id) REFERENCES catalog_master(category_id);


--
-- Name: fkinvoices; Type: FK CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY order_transaction
    ADD CONSTRAINT fkinvoices FOREIGN KEY (invoice_id) REFERENCES invoice(id);


--
-- Name: fkjopoaugy9w7ae2p8yxwmnff7u; Type: FK CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT fkjopoaugy9w7ae2p8yxwmnff7u FOREIGN KEY (customer_gstin) REFERENCES third_party_organizations(customer_gstin);


--
-- Name: fklcmfkx2m7cbsd1t47qaqut5yf; Type: FK CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY item_trnasactions
    ADD CONSTRAINT fklcmfkx2m7cbsd1t47qaqut5yf FOREIGN KEY (txn_type) REFERENCES transaction_events(id);


--
-- Name: fkngnaff3i13d466s1w55nl3fnj; Type: FK CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY third_party_address
    ADD CONSTRAINT fkngnaff3i13d466s1w55nl3fnj FOREIGN KEY (customer_gstin) REFERENCES third_party_organizations(customer_gstin);


--
-- Name: fko7o7jr7ddf13vobkwu66xup54; Type: FK CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY invoice
    ADD CONSTRAINT fko7o7jr7ddf13vobkwu66xup54 FOREIGN KEY (customer_gstin) REFERENCES third_party_organizations(customer_gstin);


--
-- Name: fkogijh4fgcr8bfksenypv01vgw; Type: FK CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY product_master
    ADD CONSTRAINT fkogijh4fgcr8bfksenypv01vgw FOREIGN KEY (category_id) REFERENCES catalog_master(category_id);


--
-- Name: fkorders; Type: FK CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY order_lines
    ADD CONSTRAINT fkorders FOREIGN KEY (orders_id) REFERENCES orders(id);


--
-- Name: fkorders; Type: FK CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY order_transaction
    ADD CONSTRAINT fkorders FOREIGN KEY (orders_id) REFERENCES orders(id);


--
-- Name: fkpgpoeh886d8vy85e9glhe8m89; Type: FK CONSTRAINT; Schema: invoices; Owner: java
--

ALTER TABLE ONLY order_transaction
    ADD CONSTRAINT fkpgpoeh886d8vy85e9glhe8m89 FOREIGN KEY (invoice_id) REFERENCES invoice(id);


SET search_path = public, pg_catalog;

--
-- Name: fk1ai7gb2ilwuoitwvot4y0twuj; Type: FK CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY item_trnasactions
    ADD CONSTRAINT fk1ai7gb2ilwuoitwvot4y0twuj FOREIGN KEY (item_id) REFERENCES item(id);


--
-- Name: fk3npxkpdam0mxyeiwhwtt8e2au; Type: FK CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY product_master
    ADD CONSTRAINT fk3npxkpdam0mxyeiwhwtt8e2au FOREIGN KEY (sub_category_id) REFERENCES sub_catalog(sub_category_id);


--
-- Name: fk722le2loqp5l4vms0dld3a02s; Type: FK CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY item_trnasactions
    ADD CONSTRAINT fk722le2loqp5l4vms0dld3a02s FOREIGN KEY (invoice_id) REFERENCES invoice(id);


--
-- Name: fk7kk938lt30fhvrgfecsujd10o; Type: FK CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY invoice_lines
    ADD CONSTRAINT fk7kk938lt30fhvrgfecsujd10o FOREIGN KEY (invoice_id) REFERENCES invoice(id);


--
-- Name: fkc5xnxgxbxskykxmvmb3mwiogk; Type: FK CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY item
    ADD CONSTRAINT fkc5xnxgxbxskykxmvmb3mwiogk FOREIGN KEY (stock_id) REFERENCES stock(id);


--
-- Name: fkemb1v2gt2yql9mspqnnuopf3u; Type: FK CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY order_lines
    ADD CONSTRAINT fkemb1v2gt2yql9mspqnnuopf3u FOREIGN KEY (invoice_id) REFERENCES orders(id);


--
-- Name: fkhrkewhjkiet660f19islp47sw; Type: FK CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY sub_catalog
    ADD CONSTRAINT fkhrkewhjkiet660f19islp47sw FOREIGN KEY (category_id) REFERENCES catalog_master(category_id);


--
-- Name: fkjopoaugy9w7ae2p8yxwmnff7u; Type: FK CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT fkjopoaugy9w7ae2p8yxwmnff7u FOREIGN KEY (customer_gstin) REFERENCES third_party_organizations(customer_gstin);


--
-- Name: fklcmfkx2m7cbsd1t47qaqut5yf; Type: FK CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY item_trnasactions
    ADD CONSTRAINT fklcmfkx2m7cbsd1t47qaqut5yf FOREIGN KEY (txn_type) REFERENCES transaction_events(id);


--
-- Name: fkngnaff3i13d466s1w55nl3fnj; Type: FK CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY third_party_address
    ADD CONSTRAINT fkngnaff3i13d466s1w55nl3fnj FOREIGN KEY (customer_gstin) REFERENCES third_party_organizations(customer_gstin);


--
-- Name: fko7o7jr7ddf13vobkwu66xup54; Type: FK CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY invoice
    ADD CONSTRAINT fko7o7jr7ddf13vobkwu66xup54 FOREIGN KEY (customer_gstin) REFERENCES third_party_organizations(customer_gstin);


--
-- Name: fkogijh4fgcr8bfksenypv01vgw; Type: FK CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY product_master
    ADD CONSTRAINT fkogijh4fgcr8bfksenypv01vgw FOREIGN KEY (category_id) REFERENCES catalog_master(category_id);


--
-- Name: job_exec_ctx_fk; Type: FK CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY batch_job_execution_context
    ADD CONSTRAINT job_exec_ctx_fk FOREIGN KEY (job_execution_id) REFERENCES batch_job_execution(job_execution_id);


--
-- Name: job_exec_params_fk; Type: FK CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY batch_job_execution_params
    ADD CONSTRAINT job_exec_params_fk FOREIGN KEY (job_execution_id) REFERENCES batch_job_execution(job_execution_id);


--
-- Name: job_exec_step_fk; Type: FK CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY batch_step_execution
    ADD CONSTRAINT job_exec_step_fk FOREIGN KEY (job_execution_id) REFERENCES batch_job_execution(job_execution_id);


--
-- Name: job_inst_exec_fk; Type: FK CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY batch_job_execution
    ADD CONSTRAINT job_inst_exec_fk FOREIGN KEY (job_instance_id) REFERENCES batch_job_instance(job_instance_id);


--
-- Name: step_exec_ctx_fk; Type: FK CONSTRAINT; Schema: public; Owner: java
--

ALTER TABLE ONLY batch_step_execution_context
    ADD CONSTRAINT step_exec_ctx_fk FOREIGN KEY (step_execution_id) REFERENCES batch_step_execution(step_execution_id);


SET search_path = user_master, pg_catalog;

--
-- Name: fk2s030dq77jbjgks52ordfigqt; Type: FK CONSTRAINT; Schema: user_master; Owner: java
--

ALTER TABLE ONLY app_module
    ADD CONSTRAINT fk2s030dq77jbjgks52ordfigqt FOREIGN KEY (subscription_plans_id) REFERENCES subscription_plans(id);


--
-- Name: fk34t7uisk92544u1e0fvg04mlm; Type: FK CONSTRAINT; Schema: user_master; Owner: java
--

ALTER TABLE ONLY subscription_plans
    ADD CONSTRAINT fk34t7uisk92544u1e0fvg04mlm FOREIGN KEY (partner_id) REFERENCES partners(id);


--
-- Name: fk534xnlmjb36g10ktkmidefqcg; Type: FK CONSTRAINT; Schema: user_master; Owner: java
--

ALTER TABLE ONLY subscription_usage
    ADD CONSTRAINT fk534xnlmjb36g10ktkmidefqcg FOREIGN KEY (subscribed_plan_id) REFERENCES subscription_plans(id);


--
-- Name: fkbdmvbmworhrqy7piu4p4cr6x5; Type: FK CONSTRAINT; Schema: user_master; Owner: java
--

ALTER TABLE ONLY subscription_usage
    ADD CONSTRAINT fkbdmvbmworhrqy7piu4p4cr6x5 FOREIGN KEY (partner_id) REFERENCES partners(id);


--
-- Name: fkblunby42cnqxs2pl146e83j86; Type: FK CONSTRAINT; Schema: user_master; Owner: java
--

ALTER TABLE ONLY privileges_master
    ADD CONSTRAINT fkblunby42cnqxs2pl146e83j86 FOREIGN KEY (app_module_master_id) REFERENCES app_module_master(id);


--
-- Name: fkfpgd9jliuscge1uo0t49ihbpm; Type: FK CONSTRAINT; Schema: user_master; Owner: java
--

ALTER TABLE ONLY parties
    ADD CONSTRAINT fkfpgd9jliuscge1uo0t49ihbpm FOREIGN KEY (subscription_usage_id) REFERENCES subscription_usage(id);


--
-- Name: fkjaj1k5vebpl46fcgkouqy5jbj; Type: FK CONSTRAINT; Schema: user_master; Owner: java
--

ALTER TABLE ONLY store
    ADD CONSTRAINT fkjaj1k5vebpl46fcgkouqy5jbj FOREIGN KEY (org_id) REFERENCES organisations(id);


--
-- Name: fkk0jyws7cs9n95lc50decg6oqk; Type: FK CONSTRAINT; Schema: user_master; Owner: java
--

ALTER TABLE ONLY organisations
    ADD CONSTRAINT fkk0jyws7cs9n95lc50decg6oqk FOREIGN KEY (party_id) REFERENCES parties(id);


--
-- Name: fkkcanp1sf5cfv2rc864xy8qx1a; Type: FK CONSTRAINT; Schema: user_master; Owner: java
--

ALTER TABLE ONLY parties
    ADD CONSTRAINT fkkcanp1sf5cfv2rc864xy8qx1a FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: fklr29o11uswdgcnn8swu3q15f8; Type: FK CONSTRAINT; Schema: user_master; Owner: java
--

ALTER TABLE ONLY user_session
    ADD CONSTRAINT fklr29o11uswdgcnn8swu3q15f8 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: fknedvbkrcxilivwocqw93hmy8w; Type: FK CONSTRAINT; Schema: user_master; Owner: java
--

ALTER TABLE ONLY privileges
    ADD CONSTRAINT fknedvbkrcxilivwocqw93hmy8w FOREIGN KEY (app_module_id) REFERENCES app_module(id);


--
-- Name: fkq2rpxis4i8wdi74pv9kivnk2f; Type: FK CONSTRAINT; Schema: user_master; Owner: java
--

ALTER TABLE ONLY store
    ADD CONSTRAINT fkq2rpxis4i8wdi74pv9kivnk2f FOREIGN KEY (address_id) REFERENCES addresses(id);


--
-- Name: fkt1nrgbfbgcrtn7a5nbkm7f2y2; Type: FK CONSTRAINT; Schema: user_master; Owner: java
--

ALTER TABLE ONLY organisations
    ADD CONSTRAINT fkt1nrgbfbgcrtn7a5nbkm7f2y2 FOREIGN KEY (address_id) REFERENCES addresses(id);


--
-- Name: fktpl79vgv8dc9bkdug4ttt2bvm; Type: FK CONSTRAINT; Schema: user_master; Owner: java
--

ALTER TABLE ONLY subscription_usage
    ADD CONSTRAINT fktpl79vgv8dc9bkdug4ttt2bvm FOREIGN KEY (party_id) REFERENCES parties(id);


SET search_path = user_masterbackup, pg_catalog;

--
-- Name: fk34t7uisk92544u1e0fvg04mlm; Type: FK CONSTRAINT; Schema: user_masterbackup; Owner: java
--

ALTER TABLE ONLY subscription_plans
    ADD CONSTRAINT fk34t7uisk92544u1e0fvg04mlm FOREIGN KEY (partner_id) REFERENCES partners(id);


--
-- Name: fk534xnlmjb36g10ktkmidefqcg; Type: FK CONSTRAINT; Schema: user_masterbackup; Owner: java
--

ALTER TABLE ONLY subscription_usage
    ADD CONSTRAINT fk534xnlmjb36g10ktkmidefqcg FOREIGN KEY (subscribed_plan_id) REFERENCES subscription_plans(id);


--
-- Name: fkbdmvbmworhrqy7piu4p4cr6x5; Type: FK CONSTRAINT; Schema: user_masterbackup; Owner: java
--

ALTER TABLE ONLY subscription_usage
    ADD CONSTRAINT fkbdmvbmworhrqy7piu4p4cr6x5 FOREIGN KEY (partner_id) REFERENCES partners(id);


--
-- Name: fkfpgd9jliuscge1uo0t49ihbpm; Type: FK CONSTRAINT; Schema: user_masterbackup; Owner: java
--

ALTER TABLE ONLY parties
    ADD CONSTRAINT fkfpgd9jliuscge1uo0t49ihbpm FOREIGN KEY (subscription_usage_id) REFERENCES subscription_usage(id);


--
-- Name: fkjaj1k5vebpl46fcgkouqy5jbj; Type: FK CONSTRAINT; Schema: user_masterbackup; Owner: java
--

ALTER TABLE ONLY store
    ADD CONSTRAINT fkjaj1k5vebpl46fcgkouqy5jbj FOREIGN KEY (org_id) REFERENCES organisations(id);


--
-- Name: fkk0jyws7cs9n95lc50decg6oqk; Type: FK CONSTRAINT; Schema: user_masterbackup; Owner: java
--

ALTER TABLE ONLY organisations
    ADD CONSTRAINT fkk0jyws7cs9n95lc50decg6oqk FOREIGN KEY (party_id) REFERENCES parties(id);


--
-- Name: fkkcanp1sf5cfv2rc864xy8qx1a; Type: FK CONSTRAINT; Schema: user_masterbackup; Owner: java
--

ALTER TABLE ONLY parties
    ADD CONSTRAINT fkkcanp1sf5cfv2rc864xy8qx1a FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: fkq2rpxis4i8wdi74pv9kivnk2f; Type: FK CONSTRAINT; Schema: user_masterbackup; Owner: java
--

ALTER TABLE ONLY store
    ADD CONSTRAINT fkq2rpxis4i8wdi74pv9kivnk2f FOREIGN KEY (address_id) REFERENCES addresses(id);


--
-- Name: fkt1nrgbfbgcrtn7a5nbkm7f2y2; Type: FK CONSTRAINT; Schema: user_masterbackup; Owner: java
--

ALTER TABLE ONLY organisations
    ADD CONSTRAINT fkt1nrgbfbgcrtn7a5nbkm7f2y2 FOREIGN KEY (address_id) REFERENCES addresses(id);


--
-- Name: fktpl79vgv8dc9bkdug4ttt2bvm; Type: FK CONSTRAINT; Schema: user_masterbackup; Owner: java
--

ALTER TABLE ONLY subscription_usage
    ADD CONSTRAINT fktpl79vgv8dc9bkdug4ttt2bvm FOREIGN KEY (party_id) REFERENCES parties(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


SET search_path = public, pg_catalog;

--
-- Name: TABLE invoice; Type: ACL; Schema: public; Owner: java
--

REVOKE ALL ON TABLE invoice FROM PUBLIC;
REVOKE ALL ON TABLE invoice FROM java;
GRANT ALL ON TABLE invoice TO java;


--
-- PostgreSQL database dump complete
--

