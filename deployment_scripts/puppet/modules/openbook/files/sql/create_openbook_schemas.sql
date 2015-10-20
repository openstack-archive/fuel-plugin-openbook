SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS openbook;
CREATE SCHEMA openbook DEFAULT CHARACTER SET utf8;

GRANT ALL PRIVILEGES ON openbook.* TO openbook@'%' IDENTIFIED BY 'Tall!g3nt';
GRANT ALL PRIVILEGES ON openbook.* TO openbook@localhost IDENTIFIED BY 'Tall!g3nt';
FLUSH PRIVILEGES;

USE openbook;

CREATE TABLE t_audit_event (
  event_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  event_time DATETIME(6) NOT NULL,
  event_type VARCHAR(32) NOT NULL,
  entity_id VARCHAR(64) NOT NULL,
  entity_name VARCHAR(255) NULL,
  entity_type VARCHAR(45) NOT NULL,
  user_id VARCHAR(128) NULL,
  event_data LONGTEXT NULL,
  PRIMARY KEY (event_id),
  INDEX ix_audit_event_1 (event_time, event_type, entity_id),
  INDEX ix_audit_event_2 (user_id, event_time))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE t_billable_feature (
  billable_feature_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  billable_feature_category VARCHAR(128) NOT NULL,
  billable_feature_vendor_type VARCHAR(128) NOT NULL,
  billable_feature_type VARCHAR(128) NOT NULL,
  billable_feature_subtypes LONGTEXT NULL DEFAULT NULL,
  billable_feature_subtype_classifier LONGTEXT NULL DEFAULT NULL,
  billable_feature_description LONGTEXT NULL DEFAULT NULL,
  billable_feature_details LONGTEXT NULL DEFAULT NULL,
  PRIMARY KEY (billable_feature_id),
  UNIQUE INDEX ix_billable_feature_1 (billable_feature_vendor_type ASC, billable_feature_type ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE t_credit (
  credit_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  payer_id INT UNSIGNED NOT NULL,
  payer_type VARCHAR(64) NOT NULL,
  credit_amount DECIMAL(19,2) NULL,
  remaining_amount DECIMAL(19,2) NULL,
  credit_type VARCHAR(16) NOT NULL,
  granted_by VARCHAR(256) NOT NULL,
  posted_date DATETIME(6) NOT NUll,
  expire_date DATETIME(6) NOT NULL,
  currency VARCHAR(3) NOT NULL,
  PRIMARY KEY (credit_id),
  INDEX ix_credit_1 (payer_id, payer_type, expire_date))
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8;

CREATE TABLE t_customer (
  customer_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  resource_manager_id VARCHAR(36) NULL DEFAULT NULL,
  resource_manager_foreign_id VARCHAR(512) NULL DEFAULT NULL,
  customer_name VARCHAR(512) NOT NULL,
  other_foreign_ids LONGTEXT NULL DEFAULT NULL,
  tax_rate DECIMAL(18,4) NULL DEFAULT 0.0000,
  currency CHAR(6) NULL DEFAULT NULL,
  discount_percent DECIMAL(18,4) NULL DEFAULT 0.0000,
  billing_frequency VARCHAR(40) NULL DEFAULT NULL,
  last_bill_date DATETIME(6) NULL DEFAULT NULL,
  next_bill_date DATETIME(6) NULL DEFAULT NULL,
  is_active TINYINT(1) NULL DEFAULT 1,
  create_date DATETIME(6) NULL DEFAULT NULL,
  activate_date DATETIME(6) NULL DEFAULT NULL,
  billing_start_date DATETIME(6) NULL DEFAULT NULL,
  last_payment_date DATETIME(6) NULL DEFAULT NULL,
  deactivate_date DATETIME(6) NULL DEFAULT NULL,
  description VARCHAR(5120) NULL DEFAULT NULL,
  minimum_invoice_commitment DECIMAL(19,4) NULL,
  invoicing_method VARCHAR(32) NOT NULL,
  management_region_id VARCHAR(64) NULL,
  infrastructure_region_id VARCHAR(64) NULL,
  billing_address_line_1 VARCHAR(512) NULL,
  billing_address_line_2 VARCHAR(512) NULL,
  billing_address_city VARCHAR(512) NULL,
  billing_address_region VARCHAR(128) NULL,
  billing_address_country VARCHAR(2) NULL,
  billing_address_postal_code VARCHAR(64) NULL,
  payer_payment_details VARCHAR(5120) NULL,
  payment_method_confirmed TINYINT(1) DEFAULT 0,
  balance_due DECIMAL(19,4) NULL DEFAULT 0,
  PRIMARY KEY (customer_id),
  INDEX ix_customer_1 (resource_manager_id ASC),
  INDEX ix_customer_2 (resource_manager_foreign_id(255) ASC),
  UNIQUE INDEX ix_customer_3 (management_region_id, customer_name(255)))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE t_discount (
  discount_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  payer_id INT UNSIGNED NOT NULL,
  payer_type VARCHAR(64) NOT NULL,
  discount_percent DECIMAL(5,2) NOT NULL,
  granted_by VARCHAR(256) NOT NULL,
  apply_to_charge_category VARCHAR(32) NOT NULL,
  trigger_charge_category VARCHAR(32) NULL,
  trigger_amount DECIMAL(19,2) NULL,
  start_date DATETIME(6) NOT NULL,
  end_date DATETIME(6) NOT NULL,
  PRIMARY KEY (discount_id),
  INDEX ix_discount_1 (payer_id, payer_type, end_date))
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8;

CREATE TABLE t_email_notification (
	message_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	recipient VARCHAR(128) NOT NULL,
	sender VARCHAR(128) NOT NULL,
	subject VARCHAR(256) NOT NULL,
	message_text LONGTEXT NOT NULL,
	smtp_server_details LONGTEXT NOT NULL,
	date_generated DATETIME(6) NOT NULL,
	date_sent DATETIME(6) NULL,
	date_last_send_attempt DATETIME(6) NULL,
	send_status VARCHAR(16) NULL,
	send_status_detail VARCHAR(5120) NULL,
	send_attempt_count SMALLINT NULL,
  PRIMARY KEY (message_id),
  INDEX ix_email_notification_1 (recipient, date_generated),
  INDEX ix_email_notification_2 (sender, date_generated),
  INDEX ix_email_notification_3 (date_sent))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE t_email_template (
	provider_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	template_subject VARCHAR(256) NOT NULL,
	template_name VARCHAR(128) NOT NULL,
	template_text LONGTEXT NOT NULL,
  PRIMARY KEY (provider_id, template_name))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE t_entity_attribute (
  entity_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  attribute_class VARCHAR(32) NOT NULL,
  attribute_category VARCHAR(128) NOT NULL,
  attribute_name VARCHAR(128) NOT NULL,
  attribute_value VARCHAR(512) NOT NULL,
  attribute_unit VARCHAR(64) NULL DEFAULT NULL,
  add_date DATETIME(6) NULL DEFAULT NULL,
  expire_date DATETIME(6) NOT NULL,
  PRIMARY KEY (entity_id ASC, expire_date ASC, attribute_class ASC, attribute_category ASC, attribute_name ASC),
  INDEX ix_entity_attribute_1 (attribute_class ASC),
  INDEX ix_entity_attribute_2 (attribute_category ASC),
  INDEX ix_entity_attribute_3 (attribute_name ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE t_invoice (
  invoice_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  payer_id INT UNSIGNED NOT NULL,
  payer_type VARCHAR(64) NOT NULL,
  payer_name VARCHAR(512) NOT NULL,
  invoice_number VARCHAR(45) NULL,
  invoice_date DATETIME(6) NOT NULL,
  period_begin DATETIME(6) NOT NULL,
  period_end DATETIME(6) NOT NULL,
  invoice_amount DECIMAL(19,2) NOT NULL,
  actual_charges DECIMAL(19,2) NOT NULL,
  invoice_currency VARCHAR(16) NULL,
  management_region_id INT UNSIGNED NOT NULL,
  balance_due DECIMAL(19,2) NOT NULL,
  PRIMARY KEY (invoice_id),
  INDEX ix_invoice_1 (management_region_id, payer_type, payer_id ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE t_invoice_detail (
  invoice_id INT UNSIGNED NOT NULL,
  customer_id INT UNSIGNED NOT NULL,
  resource_group_id VARCHAR(36) NULL,
  invoice_group VARCHAR(128) NULL,
  item_name VARCHAR(512) NULL,
  item_vendor_type VARCHAR(128) NULL,
  item_type VARCHAR(128) NOT NULL,
  item_subtype VARCHAR(128) NOT NULL,
  item_description VARCHAR(512) NOT NULL,
  rate_plan_id VARCHAR(36) NULL,
  rate_plan_billable_feature_id VARCHAR(36) NULL DEFAULT NULL,
  billing_interval VARCHAR(64) NULL DEFAULT NULL,
  item_invoice_amount DECIMAL(19,2) NOT NULL,
  num_units VARCHAR(32) NOT NULL,
  num_units_unit VARCHAR(16) NULL,
  INDEX ix_invoice_detail_1 (invoice_id ASC),
  INDEX ix_invoice_detail_2 (customer_id ASC),
  INDEX ix_invoice_detail_3 (item_vendor_type, item_type, item_subtype ASC),
  INDEX ix_invoice_detail_4 (rate_plan_id ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE t_job_status (
  job_id VARCHAR(256) NOT NULL,
  start_time DATETIME(6) NOT NULL,
  end_time DATETIME(6) NULL DEFAULT NULL,
  status VARCHAR(32) NULL DEFAULT NULL,
  result VARCHAR(32) NULL DEFAULT NULL,
  result_detail LONGTEXT NULL DEFAULT NULL,
  PRIMARY KEY (job_id(255), start_time))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE t_lookup_values (
  type VARCHAR(128) NOT NULL,
  name VARCHAR(256) NOT NULL,
  value LONGTEXT NOT NULL,
  PRIMARY KEY (type, name(255)))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE t_parent_child_relationships (
  parent_id INT UNSIGNED NOT NULL,
  parent_type VARCHAR(64) NOT NULL,
  child_id INT UNSIGNED NOT NULL,
  child_type VARCHAR(64) NOT NULL,
  assigned_quantity INT NOT NULL DEFAULT 1,
  add_date DATETIME(6) NOT NULL,
  remove_date DATETIME(6) NOT NULL,
  PRIMARY KEY (parent_id, parent_type, child_id, child_type, add_date, remove_date),
  INDEX ix_parent_child_relationships_1 (child_id, child_type ASC),
  INDEX ix_parent_child_relationships_2 (parent_id, parent_type ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE t_payment (
  payment_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  payer_id INT UNSIGNED NOT NULL,
  payer_type VARCHAR(64) NOT NULL,
  payment_date DATETIME(6) NOT NULL,
  amount DECIMAL(19,2) NOT NULL,
  payment_method VARCHAR(64) NOT NULL,
  payment_reference VARCHAR(256) NULL,
  payment_method_detail LONGTEXT NULL DEFAULT NULL,
  payment_status VARCHAR(64) NULL DEFAULT NULL,
  payment_status_detail LONGTEXT NULL DEFAULT NULL,
  PRIMARY KEY (payment_id),
  INDEX ix_payment_1 (payer_type, payer_id, payment_date))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE t_promo_code (
  management_region_id INT UNSIGNED NOT NULL,
  promo_code_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  promo_code VARCHAR(128) NOT NULL,
  salesperson VARCHAR(128) NULL,
  discount_or_credit VARCHAR(8) NOT NULL,
  credit_amount DECIMAL(19,2) NULL,
  credit_type VARCHAR(16) NULL,
  apply_to_charge_category VARCHAR(32) NULL,
  trigger_charge_category VARCHAR(32) NULL,
  trigger_amount DECIMAL(19,2) NULL,
  discount_percent DECIMAL(5,2) NULL,
  available_invoice_periods INT NULL,
  expire_date DATETIME(6) NULL,
  currency VARCHAR(3) NULL DEFAULT NULL,
  PRIMARY KEY (promo_code_id),
  INDEX ix_promo_code_1 (promo_code),
  INDEX ix_promo_code_2 (salesperson),
  UNIQUE INDEX ix_promo_code_3 (management_region_id, promo_code))
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8;

CREATE TABLE t_promo_code_redemption (
  promo_code_id INT UNSIGNED NOT NULL,
  payer_id INT UNSIGNED NOT NULL,
  payer_type VARCHAR(64) NOT NULL,
  redemption_date DATETIME(6) NULL,
  PRIMARY KEY (payer_id, promo_code_id))
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8;


CREATE TABLE t_provider (
  provider_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  provider_name VARCHAR(512) NOT NULL,
  provider_type VARCHAR(64) NOT NULL,
  other_foreign_ids LONGTEXT NULL DEFAULT NULL,
  tax_rate DECIMAL(18,4) NULL DEFAULT 0.0000,
  currency CHAR(6) NULL DEFAULT NULL,
  discount_percent DECIMAL(18,4) NULL DEFAULT 0.0000,
  billing_frequency VARCHAR(40) NULL DEFAULT NULL,
  last_bill_date DATETIME(6) NULL DEFAULT NULL,
  next_bill_date DATETIME(6) NULL DEFAULT NULL,
  last_payment_date DATETIME(6) NULL DEFAULT NULL,
  is_active TINYINT(1) NULL DEFAULT 1,
  create_date DATETIME(6) NULL DEFAULT NULL,
  activate_date DATETIME(6) NULL DEFAULT NULL,
  billing_start_date DATETIME(6) NULL DEFAULT NULL,
  deactivate_date DATETIME(6) NULL DEFAULT NULL,
  description LONGTEXT NULL DEFAULT NULL,
  minimum_invoice_commitment DECIMAL(19,2) NULL,
  invoicing_method VARCHAR(32) NULL DEFAULT NULL,
  invoice_processing_method VARCHAR(32) NULL DEFAULT NULL,
  billing_address_line_1 VARCHAR(512) NULL,
  billing_address_line_2 VARCHAR(512) NULL,
  billing_address_city VARCHAR(512) NULL,
  billing_address_region VARCHAR(128) NULL,
  billing_address_country VARCHAR(2) NULL,
  billing_address_postal_code VARCHAR(64) NULL,
  legal_address_line_1 VARCHAR(512) NULL,
  legal_address_line_2 VARCHAR(512) NULL,
  legal_address_city VARCHAR(512) NULL,
  legal_address_region VARCHAR(128) NULL,
  legal_address_country VARCHAR(2) NULL,
  legal_address_postal_code VARCHAR(64) NULL,
  payer_payment_details VARCHAR (5120) NULL,
  payee_payment_details VARCHAR(5120) NULL,
  public_url VARCHAR(512) NOT NULL,
  private_url VARCHAR(512) NOT NULL,
  management_region_id VARCHAR(64) NOT NULL,
  notification_settings LONGTEXT NOT NULL,
  personalization_settings LONGTEXT NOT NULL,
  balance_due DECIMAL(19,2) NULL,
  openbook_processes_payments TINYINT(1) NULL DEFAULT 1,
  openbook_processes_past_due_invoices TINYINT(1) NULL DEFAULT 1,
  openstack_tenant_id VARCHAR(36) NULL DEFAULT NULL,
  PRIMARY KEY (provider_id),
  UNIQUE INDEX ix_provider_1 (public_url(255)),
  UNIQUE INDEX ix_provider_2 (management_region_id))
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8;

CREATE TABLE t_provider_region (
  provider_id INT UNSIGNED NOT NULL,
  region_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (provider_id, region_id))
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8;

CREATE TABLE t_provisioned_entity (
  entity_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  billable_feature_id INT UNSIGNED NOT NULL,
  entity_name VARCHAR(256) NOT NULL,
  entity_subtype VARCHAR(128) NULL DEFAULT NULL,
  customer_id INT UNSIGNED NOT NULL,
  resource_manager_id INT UNSIGNED NOT NULL,
  infrastructure_region_id INT UNSIGNED NOT NULL,
  entity_foreign_id VARCHAR(256) NULL DEFAULT NULL,
  provisioned_date DATETIME(6) NULL DEFAULT NULL,
  deprovisioned_date DATETIME(6) NULL DEFAULT NULL,
  PRIMARY KEY (entity_id),
  INDEX ix_provisioned_entity_1 (entity_foreign_id(255) ASC),
  INDEX ix_provisioned_entity_2 (customer_id),
  INDEX ix_provisioned_entity_3 (resource_manager_id ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE t_rate_plan (
  rate_plan_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  rate_plan_name VARCHAR(255) NULL DEFAULT NULL,
  applies_to VARCHAR(32) NOT NULL,
  rate_plan_description VARCHAR(1024) NULL DEFAULT NULL,
  proration_details LONGTEXT NULL DEFAULT NULL,
  currency CHAR(6) NULL DEFAULT NULL,
  discount_percent VARCHAR(20) NULL DEFAULT NULL,
  management_region_id VARCHAR(64) NOT NULL,
  PRIMARY KEY (rate_plan_id),
  INDEX ix_rate_plan_1 (management_region_id ASC),
  UNIQUE INDEX ix_rate_plan_2 (management_region_id, rate_plan_name))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE t_rate_plan_assignment (
  rate_plan_id INT UNSIGNED NOT NULL,
  assignee_id INT UNSIGNED NOT NULL,
  assignee_type VARCHAR(64) NOT NULL,
  assignment_start_date DATETIME(6) NOT NULL,
  assignment_end_date DATETIME(6) NOT NULL,
  assignment_type VARCHAR(64) NOT NULL,
  PRIMARY KEY (rate_plan_id, assignee_id, assignment_start_date, assignment_end_date),
  INDEX ix_rate_plan_assignment_1 (assignee_type, assignee_id, assignment_start_date, assignment_end_date ASC),
  INDEX ix_rate_plan_assignment_2 (assignment_type, assignee_id, assignment_start_date, assignment_end_date ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE t_rate_plan_billable_attribute (
  rate_plan_id INT UNSIGNED NOT NULL,
  feature_type VARCHAR(128) NOT NULL,
  attribute_class VARCHAR(32) NOT NULL,
  attribute_category VARCHAR(128) NOT NULL,
  attribute_name VARCHAR(128) NOT NULL,
  attribute_value VARCHAR(512) NOT NULL,
  attribute_unit VARCHAR(64) NULL DEFAULT NULL,
  attribute_datatype VARCHAR(32) NOT NULL,
  charge VARCHAR(32) NOT NULL,
  operator VARCHAR(32) NULL DEFAULT NULL,
  billing_scheme VARCHAR(64) NOT NULL,
  cost_calculation_frequency VARCHAR(64) NOT NULL,
  filter TEXT NULL,
  infrastructure_region_id INT UNSIGNED NOT NULL DEFAULT 0,
  INDEX ix_rate_plan_billable_attribute_1 (rate_plan_id, infrastructure_region_id))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE t_rate_plan_billable_feature (
  rate_plan_id INT UNSIGNED NOT NULL,
  billable_feature_id INT UNSIGNED NOT NULL,
  billable_feature_subtype VARCHAR(128) NOT NULL,
  billable_interval_type VARCHAR(64) NOT NULL,
  cost_calculation_frequency VARCHAR(64) NOT NULL,
  charge VARCHAR(100) NULL DEFAULT NULL,
  infrastructure_region_id INT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (rate_plan_id, infrastructure_region_id, billable_feature_id, billable_feature_subtype, billable_interval_type))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE t_rate_plan_billable_metric (
  rate_plan_id INT UNSIGNED NOT NULL,
  vendor_type  VARCHAR(128) NOT NULL,
  metric_name VARCHAR(128) NOT NULL,
  metric_unit VARCHAR(32) NULL DEFAULT NULL,
  metric_type VARCHAR(32) NULL DEFAULT NULL,
  billing_scheme VARCHAR(64) NOT NULL,
  billing_scheme_details LONGTEXT NULL DEFAULT NULL,
  infrastructure_region_id INT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (rate_plan_id, infrastructure_region_id, vendor_type, metric_name, billing_scheme))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE t_rate_plan_billable_event (
  rate_plan_id INT UNSIGNED NOT NULL,
  billable_feature_id INT UNSIGNED NOT NULL,
  billable_feature_subtype VARCHAR(128) NOT NULL,
  event_type VARCHAR(128) NOT NULL,
  charge VARCHAR(100) NOT NULL,
  billing_scheme_details LONGTEXT NULL DEFAULT NULL,
  infrastructure_region_id INT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (rate_plan_id, infrastructure_region_id, billable_feature_id, billable_feature_subtype, event_type))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE t_region (
  region_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  region_name VARCHAR(128) NOT NULL,
  region_type VARCHAR(64) NOT NULL,
  parent_region_id INT UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (region_id),
  UNIQUE INDEX ix_region_1 (parent_region_id, region_type, region_name ASC),
  INDEX ix_region_2 (parent_region_id))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE t_resource_configuration_history (
  resource_id INT UNSIGNED NOT NULL,
  resource_name VARCHAR(512) NULL DEFAULT NULL,
  resource_foreign_id VARCHAR(146) NULL DEFAULT NULL,
  resource_configuration LONGTEXT NOT NULL,
  start_date DATETIME(6) NOT NULL,
  end_date DATETIME(6) NOT NULL,
  customer_id LONGTEXT NULL DEFAULT NULL,
  customer_foreign_id VARCHAR(146) NULL DEFAULT NULL,
  customer_name VARCHAR(512) NULL DEFAULT NULL,
  resource_manager_id VARCHAR(72) NULL DEFAULT NULL,
  resource_manager_name VARCHAR(512) NULL DEFAULT NULL,
  resource_manager_foreign_id VARCHAR(72) NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE t_resource_event (
  event_id VARCHAR(100) NOT NULL,
  event_type VARCHAR(128) NOT NULL,
  event_date DATETIME(6) NOT NULL,
  resource_id VARCHAR(36) NULL DEFAULT NULL,
  resource_name VARCHAR(256) NULL DEFAULT NULL,
  resource_foreign_id VARCHAR(512) NULL DEFAULT NULL,
  customer_id VARCHAR(36) NULL DEFAULT NULL,
  customer_name VARCHAR(512) NULL DEFAULT NULL,
  customer_foreign_id VARCHAR(512) NULL DEFAULT NULL,
  resource_manager_id VARCHAR(36) NOT NULL,
  resource_manager_foreign_id VARCHAR(512) NULL DEFAULT NULL,
  infrastructure_region_id INT UNSIGNED NULL DEFAULT NULL,
  management_region_id INT UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (resource_manager_id, event_id),
  INDEX ix_vm_event_1 (resource_foreign_id(255) ASC, event_date ASC),
  INDEX ix_vm_event_2 (customer_id ASC),
  INDEX ix_vm_event_3 (resource_name(255), event_date DESC),
  INDEX ix_vm_event_4 (resource_manager_id ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE t_resource_group (
  resource_group_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  resource_group_name VARCHAR(512) NOT NULL,
  resource_group_type VARCHAR(64) NULL DEFAULT NULL,
  customer_id INT UNSIGNED NOT NULL,
  parent_id INT UNSIGNED NOT NULL,
  parent_type VARCHAR(64) NOT NULL,
  PRIMARY KEY (resource_group_id),
  INDEX ix_resource_group_1 (parent_id ASC),
  INDEX ix_resource_group_2 (customer_id ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE t_resource_in_use_interval (
  resource_id VARCHAR(36) NULL DEFAULT NULL,
  resource_name VARCHAR(512) NULL DEFAULT NULL,
  resource_foreign_id LONGTEXT NULL DEFAULT NULL,
  interval_type VARCHAR(64) NOT NULL,
  start_date DATETIME(6) NOT NULL,
  end_date DATETIME(6) NOT NULL,
  interval_length_milliseconds BIGINT(20) NULL DEFAULT NULL,
  resource_manager_id VARCHAR(36) NULL DEFAULT NULL,
  resource_manager_name VARCHAR(512) NULL DEFAULT NULL,
  resource_manager_foreign_id VARCHAR(512) NULL DEFAULT NULL,
  customer_id VARCHAR(36) NULL DEFAULT NULL,
  customer_name VARCHAR(512) NULL DEFAULT NULL,
  customer_foreign_id VARCHAR(512) NULL DEFAULT NULL,
  management_region_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (resource_id, interval_type, start_date, end_date),
  INDEX ix_resource_in_use_interval_1 (resource_name(255) ASC),
  INDEX ix_resource_in_use_interval_2 (customer_name(255) ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE t_resource_manager (
  resource_manager_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  resource_manager_name VARCHAR(512) NOT NULL,
  resource_manager_description VARCHAR(1024) NULL DEFAULT NULL,
  resource_manager_vendor_type VARCHAR(64) NULL DEFAULT NULL,
  resource_manager_foreign_id VARCHAR(512) NULL DEFAULT NULL,
  metadata LONGTEXT NULL DEFAULT NULL,
  last_metric_sync_times VARCHAR(5120) NULL DEFAULT NULL,
  last_entity_sync_times VARCHAR(5120) NULL DEFAULT NULL,
  infrastructure_region_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (resource_manager_id))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE t_resource_manager_sync_times (
  resource_manager_id INT UNSIGNED NOT NULL,
  sync_time_key VARCHAR(255) NOT NULL,
  sync_time VARCHAR(255) NOT NULL,
  PRIMARY KEY (resource_manager_id, sync_time_key))
ENGINE=InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE t_usage_metric (
  resource_id INT UNSIGNED NULL DEFAULT 0,
  resource_foreign_id VARCHAR(255) NOT NULL,
  resource_name VARCHAR(256) NULL DEFAULT NULL,
  resource_type VARCHAR(256) NULL DEFAULT NULL,
  metric_name VARCHAR(128) NOT NULL,
  metric_interval VARCHAR(64) NULL DEFAULT 600,
  collection_time DATETIME(6) NOT NULL,
  collection_hour varchar(10) NOT NULL,
  metric_value DOUBLE NOT NULL,
  metric_unit VARCHAR(64) NOT NULL,
  customer_id INT UNSIGNED NOT NULL,
  customer_name VARCHAR(256) NULL DEFAULT NULL,
  customer_foreign_id VARCHAR(255) NULL DEFAULT NULL,
  resource_manager_id INT UNSIGNED NOT NULL,
  infrastructure_region_id INT UNSIGNED NOT NULL,
  management_region_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (resource_foreign_id, metric_name, collection_time),
  INDEX ix_usage_metrics_2 (customer_id, collection_time, resource_foreign_id, metric_name))
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8;

CREATE TABLE t_user_permissions (
  user_id INT UNSIGNED NOT NULL,
  permission LONGTEXT NOT NULL,
  PRIMARY KEY (user_id, permission(255)))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE t_user_roles (
  user_id INT UNSIGNED NOT NULL,
  role_name VARCHAR(128) NOT NULL,
  role_context INT UNSIGNED NOT NULL,
  context_type VARCHAR(64) NOT NULL,
  UNIQUE INDEX (user_id, role_name, role_context, context_type))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE t_users (
  user_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  username VARCHAR(128) NOT NULL,
  first_name VARCHAR(256) NULL DEFAULT NULL,
  last_name VARCHAR(256) NULL DEFAULT NULL,
  email_address VARCHAR(512) NULL DEFAULT NULL,
  phone_number VARCHAR(64) NULL DEFAULT NULL,
  password VARCHAR(512) NOT NULL,
  is_active TINYINT(1) NULL DEFAULT NULL,
  password_change_token VARCHAR(64) NULL,
  last_password_change_date DATETIME(6) NULL,
  password_change_token_expire_date DATETIME(6) NULL,
  PRIMARY KEY (user_id),
  UNIQUE INDEX (username))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE t_unbilled_charges (
  invoice_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  payer_id INT UNSIGNED NOT NULL,
  payer_type VARCHAR(64) NOT NULL,
  payer_name VARCHAR(512) NOT NULL,
  invoice_number VARCHAR(45) NULL,
  invoice_date DATETIME(6) NOT NULL,
  period_begin DATETIME(6) NOT NULL,
  period_end DATETIME(6) NOT NULL,
  invoice_amount DECIMAL(19,2) NOT NULL,
  actual_charges DECIMAL(19,2) NOT NULL,
  invoice_currency VARCHAR(16) NULL,
  management_region_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (invoice_id),
  INDEX t_unbilled_charges_1 (management_region_id, payer_type, payer_id ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE t_unbilled_charges_detail (
  invoice_id INT UNSIGNED NOT NULL,
  customer_id INT UNSIGNED NOT NULL,
  resource_group_id VARCHAR(36) NULL,
  invoice_group VARCHAR(128) NULL,
  item_name VARCHAR(512) NULL,
  item_vendor_type VARCHAR(128) NULL,
  item_type VARCHAR(128) NOT NULL,
  item_subtype VARCHAR(128) NOT NULL,
  item_description VARCHAR(512) NOT NULL,
  rate_plan_id VARCHAR(36) NULL,
  rate_plan_billable_feature_id VARCHAR(36) NULL DEFAULT NULL,
  billing_interval VARCHAR(64) NULL DEFAULT NULL,
  item_invoice_amount DECIMAL(19,2) NOT NULL,
  num_units VARCHAR(32) NOT NULL,
  num_units_unit VARCHAR(16) NULL,
  INDEX ix_unbilled_charges_detail_1 (invoice_id ASC),
  INDEX ix_unbilled_charges_detail_2 (customer_id ASC),
  INDEX ix_unbilled_charges_detail_3 (item_vendor_type, item_type, item_subtype ASC),
  INDEX ix_unbilled_charges_detail_4 (rate_plan_id ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Views
-- -----------------------------------------------------

CREATE VIEW v_invoice_detail AS SELECT
      i.*,
      c.customer_name
  FROM
      (t_invoice_detail i
      LEFT JOIN t_customer c ON ((i.customer_id = c.customer_id)));

CREATE VIEW v_customer AS SELECT
      c.*,
      r1.region_name as management_region_name,
      r2.region_name as infrastructure_region_name
  FROM
      (t_customer c
      LEFT JOIN t_region r1 ON (c.management_region_id = r1.region_id)
      LEFT JOIN t_region r2 ON (c.infrastructure_region_id = r2.region_id));

CREATE VIEW v_rate_plan_assignment AS SELECT
     a.*,
     r.management_region_id
  FROM
     (t_rate_plan_assignment a
     LEFT JOIN t_rate_plan r ON (a.rate_plan_id = r.rate_plan_id));

CREATE VIEW v_users AS SELECT
     u.*,
     r.role_name,
     r.role_context
  FROM
     (t_users u
     LEFT JOIN t_user_roles r ON (u.user_id = r.user_id));

CREATE VIEW v_provider AS SELECT
      t_provider.*,
      t_region.parent_region_id as parent_management_region_id
    FROM
      (t_provider
      LEFT JOIN t_region ON (t_region.region_id = t_provider.management_region_id));

CREATE VIEW v_provider_region AS SELECT
     t_region.*,
     t_provider_region.provider_id
  FROM
     (t_region
     LEFT JOIN t_provider_region ON (t_region.region_id = t_provider_region.region_id));

CREATE VIEW v_unbilled_charges_detail AS SELECT
      i.*,
      c.customer_name
  FROM
      (t_unbilled_charges_detail i
      LEFT JOIN t_customer c ON ((i.customer_id = c.customer_id)));

commit;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Recreate workflow schema and tables.
-- -----------------------------------------------------

DROP SCHEMA IF EXISTS openbook_workflow;
CREATE SCHEMA openbook_workflow DEFAULT CHARACTER SET utf8;

GRANT ALL PRIVILEGES ON openbook_workflow.* TO openbook@'%' IDENTIFIED BY 'Tall!g3nt';
GRANT ALL PRIVILEGES ON openbook_workflow.* TO openbook@localhost IDENTIFIED BY 'Tall!g3nt';
FLUSH PRIVILEGES;

USE openbook_workflow;

create table ACT_GE_PROPERTY (
  NAME_ varchar(64),
  VALUE_ varchar(300),
  REV_ integer,
  primary key (NAME_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_bin;

insert into ACT_GE_PROPERTY
values ('schema.version', '5.14', 1);

insert into ACT_GE_PROPERTY
values ('schema.history', 'create(5.14)', 1);

insert into ACT_GE_PROPERTY
values ('next.dbid', '1', 1);

create table ACT_GE_BYTEARRAY (
  ID_ varchar(64),
  REV_ integer,
  NAME_ varchar(255),
  DEPLOYMENT_ID_ varchar(64),
  BYTES_ LONGBLOB,
  GENERATED_ TINYINT,
  primary key (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_bin;

create table ACT_RE_DEPLOYMENT (
  ID_ varchar(64),
  NAME_ varchar(255),
  CATEGORY_ varchar(255),
  DEPLOY_TIME_ timestamp,
  primary key (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_bin;

create table ACT_RE_MODEL (
  ID_ varchar(64) not null,
  REV_ integer,
  NAME_ varchar(255),
  KEY_ varchar(255),
  CATEGORY_ varchar(255),
  CREATE_TIME_ timestamp null,
  LAST_UPDATE_TIME_ timestamp null,
  VERSION_ integer,
  META_INFO_ varchar(4000),
  DEPLOYMENT_ID_ varchar(64),
  EDITOR_SOURCE_VALUE_ID_ varchar(64),
  EDITOR_SOURCE_EXTRA_VALUE_ID_ varchar(64),
  primary key (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_bin;

create table ACT_RU_EXECUTION (
  ID_ varchar(64),
  REV_ integer,
  PROC_INST_ID_ varchar(64),
  BUSINESS_KEY_ varchar(255),
  PARENT_ID_ varchar(64),
  PROC_DEF_ID_ varchar(64),
  SUPER_EXEC_ varchar(64),
  ACT_ID_ varchar(255),
  IS_ACTIVE_ TINYINT,
  IS_CONCURRENT_ TINYINT,
  IS_SCOPE_ TINYINT,
  IS_EVENT_SCOPE_ TINYINT,
  SUSPENSION_STATE_ integer,
  CACHED_ENT_STATE_ integer,
  primary key (ID_),
  unique ACT_UNIQ_RU_BUS_KEY (PROC_DEF_ID_, BUSINESS_KEY_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_bin;

create table ACT_RU_JOB (
  ID_ varchar(64) NOT NULL,
  REV_ integer,
  TYPE_ varchar(255) NOT NULL,
  LOCK_EXP_TIME_ timestamp NULL,
  LOCK_OWNER_ varchar(255),
  EXCLUSIVE_ boolean,
  EXECUTION_ID_ varchar(64),
  PROCESS_INSTANCE_ID_ varchar(64),
  PROC_DEF_ID_ varchar(64),
  RETRIES_ integer,
  EXCEPTION_STACK_ID_ varchar(64),
  EXCEPTION_MSG_ varchar(4000),
  DUEDATE_ timestamp NULL,
  REPEAT_ varchar(255),
  HANDLER_TYPE_ varchar(255),
  HANDLER_CFG_ varchar(4000),
  primary key (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_bin;

create table ACT_RE_PROCDEF (
  ID_ varchar(64) not null,
  REV_ integer,
  CATEGORY_ varchar(255),
  NAME_ varchar(255),
  KEY_ varchar(255) not null,
  VERSION_ integer not null,
  DEPLOYMENT_ID_ varchar(64),
  RESOURCE_NAME_ varchar(4000),
  DGRM_RESOURCE_NAME_ varchar(4000),
  DESCRIPTION_ varchar(4000),
  HAS_START_FORM_KEY_ TINYINT,
  SUSPENSION_STATE_ integer,
  primary key (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_bin;

create table ACT_RU_TASK (
  ID_ varchar(64),
  REV_ integer,
  EXECUTION_ID_ varchar(64),
  PROC_INST_ID_ varchar(64),
  PROC_DEF_ID_ varchar(64),
  NAME_ varchar(255),
  PARENT_TASK_ID_ varchar(64),
  DESCRIPTION_ varchar(4000),
  TASK_DEF_KEY_ varchar(255),
  OWNER_ varchar(255),
  ASSIGNEE_ varchar(255),
  DELEGATION_ varchar(64),
  PRIORITY_ integer,
  CREATE_TIME_ timestamp,
  DUE_DATE_ datetime,
  SUSPENSION_STATE_ integer,
  primary key (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_bin;

create table ACT_RU_IDENTITYLINK (
  ID_ varchar(64),
  REV_ integer,
  GROUP_ID_ varchar(255),
  TYPE_ varchar(255),
  USER_ID_ varchar(255),
  TASK_ID_ varchar(64),
  PROC_INST_ID_ varchar(64),
  PROC_DEF_ID_ varchar(64),
  primary key (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_bin;

create table ACT_RU_VARIABLE (
  ID_ varchar(64) not null,
  REV_ integer,
  TYPE_ varchar(255) not null,
  NAME_ varchar(255) not null,
  EXECUTION_ID_ varchar(64),
  PROC_INST_ID_ varchar(64),
  TASK_ID_ varchar(64),
  BYTEARRAY_ID_ varchar(64),
  DOUBLE_ double,
  LONG_ bigint,
  TEXT_ varchar(4000),
  TEXT2_ varchar(4000),
  primary key (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_bin;

create table ACT_RU_EVENT_SUBSCR (
  ID_ varchar(64) not null,
  REV_ integer,
  EVENT_TYPE_ varchar(255) not null,
  EVENT_NAME_ varchar(255),
  EXECUTION_ID_ varchar(64),
  PROC_INST_ID_ varchar(64),
  ACTIVITY_ID_ varchar(64),
  CONFIGURATION_ varchar(255),
  CREATED_ timestamp not null DEFAULT CURRENT_TIMESTAMP,
  primary key (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_bin;

create index ACT_IDX_EXEC_BUSKEY on ACT_RU_EXECUTION(BUSINESS_KEY_);
create index ACT_IDX_TASK_CREATE on ACT_RU_TASK(CREATE_TIME_);
create index ACT_IDX_IDENT_LNK_USER on ACT_RU_IDENTITYLINK(USER_ID_);
create index ACT_IDX_IDENT_LNK_GROUP on ACT_RU_IDENTITYLINK(GROUP_ID_);
create index ACT_IDX_EVENT_SUBSCR_CONFIG_ on ACT_RU_EVENT_SUBSCR(CONFIGURATION_);
create index ACT_IDX_VARIABLE_TASK_ID on ACT_RU_VARIABLE(TASK_ID_);
create index ACT_IDX_ATHRZ_PROCEDEF on ACT_RU_IDENTITYLINK(PROC_DEF_ID_);

alter table ACT_GE_BYTEARRAY
add constraint ACT_FK_BYTEARR_DEPL
foreign key (DEPLOYMENT_ID_)
references ACT_RE_DEPLOYMENT (ID_);

alter table ACT_RE_PROCDEF
add constraint ACT_UNIQ_PROCDEF
unique (KEY_,VERSION_);

alter table ACT_RU_EXECUTION
add constraint ACT_FK_EXE_PROCINST
foreign key (PROC_INST_ID_)
references ACT_RU_EXECUTION (ID_) on delete cascade on update cascade;

alter table ACT_RU_EXECUTION
add constraint ACT_FK_EXE_PARENT
foreign key (PARENT_ID_)
references ACT_RU_EXECUTION (ID_);

alter table ACT_RU_EXECUTION
add constraint ACT_FK_EXE_SUPER
foreign key (SUPER_EXEC_)
references ACT_RU_EXECUTION (ID_);

alter table ACT_RU_EXECUTION
add constraint ACT_FK_EXE_PROCDEF
foreign key (PROC_DEF_ID_)
references ACT_RE_PROCDEF (ID_);

alter table ACT_RU_IDENTITYLINK
add constraint ACT_FK_TSKASS_TASK
foreign key (TASK_ID_)
references ACT_RU_TASK (ID_);

alter table ACT_RU_IDENTITYLINK
add constraint ACT_FK_ATHRZ_PROCEDEF
foreign key (PROC_DEF_ID_)
references ACT_RE_PROCDEF(ID_);

alter table ACT_RU_IDENTITYLINK
add constraint ACT_FK_IDL_PROCINST
foreign key (PROC_INST_ID_)
references ACT_RU_EXECUTION (ID_);

alter table ACT_RU_TASK
add constraint ACT_FK_TASK_EXE
foreign key (EXECUTION_ID_)
references ACT_RU_EXECUTION (ID_);

alter table ACT_RU_TASK
add constraint ACT_FK_TASK_PROCINST
foreign key (PROC_INST_ID_)
references ACT_RU_EXECUTION (ID_);

alter table ACT_RU_TASK
add constraint ACT_FK_TASK_PROCDEF
foreign key (PROC_DEF_ID_)
references ACT_RE_PROCDEF (ID_);

alter table ACT_RU_VARIABLE
add constraint ACT_FK_VAR_EXE
foreign key (EXECUTION_ID_)
references ACT_RU_EXECUTION (ID_);

alter table ACT_RU_VARIABLE
add constraint ACT_FK_VAR_PROCINST
foreign key (PROC_INST_ID_)
references ACT_RU_EXECUTION(ID_);

alter table ACT_RU_VARIABLE
add constraint ACT_FK_VAR_BYTEARRAY
foreign key (BYTEARRAY_ID_)
references ACT_GE_BYTEARRAY (ID_);

alter table ACT_RU_JOB
add constraint ACT_FK_JOB_EXCEPTION
foreign key (EXCEPTION_STACK_ID_)
references ACT_GE_BYTEARRAY (ID_);

alter table ACT_RU_EVENT_SUBSCR
add constraint ACT_FK_EVENT_EXEC
foreign key (EXECUTION_ID_)
references ACT_RU_EXECUTION(ID_);

alter table ACT_RE_MODEL
add constraint ACT_FK_MODEL_SOURCE
foreign key (EDITOR_SOURCE_VALUE_ID_)
references ACT_GE_BYTEARRAY (ID_);

alter table ACT_RE_MODEL
add constraint ACT_FK_MODEL_SOURCE_EXTRA
foreign key (EDITOR_SOURCE_EXTRA_VALUE_ID_)
references ACT_GE_BYTEARRAY (ID_);

alter table ACT_RE_MODEL
add constraint ACT_FK_MODEL_DEPLOYMENT
foreign key (DEPLOYMENT_ID_)
references ACT_RE_DEPLOYMENT (ID_);

-- -----------------------------------------------------
-- Create history tables
-- -----------------------------------------------------

create table ACT_HI_PROCINST (
  ID_ varchar(64) not null,
  PROC_INST_ID_ varchar(64) not null,
  BUSINESS_KEY_ varchar(255),
  PROC_DEF_ID_ varchar(64) not null,
  START_TIME_ datetime not null,
  END_TIME_ datetime,
  DURATION_ bigint,
  START_USER_ID_ varchar(255),
  START_ACT_ID_ varchar(255),
  END_ACT_ID_ varchar(255),
  SUPER_PROCESS_INSTANCE_ID_ varchar(64),
  DELETE_REASON_ varchar(4000),
  primary key (ID_),
  unique (PROC_INST_ID_),
  unique ACT_UNIQ_HI_BUS_KEY (PROC_DEF_ID_, BUSINESS_KEY_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_bin;

create table ACT_HI_ACTINST (
  ID_ varchar(64) not null,
  PROC_DEF_ID_ varchar(64) not null,
  PROC_INST_ID_ varchar(64) not null,
  EXECUTION_ID_ varchar(64) not null,
  ACT_ID_ varchar(255) not null,
  TASK_ID_ varchar(64),
  CALL_PROC_INST_ID_ varchar(64),
  ACT_NAME_ varchar(255),
  ACT_TYPE_ varchar(255) not null,
  ASSIGNEE_ varchar(255),
  START_TIME_ datetime not null,
  END_TIME_ datetime,
  DURATION_ bigint,
  primary key (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_bin;

create table ACT_HI_TASKINST (
  ID_ varchar(64) not null,
  PROC_DEF_ID_ varchar(64),
  TASK_DEF_KEY_ varchar(255),
  PROC_INST_ID_ varchar(64),
  EXECUTION_ID_ varchar(64),
  NAME_ varchar(255),
  PARENT_TASK_ID_ varchar(64),
  DESCRIPTION_ varchar(4000),
  OWNER_ varchar(255),
  ASSIGNEE_ varchar(255),
  START_TIME_ datetime not null,
  CLAIM_TIME_ datetime,
  END_TIME_ datetime,
  DURATION_ bigint,
  DELETE_REASON_ varchar(4000),
  PRIORITY_ integer,
  DUE_DATE_ datetime,
  FORM_KEY_ varchar(255),
  primary key (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_bin;

create table ACT_HI_VARINST (
  ID_ varchar(64) not null,
  PROC_INST_ID_ varchar(64),
  EXECUTION_ID_ varchar(64),
  TASK_ID_ varchar(64),
  NAME_ varchar(255) not null,
  VAR_TYPE_ varchar(100),
  REV_ integer,
  BYTEARRAY_ID_ varchar(64),
  DOUBLE_ double,
  LONG_ bigint,
  TEXT_ varchar(4000),
  TEXT2_ varchar(4000),
  primary key (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_bin;

create table ACT_HI_DETAIL (
  ID_ varchar(64) not null,
  TYPE_ varchar(255) not null,
  PROC_INST_ID_ varchar(64),
  EXECUTION_ID_ varchar(64),
  TASK_ID_ varchar(64),
  ACT_INST_ID_ varchar(64),
  NAME_ varchar(255) not null,
  VAR_TYPE_ varchar(255),
  REV_ integer,
  TIME_ datetime not null,
  BYTEARRAY_ID_ varchar(64),
  DOUBLE_ double,
  LONG_ bigint,
  TEXT_ varchar(4000),
  TEXT2_ varchar(4000),
  primary key (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_bin;

create table ACT_HI_COMMENT (
  ID_ varchar(64) not null,
  TYPE_ varchar(255),
  TIME_ datetime not null,
  USER_ID_ varchar(255),
  TASK_ID_ varchar(64),
  PROC_INST_ID_ varchar(64),
  ACTION_ varchar(255),
  MESSAGE_ varchar(4000),
  FULL_MSG_ LONGBLOB,
  primary key (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_bin;

create table ACT_HI_ATTACHMENT (
  ID_ varchar(64) not null,
  REV_ integer,
  USER_ID_ varchar(255),
  NAME_ varchar(255),
  DESCRIPTION_ varchar(4000),
  TYPE_ varchar(255),
  TASK_ID_ varchar(64),
  PROC_INST_ID_ varchar(64),
  URL_ varchar(4000),
  CONTENT_ID_ varchar(64),
  primary key (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_bin;

create table ACT_HI_IDENTITYLINK (
  ID_ varchar(64),
  GROUP_ID_ varchar(255),
  TYPE_ varchar(255),
  USER_ID_ varchar(255),
  TASK_ID_ varchar(64),
  PROC_INST_ID_ varchar(64),
  primary key (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_bin;

create index ACT_IDX_HI_PRO_INST_END on ACT_HI_PROCINST(END_TIME_);
create index ACT_IDX_HI_PRO_I_BUSKEY on ACT_HI_PROCINST(BUSINESS_KEY_);
create index ACT_IDX_HI_ACT_INST_START on ACT_HI_ACTINST(START_TIME_);
create index ACT_IDX_HI_ACT_INST_END on ACT_HI_ACTINST(END_TIME_);
create index ACT_IDX_HI_DETAIL_PROC_INST on ACT_HI_DETAIL(PROC_INST_ID_);
create index ACT_IDX_HI_DETAIL_ACT_INST on ACT_HI_DETAIL(ACT_INST_ID_);
create index ACT_IDX_HI_DETAIL_TIME on ACT_HI_DETAIL(TIME_);
create index ACT_IDX_HI_DETAIL_NAME on ACT_HI_DETAIL(NAME_);
create index ACT_IDX_HI_DETAIL_TASK_ID on ACT_HI_DETAIL(TASK_ID_);
create index ACT_IDX_HI_PROCVAR_PROC_INST on ACT_HI_VARINST(PROC_INST_ID_);
create index ACT_IDX_HI_PROCVAR_NAME_TYPE on ACT_HI_VARINST(NAME_, VAR_TYPE_);
create index ACT_IDX_HI_ACT_INST_PROCINST on ACT_HI_ACTINST(PROC_INST_ID_, ACT_ID_);
create index ACT_IDX_HI_ACT_INST_EXEC on ACT_HI_ACTINST(EXECUTION_ID_, ACT_ID_);
create index ACT_IDX_HI_IDENT_LNK_USER on ACT_HI_IDENTITYLINK(USER_ID_);
create index ACT_IDX_HI_IDENT_LNK_TASK on ACT_HI_IDENTITYLINK(TASK_ID_);
create index ACT_IDX_HI_IDENT_LNK_PROCINST on ACT_HI_IDENTITYLINK(PROC_INST_ID_);

create table ACT_ID_GROUP (
  ID_ varchar(64),
  REV_ integer,
  NAME_ varchar(255),
  TYPE_ varchar(255),
  primary key (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_bin;

create table ACT_ID_MEMBERSHIP (
  USER_ID_ varchar(64),
  GROUP_ID_ varchar(64),
  primary key (USER_ID_, GROUP_ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_bin;

create table ACT_ID_USER (
  ID_ varchar(64),
  REV_ integer,
  FIRST_ varchar(255),
  LAST_ varchar(255),
  EMAIL_ varchar(255),
  PWD_ varchar(255),
  PICTURE_ID_ varchar(64),
  primary key (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_bin;

create table ACT_ID_INFO (
  ID_ varchar(64),
  REV_ integer,
  USER_ID_ varchar(64),
  TYPE_ varchar(64),
  KEY_ varchar(255),
  VALUE_ varchar(255),
  PASSWORD_ LONGBLOB,
  PARENT_ID_ varchar(255),
  primary key (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_bin;

alter table ACT_ID_MEMBERSHIP
add constraint ACT_FK_MEMB_GROUP
foreign key (GROUP_ID_)
references ACT_ID_GROUP (ID_);

alter table ACT_ID_MEMBERSHIP
add constraint ACT_FK_MEMB_USER
foreign key (USER_ID_)
references ACT_ID_USER (ID_);

COMMIT;

-- -----------------------------------------------------
-- Create Quartz tables
-- -----------------------------------------------------

DROP SCHEMA IF EXISTS openbook_jobs;
CREATE SCHEMA openbook_jobs DEFAULT CHARACTER SET utf8;

GRANT ALL PRIVILEGES ON openbook_jobs.* TO openbook@'%' IDENTIFIED BY 'Tall!g3nt';
GRANT ALL PRIVILEGES ON openbook_jobs.* TO openbook@localhost IDENTIFIED BY 'Tall!g3nt';
FLUSH PRIVILEGES;

USE openbook_jobs;

CREATE TABLE QRTZ_JOB_DETAILS(
  SCHED_NAME VARCHAR(120) NOT NULL,
  JOB_NAME VARCHAR(200) NOT NULL,
  JOB_GROUP VARCHAR(200) NOT NULL,
  DESCRIPTION VARCHAR(250) NULL,
  JOB_CLASS_NAME VARCHAR(250) NOT NULL,
  IS_DURABLE VARCHAR(1) NOT NULL,
  IS_NONCONCURRENT VARCHAR(1) NOT NULL,
  IS_UPDATE_DATA VARCHAR(1) NOT NULL,
  REQUESTS_RECOVERY VARCHAR(1) NOT NULL,
  JOB_DATA BLOB NULL,
PRIMARY KEY (SCHED_NAME,JOB_NAME,JOB_GROUP))
ENGINE=InnoDB;

CREATE TABLE QRTZ_TRIGGERS (
  SCHED_NAME VARCHAR(120) NOT NULL,
  TRIGGER_NAME VARCHAR(200) NOT NULL,
  TRIGGER_GROUP VARCHAR(200) NOT NULL,
  JOB_NAME VARCHAR(200) NOT NULL,
  JOB_GROUP VARCHAR(200) NOT NULL,
  DESCRIPTION VARCHAR(250) NULL,
  NEXT_FIRE_TIME BIGINT(13) NULL,
  PREV_FIRE_TIME BIGINT(13) NULL,
  PRIORITY INTEGER NULL,
  TRIGGER_STATE VARCHAR(16) NOT NULL,
  TRIGGER_TYPE VARCHAR(8) NOT NULL,
  START_TIME BIGINT(13) NOT NULL,
  END_TIME BIGINT(13) NULL,
  CALENDAR_NAME VARCHAR(200) NULL,
  MISFIRE_INSTR SMALLINT(2) NULL,
  JOB_DATA BLOB NULL,
PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
FOREIGN KEY (SCHED_NAME,JOB_NAME,JOB_GROUP)
REFERENCES QRTZ_JOB_DETAILS(SCHED_NAME,JOB_NAME,JOB_GROUP))
ENGINE=InnoDB;

CREATE TABLE QRTZ_SIMPLE_TRIGGERS (
  SCHED_NAME VARCHAR(120) NOT NULL,
  TRIGGER_NAME VARCHAR(200) NOT NULL,
  TRIGGER_GROUP VARCHAR(200) NOT NULL,
  REPEAT_COUNT BIGINT(7) NOT NULL,
  REPEAT_INTERVAL BIGINT(12) NOT NULL,
  TIMES_TRIGGERED BIGINT(10) NOT NULL,
PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP))
ENGINE=InnoDB;

CREATE TABLE QRTZ_CRON_TRIGGERS (
  SCHED_NAME VARCHAR(120) NOT NULL,
  TRIGGER_NAME VARCHAR(200) NOT NULL,
  TRIGGER_GROUP VARCHAR(200) NOT NULL,
  CRON_EXPRESSION VARCHAR(120) NOT NULL,
  TIME_ZONE_ID VARCHAR(80),
PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP))
ENGINE=InnoDB;

CREATE TABLE QRTZ_SIMPROP_TRIGGERS (
  SCHED_NAME VARCHAR(120) NOT NULL,
  TRIGGER_NAME VARCHAR(200) NOT NULL,
  TRIGGER_GROUP VARCHAR(200) NOT NULL,
  STR_PROP_1 VARCHAR(512) NULL,
  STR_PROP_2 VARCHAR(512) NULL,
  STR_PROP_3 VARCHAR(512) NULL,
  INT_PROP_1 INT NULL,
  INT_PROP_2 INT NULL,
  LONG_PROP_1 BIGINT NULL,
  LONG_PROP_2 BIGINT NULL,
  DEC_PROP_1 NUMERIC(13,4) NULL,
  DEC_PROP_2 NUMERIC(13,4) NULL,
  BOOL_PROP_1 VARCHAR(1) NULL,
  BOOL_PROP_2 VARCHAR(1) NULL,
PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP))
ENGINE=InnoDB;

CREATE TABLE QRTZ_BLOB_TRIGGERS (
  SCHED_NAME VARCHAR(120) NOT NULL,
  TRIGGER_NAME VARCHAR(200) NOT NULL,
  TRIGGER_GROUP VARCHAR(200) NOT NULL,
  BLOB_DATA BLOB NULL,
PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
INDEX (SCHED_NAME,TRIGGER_NAME, TRIGGER_GROUP),
FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP))
ENGINE=InnoDB;

CREATE TABLE QRTZ_CALENDARS (
  SCHED_NAME VARCHAR(120) NOT NULL,
  CALENDAR_NAME VARCHAR(200) NOT NULL,
  CALENDAR BLOB NOT NULL,
PRIMARY KEY (SCHED_NAME,CALENDAR_NAME))
ENGINE=InnoDB;

CREATE TABLE QRTZ_PAUSED_TRIGGER_GRPS (
  SCHED_NAME VARCHAR(120) NOT NULL,
  TRIGGER_GROUP VARCHAR(200) NOT NULL,
PRIMARY KEY (SCHED_NAME,TRIGGER_GROUP))
ENGINE=InnoDB;

CREATE TABLE QRTZ_FIRED_TRIGGERS (
  SCHED_NAME VARCHAR(120) NOT NULL,
  ENTRY_ID VARCHAR(95) NOT NULL,
  TRIGGER_NAME VARCHAR(200) NOT NULL,
  TRIGGER_GROUP VARCHAR(200) NOT NULL,
  INSTANCE_NAME VARCHAR(200) NOT NULL,
  FIRED_TIME BIGINT(13) NOT NULL,
  SCHED_TIME BIGINT(13) NOT NULL,
  PRIORITY INTEGER NOT NULL,
  STATE VARCHAR(16) NOT NULL,
  JOB_NAME VARCHAR(200) NULL,
  JOB_GROUP VARCHAR(200) NULL,
  IS_NONCONCURRENT VARCHAR(1) NULL,
  REQUESTS_RECOVERY VARCHAR(1) NULL,
PRIMARY KEY (SCHED_NAME,ENTRY_ID))
ENGINE=InnoDB;

CREATE TABLE QRTZ_SCHEDULER_STATE (
  SCHED_NAME VARCHAR(120) NOT NULL,
  INSTANCE_NAME VARCHAR(200) NOT NULL,
  LAST_CHECKIN_TIME BIGINT(13) NOT NULL,
  CHECKIN_INTERVAL BIGINT(13) NOT NULL,
PRIMARY KEY (SCHED_NAME,INSTANCE_NAME))
ENGINE=InnoDB;

CREATE TABLE QRTZ_LOCKS (
  SCHED_NAME VARCHAR(120) NOT NULL,
  LOCK_NAME VARCHAR(40) NOT NULL,
PRIMARY KEY (SCHED_NAME,LOCK_NAME))
ENGINE=InnoDB;

CREATE INDEX IDX_QRTZ_J_REQ_RECOVERY ON QRTZ_JOB_DETAILS(SCHED_NAME,REQUESTS_RECOVERY);
CREATE INDEX IDX_QRTZ_J_GRP ON QRTZ_JOB_DETAILS(SCHED_NAME,JOB_GROUP);

CREATE INDEX IDX_QRTZ_T_J ON QRTZ_TRIGGERS(SCHED_NAME,JOB_NAME,JOB_GROUP);
CREATE INDEX IDX_QRTZ_T_JG ON QRTZ_TRIGGERS(SCHED_NAME,JOB_GROUP);
CREATE INDEX IDX_QRTZ_T_C ON QRTZ_TRIGGERS(SCHED_NAME,CALENDAR_NAME);
CREATE INDEX IDX_QRTZ_T_G ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_GROUP);
CREATE INDEX IDX_QRTZ_T_STATE ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_STATE);
CREATE INDEX IDX_QRTZ_T_N_STATE ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP,TRIGGER_STATE);
CREATE INDEX IDX_QRTZ_T_N_G_STATE ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_GROUP,TRIGGER_STATE);
CREATE INDEX IDX_QRTZ_T_NEXT_FIRE_TIME ON QRTZ_TRIGGERS(SCHED_NAME,NEXT_FIRE_TIME);
CREATE INDEX IDX_QRTZ_T_NFT_ST ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_STATE,NEXT_FIRE_TIME);
CREATE INDEX IDX_QRTZ_T_NFT_MISFIRE ON QRTZ_TRIGGERS(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME);
CREATE INDEX IDX_QRTZ_T_NFT_ST_MISFIRE ON QRTZ_TRIGGERS(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME,TRIGGER_STATE);
CREATE INDEX IDX_QRTZ_T_NFT_ST_MISFIRE_GRP ON QRTZ_TRIGGERS(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME,TRIGGER_GROUP,TRIGGER_STATE);

CREATE INDEX IDX_QRTZ_FT_TRIG_INST_NAME ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,INSTANCE_NAME);
CREATE INDEX IDX_QRTZ_FT_INST_JOB_REQ_RCVRY ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,INSTANCE_NAME,REQUESTS_RECOVERY);
CREATE INDEX IDX_QRTZ_FT_J_G ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,JOB_NAME,JOB_GROUP);
CREATE INDEX IDX_QRTZ_FT_JG ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,JOB_GROUP);
CREATE INDEX IDX_QRTZ_FT_T_G ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP);
CREATE INDEX IDX_QRTZ_FT_TG ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,TRIGGER_GROUP);

COMMIT;
