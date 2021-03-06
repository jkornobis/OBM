-- MySQL dump 10.11
--
-- Host: localhost    Database: obm
-- ------------------------------------------------------
-- Server version	5.0.68

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Account`
--

DROP TABLE IF EXISTS `Account`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `Account` (
  `account_id` int(8) NOT NULL auto_increment,
  `account_domain_id` int(8) NOT NULL,
  `account_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `account_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `account_userupdate` int(8) default NULL,
  `account_usercreate` int(8) default NULL,
  `account_bank` varchar(60) NOT NULL default '',
  `account_number` varchar(11) NOT NULL default '0',
  `account_balance` double(15,2) NOT NULL default '0.00',
  `account_today` double(15,2) NOT NULL default '0.00',
  `account_comment` varchar(100) default NULL,
  `account_label` varchar(40) NOT NULL default '',
  PRIMARY KEY  (`account_id`),
  KEY `account_domain_id_domain_id_fkey` (`account_domain_id`),
  KEY `account_usercreate_userobm_id_fkey` (`account_usercreate`),
  KEY `account_userupdate_userobm_id_fkey` (`account_userupdate`),
  CONSTRAINT `account_userupdate_userobm_id_fkey` FOREIGN KEY (`account_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `account_domain_id_domain_id_fkey` FOREIGN KEY (`account_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `account_usercreate_userobm_id_fkey` FOREIGN KEY (`account_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `Account`
--

LOCK TABLES `Account` WRITE;
/*!40000 ALTER TABLE `Account` DISABLE KEYS */;
/*!40000 ALTER TABLE `Account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AccountEntity`
--

DROP TABLE IF EXISTS `AccountEntity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `AccountEntity` (
  `accountentity_entity_id` int(8) NOT NULL,
  `accountentity_account_id` int(8) NOT NULL,
  PRIMARY KEY  (`accountentity_entity_id`,`accountentity_account_id`),
  KEY `accountentity_account_id_account_id_fkey` (`accountentity_account_id`),
  CONSTRAINT `accountentity_account_id_account_id_fkey` FOREIGN KEY (`accountentity_account_id`) REFERENCES `Account` (`account_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `accountentity_entity_id_entity_id_fkey` FOREIGN KEY (`accountentity_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `AccountEntity`
--

LOCK TABLES `AccountEntity` WRITE;
/*!40000 ALTER TABLE `AccountEntity` DISABLE KEYS */;
/*!40000 ALTER TABLE `AccountEntity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ActiveUserObm`
--

DROP TABLE IF EXISTS `ActiveUserObm`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ActiveUserObm` (
  `activeuserobm_sid` varchar(32) NOT NULL default '',
  `activeuserobm_session_name` varchar(32) NOT NULL default '',
  `activeuserobm_userobm_id` int(11) default NULL,
  `activeuserobm_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `activeuserobm_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `activeuserobm_nb_connexions` int(11) NOT NULL default '0',
  `activeuserobm_lastpage` varchar(64) NOT NULL default '0',
  `activeuserobm_ip` varchar(32) NOT NULL default '0',
  PRIMARY KEY  (`activeuserobm_sid`),
  KEY `activeuserobm_userobm_id_userobm_id_fkey` (`activeuserobm_userobm_id`),
  CONSTRAINT `activeuserobm_userobm_id_userobm_id_fkey` FOREIGN KEY (`activeuserobm_userobm_id`) REFERENCES `UserObm` (`userobm_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ActiveUserObm`
--

LOCK TABLES `ActiveUserObm` WRITE;
/*!40000 ALTER TABLE `ActiveUserObm` DISABLE KEYS */;
/*!40000 ALTER TABLE `ActiveUserObm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Address`
--

DROP TABLE IF EXISTS `Address`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `Address` (
  `address_id` int(8) NOT NULL auto_increment,
  `address_entity_id` int(8) NOT NULL,
  `address_street` text,
  `address_zipcode` varchar(14) default NULL,
  `address_town` varchar(128) default NULL,
  `address_state` varchar(128) default NULL,
  `address_expresspostal` varchar(16) default NULL,
  `address_country` char(2) default NULL,
  `address_label` varchar(255) default NULL,
  PRIMARY KEY  (`address_id`),
  KEY `address_entity_id_entity_id_fkey` (`address_entity_id`),
  CONSTRAINT `address_entity_id_entity_id_fkey` FOREIGN KEY (`address_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `Address`
--

LOCK TABLES `Address` WRITE;
/*!40000 ALTER TABLE `Address` DISABLE KEYS */;
/*!40000 ALTER TABLE `Address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CV`
--

DROP TABLE IF EXISTS `CV`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `CV` (
  `cv_id` int(8) NOT NULL auto_increment,
  `cv_domain_id` int(8) NOT NULL,
  `cv_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `cv_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `cv_userupdate` int(8) default NULL,
  `cv_usercreate` int(8) default NULL,
  `cv_userobm_id` int(8) NOT NULL,
  `cv_title` varchar(255) default NULL,
  `cv_additionnalrefs` text,
  `cv_comment` text,
  PRIMARY KEY  (`cv_id`),
  KEY `cv_domain_id_domain_id_fkey` (`cv_domain_id`),
  KEY `cv_userobm_id_userobm_id_fkey` (`cv_userobm_id`),
  KEY `cv_userupdate_userobm_id_fkey` (`cv_userupdate`),
  KEY `cv_usercreate_userobm_id_fkey` (`cv_usercreate`),
  CONSTRAINT `cv_usercreate_userobm_id_fkey` FOREIGN KEY (`cv_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `cv_domain_id_domain_id_fkey` FOREIGN KEY (`cv_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cv_userobm_id_userobm_id_fkey` FOREIGN KEY (`cv_userobm_id`) REFERENCES `UserObm` (`userobm_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cv_userupdate_userobm_id_fkey` FOREIGN KEY (`cv_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `CV`
--

LOCK TABLES `CV` WRITE;
/*!40000 ALTER TABLE `CV` DISABLE KEYS */;
/*!40000 ALTER TABLE `CV` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CalendarEntity`
--

DROP TABLE IF EXISTS `CalendarEntity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `CalendarEntity` (
  `calendarentity_entity_id` int(8) NOT NULL,
  `calendarentity_calendar_id` int(8) NOT NULL,
  PRIMARY KEY  (`calendarentity_entity_id`,`calendarentity_calendar_id`),
  KEY `calendarentity_calendar_id_calendar_id_fkey` (`calendarentity_calendar_id`),
  CONSTRAINT `calendarentity_calendar_id_calendar_id_fkey` FOREIGN KEY (`calendarentity_calendar_id`) REFERENCES `UserObm` (`userobm_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `calendarentity_entity_id_entity_id_fkey` FOREIGN KEY (`calendarentity_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `CalendarEntity`
--

LOCK TABLES `CalendarEntity` WRITE;
/*!40000 ALTER TABLE `CalendarEntity` DISABLE KEYS */;
/*!40000 ALTER TABLE `CalendarEntity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Campaign`
--

DROP TABLE IF EXISTS `Campaign`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `Campaign` (
  `campaign_id` int(8) NOT NULL auto_increment,
  `campaign_name` varchar(50) default NULL,
  `campaign_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `campaign_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `campaign_userupdate` int(8) default NULL,
  `campaign_usercreate` int(8) default NULL,
  `campaign_manager_id` int(8) default NULL,
  `campaign_tracker_key` int(11) default NULL,
  `campaign_refer_url` varchar(255) default NULL,
  `campaign_nb_sent` int(10) default NULL,
  `campaign_nb_error` int(10) default NULL,
  `campaign_nb_inqueue` int(10) default NULL,
  `campaign_progress` int(3) default NULL,
  `campaign_start_date` date default NULL,
  `campaign_end_date` date default NULL,
  `campaign_status` int(3) default NULL,
  `campaign_type` int(2) default NULL,
  `campaign_objective` text,
  `campaign_comment` text,
  `campaign_domain_id` int(8) NOT NULL,
  `campaign_email` int(8) default NULL,
  `campaign_parent` int(8) default NULL,
  `campaign_child_order` int(2) default NULL,
  PRIMARY KEY  (`campaign_id`),
  KEY `campaign_parent_fkey` (`campaign_parent`),
  KEY `campaign_email_fkey` (`campaign_email`),
  CONSTRAINT `campaign_parent_fkey` FOREIGN KEY (`campaign_parent`) REFERENCES `Campaign` (`campaign_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `campaign_email_fkey` FOREIGN KEY (`campaign_email`) REFERENCES `Document` (`document_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `Campaign`
--

LOCK TABLES `Campaign` WRITE;
/*!40000 ALTER TABLE `Campaign` DISABLE KEYS */;
/*!40000 ALTER TABLE `Campaign` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CampaignDisabledEntity`
--

DROP TABLE IF EXISTS `CampaignDisabledEntity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `CampaignDisabledEntity` (
  `campaigndisabledentity_entity_id` int(8) NOT NULL,
  `campaigndisabledentity_campaign_id` int(8) NOT NULL,
  PRIMARY KEY  (`campaigndisabledentity_entity_id`,`campaigndisabledentity_campaign_id`),
  KEY `campaigndisabledentity_campaign_id_campaign_id_fkey` (`campaigndisabledentity_campaign_id`),
  CONSTRAINT `campaigndisabledentity_campaign_id_campaign_id_fkey` FOREIGN KEY (`campaigndisabledentity_campaign_id`) REFERENCES `Campaign` (`campaign_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `campaigndisabledentity_entity_id_entity_id_fkey` FOREIGN KEY (`campaigndisabledentity_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `CampaignDisabledEntity`
--

LOCK TABLES `CampaignDisabledEntity` WRITE;
/*!40000 ALTER TABLE `CampaignDisabledEntity` DISABLE KEYS */;
/*!40000 ALTER TABLE `CampaignDisabledEntity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CampaignEntity`
--

DROP TABLE IF EXISTS `CampaignEntity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `CampaignEntity` (
  `campaignentity_entity_id` int(8) NOT NULL,
  `campaignentity_campaign_id` int(8) NOT NULL,
  PRIMARY KEY  (`campaignentity_entity_id`,`campaignentity_campaign_id`),
  KEY `campaignentity_campaign_id_campaign_id_fkey` (`campaignentity_campaign_id`),
  CONSTRAINT `campaignentity_campaign_id_campaign_id_fkey` FOREIGN KEY (`campaignentity_campaign_id`) REFERENCES `Campaign` (`campaign_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `campaignentity_entity_id_entity_id_fkey` FOREIGN KEY (`campaignentity_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `CampaignEntity`
--

LOCK TABLES `CampaignEntity` WRITE;
/*!40000 ALTER TABLE `CampaignEntity` DISABLE KEYS */;
/*!40000 ALTER TABLE `CampaignEntity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CampaignMailContent`
--

DROP TABLE IF EXISTS `CampaignMailContent`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `CampaignMailContent` (
  `campaignmailcontent_id` int(8) NOT NULL auto_increment,
  `campaignmailcontent_refext_id` varchar(8) default NULL,
  `campaignmailcontent_content` blob,
  PRIMARY KEY  (`campaignmailcontent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `CampaignMailContent`
--

LOCK TABLES `CampaignMailContent` WRITE;
/*!40000 ALTER TABLE `CampaignMailContent` DISABLE KEYS */;
/*!40000 ALTER TABLE `CampaignMailContent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CampaignMailTarget`
--

DROP TABLE IF EXISTS `CampaignMailTarget`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `CampaignMailTarget` (
  `campaignmailtarget_id` int(8) NOT NULL auto_increment,
  `campaignmailtarget_campaign_id` int(8) NOT NULL,
  `campaignmailtarget_entity_id` int(8) default NULL,
  `campaignmailtarget_status` int(8) default NULL,
  PRIMARY KEY  (`campaignmailtarget_id`),
  KEY `campaignmailtarget_campaign_id_campaign_id_fkey` (`campaignmailtarget_campaign_id`),
  KEY `campaignmailtarget_entity_id_entity_id_fkey` (`campaignmailtarget_entity_id`),
  CONSTRAINT `campaignmailtarget_campaign_id_campaign_id_fkey` FOREIGN KEY (`campaignmailtarget_campaign_id`) REFERENCES `Campaign` (`campaign_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `campaignmailtarget_entity_id_entity_id_fkey` FOREIGN KEY (`campaignmailtarget_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `CampaignMailTarget`
--

LOCK TABLES `CampaignMailTarget` WRITE;
/*!40000 ALTER TABLE `CampaignMailTarget` DISABLE KEYS */;
/*!40000 ALTER TABLE `CampaignMailTarget` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CampaignPushTarget`
--

DROP TABLE IF EXISTS `CampaignPushTarget`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `CampaignPushTarget` (
  `campaignpushtarget_id` int(8) NOT NULL auto_increment,
  `campaignpushtarget_mailcontent_id` int(8) NOT NULL,
  `campaignpushtarget_refext_id` varchar(8) default NULL,
  `campaignpushtarget_status` int(2) NOT NULL default '1',
  `campaignpushtarget_email_address` varchar(512) NOT NULL,
  `campaignpushtarget_properties` text,
  `campaignpushtarget_start_time` datetime default NULL,
  `campaignpushtarget_sent_time` datetime default NULL,
  `campaignpushtarget_retries` int(3) default NULL,
  PRIMARY KEY  (`campaignpushtarget_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `CampaignPushTarget`
--

LOCK TABLES `CampaignPushTarget` WRITE;
/*!40000 ALTER TABLE `CampaignPushTarget` DISABLE KEYS */;
/*!40000 ALTER TABLE `CampaignPushTarget` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CampaignTarget`
--

DROP TABLE IF EXISTS `CampaignTarget`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `CampaignTarget` (
  `campaigntarget_id` int(8) NOT NULL auto_increment,
  `campaigntarget_campaign_id` int(8) NOT NULL,
  `campaigntarget_entity_id` int(8) default NULL,
  `campaigntarget_status` int(8) default NULL,
  PRIMARY KEY  (`campaigntarget_id`),
  KEY `campaigntarget_campaign_id_campaign_id_fkey` (`campaigntarget_campaign_id`),
  KEY `campaigntarget_entity_id_entity_id_fkey` (`campaigntarget_entity_id`),
  CONSTRAINT `campaigntarget_campaign_id_campaign_id_fkey` FOREIGN KEY (`campaigntarget_campaign_id`) REFERENCES `Campaign` (`campaign_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `campaigntarget_entity_id_entity_id_fkey` FOREIGN KEY (`campaigntarget_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `CampaignTarget`
--

LOCK TABLES `CampaignTarget` WRITE;
/*!40000 ALTER TABLE `CampaignTarget` DISABLE KEYS */;
/*!40000 ALTER TABLE `CampaignTarget` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Category`
--

DROP TABLE IF EXISTS `Category`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `Category` (
  `category_id` int(8) NOT NULL auto_increment,
  `category_domain_id` int(8) default NULL,
  `category_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `category_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `category_userupdate` int(8) default NULL,
  `category_usercreate` int(8) default NULL,
  `category_category` varchar(24) NOT NULL default '',
  `category_code` varchar(10) NOT NULL default '',
  `category_label` varchar(100) NOT NULL default '',
  PRIMARY KEY  (`category_id`),
  KEY `cat_idx_cat` (`category_category`),
  KEY `category_domain_id_domain_id_fkey` (`category_domain_id`),
  KEY `category_userupdate_userobm_id_fkey` (`category_userupdate`),
  KEY `category_usercreate_userobm_id_fkey` (`category_usercreate`),
  CONSTRAINT `category_usercreate_userobm_id_fkey` FOREIGN KEY (`category_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `category_domain_id_domain_id_fkey` FOREIGN KEY (`category_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `category_userupdate_userobm_id_fkey` FOREIGN KEY (`category_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `Category`
--

LOCK TABLES `Category` WRITE;
/*!40000 ALTER TABLE `Category` DISABLE KEYS */;
/*!40000 ALTER TABLE `Category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CategoryLink`
--

DROP TABLE IF EXISTS `CategoryLink`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `CategoryLink` (
  `categorylink_category_id` int(8) NOT NULL,
  `categorylink_entity_id` int(8) NOT NULL,
  `categorylink_category` varchar(24) NOT NULL default '',
  PRIMARY KEY  (`categorylink_category_id`,`categorylink_entity_id`),
  KEY `catl_idx_ent` (`categorylink_entity_id`),
  KEY `catl_idx_cat` (`categorylink_category`),
  CONSTRAINT `categorylink_entity_id_entity_id_fkey` FOREIGN KEY (`categorylink_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `categorylink_category_id_category_id_fkey` FOREIGN KEY (`categorylink_category_id`) REFERENCES `Category` (`category_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `CategoryLink`
--

LOCK TABLES `CategoryLink` WRITE;
/*!40000 ALTER TABLE `CategoryLink` DISABLE KEYS */;
/*!40000 ALTER TABLE `CategoryLink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Company`
--

DROP TABLE IF EXISTS `Company`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `Company` (
  `company_id` int(8) NOT NULL auto_increment,
  `company_domain_id` int(8) NOT NULL,
  `company_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `company_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `company_userupdate` int(8) default NULL,
  `company_usercreate` int(8) default NULL,
  `company_datasource_id` int(8) default NULL,
  `company_number` varchar(32) default NULL,
  `company_vat` varchar(20) default NULL,
  `company_siret` varchar(14) default NULL,
  `company_archive` char(1) NOT NULL default '0',
  `company_name` varchar(96) NOT NULL default '',
  `company_aka` varchar(255) default NULL,
  `company_sound` varchar(48) default NULL,
  `company_type_id` int(8) default NULL,
  `company_activity_id` int(8) default NULL,
  `company_nafcode_id` int(8) default NULL,
  `company_marketingmanager_id` int(8) default NULL,
  `company_contact_number` int(5) NOT NULL default '0',
  `company_deal_number` int(5) NOT NULL default '0',
  `company_deal_total` int(5) NOT NULL default '0',
  `company_comment` text,
  PRIMARY KEY  (`company_id`),
  KEY `company_domain_id_domain_id_fkey` (`company_domain_id`),
  KEY `company_userupdate_userobm_id_fkey` (`company_userupdate`),
  KEY `company_usercreate_userobm_id_fkey` (`company_usercreate`),
  KEY `company_datasource_id_datasource_id_fkey` (`company_datasource_id`),
  KEY `company_type_id_companytype_id_fkey` (`company_type_id`),
  KEY `company_activity_id_companyactivity_id_fkey` (`company_activity_id`),
  KEY `company_nafcode_id_companynafcode_id_fkey` (`company_nafcode_id`),
  KEY `company_marketingmanager_id_userobm_id_fkey` (`company_marketingmanager_id`),
  CONSTRAINT `company_marketingmanager_id_userobm_id_fkey` FOREIGN KEY (`company_marketingmanager_id`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `company_activity_id_companyactivity_id_fkey` FOREIGN KEY (`company_activity_id`) REFERENCES `CompanyActivity` (`companyactivity_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `company_datasource_id_datasource_id_fkey` FOREIGN KEY (`company_datasource_id`) REFERENCES `DataSource` (`datasource_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `company_domain_id_domain_id_fkey` FOREIGN KEY (`company_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `company_nafcode_id_companynafcode_id_fkey` FOREIGN KEY (`company_nafcode_id`) REFERENCES `CompanyNafCode` (`companynafcode_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `company_type_id_companytype_id_fkey` FOREIGN KEY (`company_type_id`) REFERENCES `CompanyType` (`companytype_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `company_usercreate_userobm_id_fkey` FOREIGN KEY (`company_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `company_userupdate_userobm_id_fkey` FOREIGN KEY (`company_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `Company`
--

LOCK TABLES `Company` WRITE;
/*!40000 ALTER TABLE `Company` DISABLE KEYS */;
/*!40000 ALTER TABLE `Company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CompanyActivity`
--

DROP TABLE IF EXISTS `CompanyActivity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `CompanyActivity` (
  `companyactivity_id` int(8) NOT NULL auto_increment,
  `companyactivity_domain_id` int(8) NOT NULL,
  `companyactivity_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `companyactivity_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `companyactivity_userupdate` int(8) default NULL,
  `companyactivity_usercreate` int(8) default NULL,
  `companyactivity_code` varchar(10) default '',
  `companyactivity_label` varchar(64) default NULL,
  PRIMARY KEY  (`companyactivity_id`),
  KEY `companyactivity_domain_id_domain_id_fkey` (`companyactivity_domain_id`),
  KEY `companyactivity_userupdate_userobm_id_fkey` (`companyactivity_userupdate`),
  KEY `companyactivity_usercreate_userobm_id_fkey` (`companyactivity_usercreate`),
  CONSTRAINT `companyactivity_usercreate_userobm_id_fkey` FOREIGN KEY (`companyactivity_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `companyactivity_domain_id_domain_id_fkey` FOREIGN KEY (`companyactivity_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `companyactivity_userupdate_userobm_id_fkey` FOREIGN KEY (`companyactivity_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `CompanyActivity`
--

LOCK TABLES `CompanyActivity` WRITE;
/*!40000 ALTER TABLE `CompanyActivity` DISABLE KEYS */;
INSERT INTO `CompanyActivity` VALUES (1,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'','Education'),(2,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'','Industrie');
/*!40000 ALTER TABLE `CompanyActivity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CompanyEntity`
--

DROP TABLE IF EXISTS `CompanyEntity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `CompanyEntity` (
  `companyentity_entity_id` int(8) NOT NULL,
  `companyentity_company_id` int(8) NOT NULL,
  PRIMARY KEY  (`companyentity_entity_id`,`companyentity_company_id`),
  KEY `companyentity_company_id_company_id_fkey` (`companyentity_company_id`),
  CONSTRAINT `companyentity_company_id_company_id_fkey` FOREIGN KEY (`companyentity_company_id`) REFERENCES `Company` (`company_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `companyentity_entity_id_entity_id_fkey` FOREIGN KEY (`companyentity_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `CompanyEntity`
--

LOCK TABLES `CompanyEntity` WRITE;
/*!40000 ALTER TABLE `CompanyEntity` DISABLE KEYS */;
/*!40000 ALTER TABLE `CompanyEntity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CompanyNafCode`
--

DROP TABLE IF EXISTS `CompanyNafCode`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `CompanyNafCode` (
  `companynafcode_id` int(8) NOT NULL auto_increment,
  `companynafcode_domain_id` int(8) NOT NULL,
  `companynafcode_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `companynafcode_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `companynafcode_userupdate` int(8) default NULL,
  `companynafcode_usercreate` int(8) default NULL,
  `companynafcode_title` int(1) NOT NULL default '0',
  `companynafcode_code` varchar(4) default NULL,
  `companynafcode_label` varchar(128) default NULL,
  PRIMARY KEY  (`companynafcode_id`),
  KEY `companynafcode_domain_id_domain_id_fkey` (`companynafcode_domain_id`),
  KEY `companynafcode_userupdate_userobm_id_fkey` (`companynafcode_userupdate`),
  KEY `companynafcode_usercreate_userobm_id_fkey` (`companynafcode_usercreate`),
  CONSTRAINT `companynafcode_usercreate_userobm_id_fkey` FOREIGN KEY (`companynafcode_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `companynafcode_domain_id_domain_id_fkey` FOREIGN KEY (`companynafcode_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `companynafcode_userupdate_userobm_id_fkey` FOREIGN KEY (`companynafcode_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=803 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `CompanyNafCode`
--

LOCK TABLES `CompanyNafCode` WRITE;
/*!40000 ALTER TABLE `CompanyNafCode` DISABLE KEYS */;
INSERT INTO `CompanyNafCode` VALUES (1,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'01','Agriculture, chasse, services annexes'),(2,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'011A','Culture de céréales ; cultures industrielles'),(3,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'011C','Culture de légumes ; maraichage'),(4,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'011D','Horticulture ; pépinières'),(5,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'011F','Culture fruitière'),(6,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'011G','Viticulture'),(7,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'012A','Elevage de bovins'),(8,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'012C','Elevage d\'ovins, caprins et équidés'),(9,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'012E','Elevage de porcins'),(10,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'012G','Elevage de volailles'),(11,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'012J','Elevage d\'autres animaux'),(12,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'013Z','Culture et élevage associés'),(13,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'014A','Services aux cultures productives'),(14,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'014B','Réalisation et entretien de plantations ornementales'),(15,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'014D','Services annexes à l\'élevage'),(16,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'015Z','Chasse'),(17,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'02','Sylviculture, exploitation forestière, services annexes'),(18,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'020A','Sylviculture'),(19,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'020B','Exploitation forestière'),(20,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'020D','Services forestiers'),(21,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'05','Pêche, aquacultures'),(22,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'050A','Pêche'),(23,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'050C','Pisciculture, aquaculture'),(24,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'10','Extraction de houille, de lignite et de tourbes'),(25,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'101Z','Extraction et agglomération de la houille'),(26,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'102Z','Extraction et agglomération du lignite'),(27,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'103Z','Extraction et agglomération de la tourbe'),(28,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'11','Extraction d\'hydrocarbures, services annexes'),(29,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'111Z','Extraction d\'hydrocarbures'),(30,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'112Z','Services annexes à l\'extraction d\'hydrocarbures'),(31,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'12','Extraction de minerais d\'uraniums'),(32,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'120Z','Extraction de minerais d\'uranium'),(33,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'13','Extraction de minerais metalliques'),(34,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'131Z','Extraction de minerais de fer'),(35,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'132Z','Extraction de minerais de métaux non ferreux'),(36,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'14','Autres industries extractives'),(37,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'141A','Extraction de pierres pour la construction'),(38,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'141C','Extraction de calcaire industriel, de gypse et de craie'),(39,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'141E','Extraction d\'ardoise'),(40,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'142A','Production de sables et de granulats'),(41,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'142C','Extraction d\'argiles et de kaolin'),(42,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'143Z','Extrac de minéraux pour industrie chimique et d\'engrais naturels'),(43,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'144Z','Production de sel'),(44,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'145Z','Activités extractives n.c.a.'),(45,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'15','Industries alimentaires'),(46,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'151A','Production de viandes de boucherie'),(47,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'151C','Production de viandes de volaille'),(48,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'151E','Préparation industrielle de produits à base de viande'),(49,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'151F','Charcuterie'),(50,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'152Z','Industrie du poisson'),(51,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'153A','Transformation et conservation de pommes de terre'),(52,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'153C','Préparation de jus de fruits et légumes'),(53,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'153E','Transformation et conservation de légumes'),(54,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'153F','Transformation et conservation de fruits'),(55,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'154A','Fabrication d\'huiles et graisses brutes'),(56,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'154C','Fabrication d\'huiles et graisses raffinées'),(57,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'154E','Fabrication de margarine'),(58,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'155A','Fabrication de lait liquide et de produits frais'),(59,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'155B','Fabrication de beurre'),(60,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'155C','Fabrication de fromages'),(61,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'155D','Fabrication d\'autres produits laitiers'),(62,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'155F','Fabrication de glaces et sorbets'),(63,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'156A','Meunerie'),(64,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'156B','Autres activités de travail des grains'),(65,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'156D','Fabrication de produits amylacés'),(66,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'157A','Fabrication d\'aliments pour animaux de ferme'),(67,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'157C','Fabrication d\'aliments pour animaux de compagnie'),(68,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'158A','Fabrication industrielle de pain et de pâtisserie fraîche'),(69,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'158B','Cuisson de produits de boulangerie'),(70,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'158C','Boulangerie et boulangerie pâtisserie'),(71,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'158D','Pâtisserie'),(72,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'158F','Biscotterie, biscuiterie, pâtisserie de conservation'),(73,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'158H','Fabrication de sucre'),(74,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'158K','Chocolaterie, confiserie'),(75,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'158M','Fabrication de pâtes alimentaires'),(76,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'158P','Transformation du thé et du café'),(77,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'158R','Fabrication de condiments et assaisonnements'),(78,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'158T','Fabrication d\'aliments adaptés à l\'enfant et diététiques'),(79,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'158V','Industries alimentaires n.c.a.'),(80,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'159A','Production d\'eaux de vie naturelles'),(81,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'159B','Fabrication de spiritueux'),(82,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'159D','Production d\'alcool éthylique de fermentation'),(83,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'159F','Champagnisation'),(84,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'159G','Vinification'),(85,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'159J','Cidrerie'),(86,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'159L','Production d\'autres boissons fermentées'),(87,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'159N','Brasserie'),(88,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'159Q','Malterie'),(89,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'159S','Industrie des eaux de table'),(90,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'159T','Production de boissons rafraîchissantes'),(91,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'16','Industrie du tabacs'),(92,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'160Z','Industrie du tabac'),(93,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'17','Industrie textiles'),(94,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'171A','Filature de l\'industrie cotonnière'),(95,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'171C','Filature de l\'industrie lainière cycle cardé'),(96,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'171E','Préparation de la laine'),(97,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'171F','Filature de l\'industrie lainière cycle peigné'),(98,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'171H','Préparation et filature du lin'),(99,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'171K','Moulinage texturation de soie et textiles artif et synthétiques'),(100,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'171M','Fabrication de fils à coudre'),(101,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'171P','Préparation et filature d\'autres fibres'),(102,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'172A','Tissage de l\'industrie cotonnière'),(103,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'172C','Tissage de l\'industrie lainière cycle cardé'),(104,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'172E','Tissage de l\'industrie lainière cycle peigné'),(105,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'172G','Tissage de soieries'),(106,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'172J','Tissage d\'autres textiles'),(107,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'173Z','Ennoblissement textile'),(108,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'174A','Fabrication de linge de maison et d\'articles d\'ameublement'),(109,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'174B','Fabrication de petits articles textiles de literie'),(110,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'174C','Fabrication d\'autres articles confectionnés en textile'),(111,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'175A','Fabrication de tapis et moquettes'),(112,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'175C','Ficellerie, corderie, fabrication de filets'),(113,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'175E','Fabrication de non tissés'),(114,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'175G','Industries textiles n.c.a.'),(115,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'176Z','Fabrication d\'étoffes à maille'),(116,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'177A','Fabrication d\'articles chaussants à maille'),(117,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'177C','Fabrication de pull overs et articles similaires'),(118,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'18','Industrie de l\'habillement et des fourrures'),(119,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'181Z','Fabrication de vêtements en cuir'),(120,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'182A','Fabrication de vêtements de travail'),(121,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'182C','Fabrication de vêtements sur mesure'),(122,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'182D','Fabrication de vêtements de dessus pour hommes et garçonnets'),(123,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'182E','Fabrication de vêtements de dessus pour femmes et fillettes'),(124,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'182G','Fabrication de vêtements de dessous'),(125,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'182J','Fabrication d\'autres vêtements et accessoires'),(126,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'183Z','Industrie des fourrures'),(127,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'19','Industrie du cuir et de la chaussures'),(128,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'191Z','Apprêt et tannage des cuirs'),(129,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'192Z','Fabrication d\'articles de voyage et de maroquinerie'),(130,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'193Z','Fabrication de chaussures'),(131,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'20','Travail du bois et fabrication d\'articles en bois'),(132,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'201A','Sciage et rabotage du bois'),(133,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'201B','Imprégnation du bois'),(134,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'202Z','Fabrication de panneaux de bois'),(135,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'203Z','Fabrication de charpentes et de menuiseries'),(136,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'204Z','Fabrication d\'emballages en bois'),(137,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'205A','Fabrication d\'objets divers en bois'),(138,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'205C','Fabrication d\'objets en liège, vannerie ou sparterie'),(139,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'21','Industrie du papier et du cartons'),(140,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'211A','Fabrication de pâte à papier'),(141,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'211C','Fabrication de papier et de carton'),(142,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'212A','Industrie du carton ondulé'),(143,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'212B','Fabrication de cartonnages'),(144,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'212C','Fabrication d\'emballages en papier'),(145,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'212E','Fabrication d\'articles en papier à usage sanitaire ou domestique'),(146,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'212G','Fabrication d\'articles de papeterie'),(147,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'212J','Fabrication de papiers peints'),(148,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'212L','Fabrication d\'autres articles en papier ou en carton'),(149,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'22','Edition, imprimerie, reproductions'),(150,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'221A','Edition de livres'),(151,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'221C','Edition de journaux'),(152,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'221E','Edition de revues et périodiques'),(153,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'221G','Edition d\'enregistrements sonores'),(154,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'221J','Autres activités d\'édition'),(155,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'222A','Imprimerie de journaux'),(156,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'222C','Autre imprimerie (labeur)'),(157,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'222E','Reliure et finition'),(158,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'222G','Composition et photogravure'),(159,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'222J','Autres activités graphiques'),(160,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'223A','Reproduction d\'enregistrements sonores'),(161,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'223C','Reproduction d\'enregistrements vidéo'),(162,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'223E','Reproduction d\'enregistrements informatiques'),(163,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'23','Cokefaction, raffinage, industries nucléaires'),(164,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'231Z','Cokéfaction'),(165,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'232Z','Raffinage de pétrole'),(166,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'233Z','Elaboration et transformation de matières nucléaires'),(167,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'24','Industrie chimiques'),(168,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'241A','Fabrication de gaz industriels'),(169,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'241C','Fabrication de colorants et de pigments'),(170,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'241E','Fabrication d\'autres produits chimiques inorganiques de base'),(171,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'241G','Fabrication d\'autres produits chimiques organiques de base'),(172,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'241J','Fabrication de produits azotés et d\'engrais'),(173,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'241L','Fabrication de matières plastiques de base'),(174,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'241N','Fabrication de caoutchouc synthétique'),(175,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'242Z','Fabrication de produits agrochimiques'),(176,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'243Z','Fabrication de peintures et vernis'),(177,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'244A','Fabrication de produits pharmaceutiques de base'),(178,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'244C','Fabrication de médicaments'),(179,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'244D','Fabrication d\'autres produits pharmaceutiques'),(180,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'245A','Fabrication de savons, détergents et produits d\'entretien'),(181,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'245C','Fabrication de parfums et de produits pour la toilette'),(182,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'246A','Fabrication de produits explosifs'),(183,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'246C','Fabrication de colles et gélatines'),(184,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'246E','Fabrication d\'huiles essentielles'),(185,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'246G','Fabrication de produits chimiques pour la photographie'),(186,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'246J','Fabrication de supports de données'),(187,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'246L','Fabrication de produits chimiques à usage industriel'),(188,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'247Z','Fabrication de fibres artificielles ou synthétiques'),(189,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'25','Industrie du caoutchouc et des plastiques'),(190,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'251A','Fabrication de pneumatiques'),(191,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'251C','Rechapage de pneumatiques'),(192,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'251E','Fabrication d\'autres articles en caoutchouc'),(193,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'252A','Fabric de plaques, feuilles, tubes et profilés en plastiques'),(194,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'252C','Fabrication d\'emballages en matières plastiques'),(195,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'252E','Fabric d\'éléments en matières plastiques pour la construction'),(196,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'252G','Fabrication d\'articles divers en matières plastiques'),(197,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'252H','Fabrication de pièces techniques en matières plastiques'),(198,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'26','Fabrication d\'autres produits mineraux non metalliques'),(199,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'261A','Fabrication de verre plat'),(200,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'261C','Façonnage et transformation du verre plat'),(201,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'261E','Fabrication de verre creux'),(202,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'261G','Fabrication de fibres de verre'),(203,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'261J','Fabrication et façonnage d\'articles techniques en verre'),(204,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'261K','Fabrication d\'isolateurs en verre'),(205,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'262A','Fabric d\'articles céramiques à usage domestique ou ornemental'),(206,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'262C','Fabrication d\'appareils sanitaires en céramique'),(207,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'262E','Fabrication d\'isolateurs et pièces isolantes en céramique'),(208,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'262G','Fabrication d\'autres produits céramiques à usage technique'),(209,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'262J','Fabrication d\'autres produits céramiques'),(210,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'262L','Fabrication de produits céramiques réfractaires'),(211,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'263Z','Fabrication de carreaux en céramique'),(212,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'264A','Fabrication de briques'),(213,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'264B','Fabrication de tuiles'),(214,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'264C','Fabrication de produits divers en terre cuite'),(215,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'265A','Fabrication de ciment'),(216,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'265C','Fabrication de chaux'),(217,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'265E','Fabrication de plâtre'),(218,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'266A','Fabrication d\'éléments en béton pour la construction'),(219,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'266C','Fabrication d\'éléments en plâtre pour la construction'),(220,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'266E','Fabrication de béton prêt à l\'emploi'),(221,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'266G','Fabrication de mortiers et bétons secs'),(222,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'266J','Fabrication d\'ouvrages en fibre ciment'),(223,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'266L','Fabrication d\'autres ouvrages en béton ou en plâtre'),(224,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'267Z','Travail de la pierre'),(225,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'268A','Fabrication de produits abrasifs'),(226,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'268C','Fabrication de produits minéraux non métalliques n.c.a.'),(227,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'27','Metallurgies'),(228,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'271Y','Sidérurgie'),(229,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'271Z','Sidérurgie (CECA)'),(230,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'272A','Fabrication de tubes en fonte'),(231,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'272C','Fabrication de tubes en acier'),(232,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'273A','Etirage à froid'),(233,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'273C','Laminage à froid de feuillards'),(234,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'273E','Profilage à froid par formage ou pliage'),(235,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'273G','Tréfilage à froid'),(236,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'273J','Production de ferroalliages et autres produits non CECA'),(237,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'274A','Production de métaux précieux'),(238,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'274C','Production d\'aluminium'),(239,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'274D','Première transformation de l\'aluminium'),(240,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'274F','Production de plomb, de zinc ou d\'étain'),(241,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'274G','Première transformation du plomb, du zinc ou de l\'étain'),(242,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'274J','Production de cuivre'),(243,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'274K','Première transformation du cuivre'),(244,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'274M','Métallurgie des autres métaux non ferreux'),(245,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'275A','Fonderie de fonte'),(246,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'275C','Fonderie d\'acier'),(247,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'275E','Fonderie de métaux légers'),(248,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'275G','Fonderie d\'autres métaux non ferreux'),(249,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'28','Travail des métauxs'),(250,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'281A','Fabrication de constructions métalliques'),(251,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'281C','Fabrication de menuiseries et fermetures métalliques'),(252,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'282A','Fabrication de réservoirs et citernes métalliques'),(253,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'282B','Fabrication de bouteilles pour gaz comprimés'),(254,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'282C','Fabrication de réservoirs, citernes et conteneurs métalliques'),(255,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'282D','Fabric de radiateurs et de chaudières pour le chauffage central'),(256,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'283A','Fabrication de générateurs de vapeur'),(257,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'283B','Chaudronnerie nucléaire'),(258,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'283C','Chaudronnerie tuyauterie'),(259,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'284A','Forge, estampage, matriçage'),(260,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'284B','Découpage, emboutissage'),(261,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'284C','Métallurgie des poudres'),(262,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'285A','Traitement et revêtement des métaux'),(263,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'285C','Décolletage'),(264,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'285D','Mécanique générale'),(265,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'286A','Fabrication de coutellerie'),(266,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'286C','Fabrication d\'outillage à main'),(267,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'286D','Fabrication d\'outillage mécanique'),(268,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'286F','Fabrication de serrures et ferrures'),(269,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'287A','Fabrication de futs et emballages métalliques similaires'),(270,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'287C','Fabrication d\'emballages métalliques légers'),(271,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'287E','Fabrication d\'articles en fils métalliques'),(272,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'287G','Visserie et boulonnerie'),(273,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'287H','Fabrication de ressorts'),(274,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'287J','Fabrication de chaines'),(275,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'287L','Fabrication d\'articles métalliques ménagers'),(276,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'287M','Fabrication de coffres forts'),(277,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'287N','Fabrication de petits articles métalliques'),(278,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'287P','Fabrication d\'articles métalliques n.c.a.'),(279,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'287Q','Fabrication d\'articles métalliques divers'),(280,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'29','Fabrication de machines et équipements'),(281,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'291A','Fabrication de moteurs et turbines'),(282,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'291B','Fabrication de pompes'),(283,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'291C','Fabrication de pompes et compresseurs'),(284,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'291D','Fabrication de transmissions hydrauliques et pneumatiques'),(285,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'291E','Fabrication de compresseurs'),(286,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'291F','Fabrication d\'articles de robinetterie'),(287,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'291H','Fabrication de roulements'),(288,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'291J','Fabrication d\'organes mécaniques de transmission'),(289,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'292A','Fabrication de fours et brûleurs'),(290,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'292C','Fabrication d\'ascenseurs, monte charges et escaliers mécaniques'),(291,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'292D','Fabrication d\'équipements de levage et de manutention'),(292,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'292F','Fabric d\'équipements aérauliques et frigorifiques industriels'),(293,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'292H','Fabrication d\'équipements d\'emballage et de conditionnement'),(294,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'292J','Fabrication d\'appareils de pesage'),(295,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'292K','Fabrication de machines diverses d\'usage général'),(296,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'292L','Fabrication de matériel pour les industries chimiques'),(297,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'292M','Fabrication d\'autres machines d\'usage général'),(298,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'293A','Fabrication de tracteurs agricoles'),(299,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'293C','Réparation de matériel agricole'),(300,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'293D','Fabrication de matériel agricole'),(301,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'294A','Fabrication de machines outils à métaux'),(302,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'294B','Fabrication de machines outils à bois'),(303,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'294C','Fabrication de machines outils portatives à moteur incorporé'),(304,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'294D','Fabrication de matériel de soudage'),(305,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'294E','Fabrication d\'autres machines outils'),(306,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'295A','Fabrication de machines pour la métallurgie'),(307,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'295B','Fabrication de matériels de mines pour l\'extraction'),(308,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'295C','Fabrication de machines pour l\'extraction ou la construction'),(309,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'295D','Fabrication de matériels de travaux publics'),(310,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'295E','Fabrication de machines pour l\'industrie agroalimentaire'),(311,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'295G','Fabrication de machines pour les industries textiles'),(312,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'295J','Fabric de machines pour les industries du papier et du carton'),(313,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'295L','Fabrication de machines d\'imprimerie'),(314,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'295M','Fabric de machines pour travail du caoutchouc ou des plastiques'),(315,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'295N','Fabrication de moules et modèles'),(316,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'295P','Fabrication d\'autres machines spécialisées'),(317,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'295Q','Fabrication de machines d\'assemblage automatique'),(318,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'295R','Fabrication de machines spécialisées diverses'),(319,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'296A','Fabrication d\'armement'),(320,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'296B','Fabrication d\'armes de chasse, de tir et de défense'),(321,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'297A','Fabrication d\'appareils électroménagers'),(322,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'297C','Fabrication d\'appareils ménagers non électriques'),(323,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'30','Fabrication de machines de bureau et de matériel informatiques'),(324,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'300A','Fabrication de machines de bureau'),(325,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'300C','Fabrication d\'ordinateurs et d\'autres équipements informatiques'),(326,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'31','Fabrication de machines et appareils électriques'),(327,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'311A','Fabric de moteurs, génératrices et transfo électriq inf à 750 kW'),(328,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'311B','Fabric de moteurs, génératrices et transfo électriq sup à 750 kW'),(329,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'311C','Réparation de matériels électriques'),(330,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'312A','Fabric matériel distribution ou commande électrique basse tension'),(331,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'312B','Fabric matériel distribution ou commande électrique haute tension'),(332,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'313Z','Fabrication de fils et câbles isolés'),(333,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'314Z','Fabrication d\'accumulateurs et de piles électriques'),(334,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'315A','Fabrication de lampes'),(335,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'315B','Fabrication d\'appareils électriques autonomes de sécurité'),(336,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'315C','Fabrication d\'appareils d\'éclairage'),(337,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'316A','Fabrication de matériels électriques pour moteurs et véhicules'),(338,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'316C','Fabrication de matériel électromagnétique industriel'),(339,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'316D','Fabrication de matériels électriques n.c.a.'),(340,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'32','Fabrication d\'équipements de radio, télévision et communications'),(341,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'321A','Fabrication de composants passifs et de condensateurs'),(342,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'321C','Fabrication de composants électroniques actifs'),(343,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'321D','Assemblage de cartes électroniques pour compte de tiers'),(344,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'322A','Fabrication équipements d\'émission et de transmission hertzienne'),(345,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'322B','Fabrication d\'appareils de téléphonie'),(346,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'323Z','Fab appareils réception, enregistrmt, reproduction son et image'),(347,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'33','Fabrication d\'instruments médicaux, de précision, d\'optique et d\'horlogeries'),(348,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'331A','Fabrication de matériel d\'imagerie médicale et de radiologie'),(349,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'331B','Fabrication d\'appareils médicochirurgicaux'),(350,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'332A','Fabrication d\'équipements d\'aide à la navigation'),(351,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'332B','Fabrication d\'instrumentation scientifique et technique'),(352,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'333Z','Fabrication d\'équipements de contrôle des processus industriels'),(353,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'334A','Fabrication de lunettes'),(354,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'334B','Fabrication d\'instruments d\'optique et de matériel photographique'),(355,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'335Z','Horlogerie'),(356,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'34','Industrie automobiles'),(357,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'341Z','Construction de véhicules automobiles'),(358,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'342A','Fabrication de carrosseries automobiles'),(359,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'342B','Fabrication de caravanes et véhicules de loisirs'),(360,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'343Z','Fabrication d\'équipements automobiles'),(361,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'35','Fabrication d\'autres matériels de transports'),(362,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'351A','Construction de bâtiments de guerre'),(363,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'351B','Construction de navires civils'),(364,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'351C','Réparation navale'),(365,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'351E','Construction de bateaux de plaisance'),(366,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'352Z','Construction de matériel ferroviaire roulant'),(367,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'353A','Construction de moteurs pour aéronefs'),(368,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'353B','Construction de cellules d\'aéronefs'),(369,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'353C','Construction de lanceurs et engins spatiaux'),(370,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'354A','Fabrication de motocycles'),(371,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'354C','Fabrication de bicyclettes'),(372,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'354E','Fabrication de véhicules pour invalides'),(373,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'355Z','Fabrication de matériels de transport n.c.a.'),(374,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'36','Fabrication de meubles; industries diverses'),(375,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'361A','Fabrication de sièges'),(376,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'361C','Fabrication de meubles de bureau et de magasin'),(377,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'361E','Fabrication de meubles de cuisine'),(378,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'361G','Fabrication de meubles meublants'),(379,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'361H','Fabrication de meubles de jardin et d\'extérieur'),(380,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'361J','Fabrication de meubles n.c.a.'),(381,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'361K','Industries connexes de l\'ameublement'),(382,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'361M','Fabrication de matelas'),(383,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'362A','Fabrication de monnaies et médailles'),(384,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'362C','Bijouterie, joaillerie, orfèvrerie'),(385,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'363Z','Fabrication d\'instruments de musique'),(386,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'364Z','Fabrication d\'articles de sport'),(387,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'365Z','Fabrication de jeux et jouets'),(388,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'366A','Bijouterie fantaisie'),(389,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'366C','Industrie de la brosserie'),(390,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'366E','Autres activités manufacturières n.c.a.'),(391,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'37','Récupérations'),(392,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'371Z','Récupération de matières métalliques recyclables'),(393,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'372Z','Récupération de matières non métalliques recyclables'),(394,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'40','Production et distribution d\'électricité, de gaz et de chaleurs'),(395,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'401A','Production d\'électricité'),(396,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'401C','Transport d\'électricité'),(397,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'401E','Distribution et commerce d\'électricité'),(398,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'401Z','Production et distribution d\'électricité'),(399,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'402A','Production de combustibles gazeux'),(400,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'402C','Distribution de combustibles gazeux'),(401,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'402Z','Production et distribution de combustibles gazeux'),(402,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'403Z','Production et distribution de chaleur'),(403,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'41','Captage, traitement et distribution d\'eau'),(404,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'410Z','Captage, traitement et distribution d\'eau'),(405,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'45','Constructions'),(406,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'451A','Terrassements divers, démolition'),(407,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'451B','Terrassements en grande masse'),(408,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'451D','Forages et sondages'),(409,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'452A','Construction de maisons individuelles'),(410,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'452B','Construction de bâtiments divers'),(411,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'452C','Construction d\'ouvrages d\'art'),(412,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'452D','Travaux souterrains'),(413,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'452E','Réalisation de réseaux'),(414,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'452F','Construction de lignes électriques et de télécommunications'),(415,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'452J','Réalisation de couvertures par éléments'),(416,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'452K','Travaux d\'étanchéification'),(417,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'452L','Travaux de charpente'),(418,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'452N','Construction de voies ferrées'),(419,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'452P','Construction de chaussées routières et de sols sportifs'),(420,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'452R','Travaux maritimes et fluviaux'),(421,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'452T','Levage, montage'),(422,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'452U','Autres travaux spécialisés de construction'),(423,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'452V','Travaux de maçonnerie générale'),(424,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'453A','Travaux d\'installation électrique'),(425,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'453C','Travaux d\'isolation'),(426,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'453E','Installation d\'eau et de gaz'),(427,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'453F','Installation d\'équipements thermiques et de climatisation'),(428,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'453H','Autres travaux d\'installation'),(429,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'454A','Plâtrerie'),(430,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'454C','Menuiserie bois et matières plastiques'),(431,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'454D','Menuiserie métallique ; serrurerie'),(432,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'454F','Revêtement des sols et des murs'),(433,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'454H','Miroiterie de bâtiment ; vitrerie'),(434,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'454J','Peinture'),(435,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'454L','Agencement de lieux de vente'),(436,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'454M','Travaux de finition n.c.a.'),(437,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'455Z','Location avec opérateur de matériel de construction'),(438,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'50','Commerce et réparation automobiles'),(439,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'501Z','Commerce de véhicules automobiles'),(440,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'502Z','Entretien et réparation de véhicules automobiles'),(441,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'503A','Commerce de gros d\'équipements automobiles'),(442,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'503B','Commerce de détail d\'équipements automobiles'),(443,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'504Z','Commerce et réparation de motocycles'),(444,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'505Z','Commerce de détail de carburants'),(445,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'51','Commerce de gros et intermédiaires du commerces'),(446,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'511A','Interméd comm en mat premières agric ou textiles, animaux vivants'),(447,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'511C','Interméd comm en combustibles, métaux, minéraux, prod chimiques'),(448,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'511E','Intermédiaires du commerce en bois et matériaux de construction'),(449,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'511G','Interméd comm en machines, équipemts industriels, navires, avions'),(450,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'511J','Interméd comm en meubles, articles de ménage et quincaillerie'),(451,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'511L','Interméd comm en textiles, habillement, chaussures, articles cuir'),(452,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'511N','Intermédiaires du commerce en produits alimentaires'),(453,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'511P','Centrales d\'achats alimentaires'),(454,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'511R','Autres intermédiaires spécialisés du commerce'),(455,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'511T','Intermédiaires non spécialisés du commerce'),(456,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'511U','Centrales d\'achats non alimentaires'),(457,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'512A','Commerce de gros de céréales et aliments pour le bétail'),(458,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'512C','Commerce de gros de fleurs et plantes'),(459,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'512E','Commerce de gros d\'animaux vivants'),(460,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'512G','Commerce de gros de cuirs et peaux'),(461,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'512J','Commerce de gros de tabac non manufacturé'),(462,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'513A','Commerce de gros de fruits et légumes'),(463,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'513C','Commerce de gros de viandes de boucherie'),(464,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'513D','Commerce de gros de produits à base de viande'),(465,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'513E','Commerce de gros de volailles et gibiers'),(466,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'513G','Commerce de gros de produits laitiers, oeufs, huiles'),(467,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'513J','Commerce de gros de boissons'),(468,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'513L','Commerce de gros de tabac'),(469,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'513N','Commerce de gros de sucre, chocolat et confiserie'),(470,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'513Q','Commerce de gros de café, thé, cacao et épices'),(471,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'513S','Commerce de gros de poissons, crustacés et mollusques'),(472,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'513T','Commerces de gros alimentaires spécialisés divers'),(473,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'513V','Commerce de gros de produits surgelés'),(474,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'513W','Commerce de gros alimentaire non spécialisé'),(475,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'514A','Commerce de gros de textiles'),(476,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'514C','Commerce de gros d\'habillement'),(477,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'514D','Commerce de gros de la chaussure'),(478,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'514F','Comm gros d\'appareils électroménagers et de radio télévision'),(479,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'514H','Commerce de gros de vaisselle et verrerie de ménage'),(480,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'514J','Comm gros de produits pour entretien et aménagement habitat'),(481,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'514L','Commerce de gros de parfumerie et produits de beauté'),(482,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'514N','Commerce de gros de produits pharmaceutiques'),(483,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'514Q','Commerce de gros de papeterie'),(484,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'514R','Commerce de gros de jouets'),(485,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'514S','Autres commerces de gros de biens de consommation'),(486,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'515A','Commerce de gros de combustibles'),(487,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'515C','Commerce de gros de minerais et métaux'),(488,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'515E','Commerce de gros de bois et de produits dérivés'),(489,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'515F','Comm gros de matériaux de construction et appareils sanitaires'),(490,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'515H','Commerce de gros de quincaillerie'),(491,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'515J','Commerce de gros de fournitures pour plomberie et chauffage'),(492,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'515L','Commerce de gros de produits chimiques'),(493,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'515N','Commerce de gros d\'autres produits intermédiaires'),(494,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'515Q','Commerce de gros de déchets et débris'),(495,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'516A','Commerce de gros de machines outils'),(496,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'516C','Commerce de gros d\'équipements pour la construction'),(497,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'516E','Comm gros de machines pour l\'industrie textile et l\'habillement'),(498,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'516G','Commerce de gros de machines de bureau et matériel informatique'),(499,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'516J','Commerce de gros de matériel électrique et électronique'),(500,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'516K','Commerce de gros de fournitures et équipements industriels divers'),(501,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'516L','Comm gros fournitures et équipts divers pr commerce et services'),(502,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'516N','Commerce de gros de matériel agricole'),(503,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'517Z','Autres commerces de gros'),(504,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'5181','Commerce de gros de machines outils'),(505,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'518C','Commerce de gros de machines pour l\'extraction, la construction et le génie civil'),(506,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'518E','Commerce de gros de machines pour l\'industrie textile et l\'habillement'),(507,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'518G','Commerce de gros d\'ordinateurs, d\'équipements informatiques périphériques et de progiciels'),(508,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'518H','Commerce de gros d\'autres machines et équipements de bureau'),(509,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'518J','Commerce de gros de composants et d\'autres équipements électroniques'),(510,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'518L','Commerce de gros de matériel électrique'),(511,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'518M','Commerce de gros de fournitures et équipement industriels divers'),(512,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'518N','Commerce de gros de fournitures et équipement industriels divers pour le commerce et les services'),(513,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'518P','Commerce de gros de matériel agricole'),(514,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'519A','Autres commerces de gros spécialisés'),(515,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'519B','Commerce de gros non spécialisé'),(516,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'52','Commerce de détail et réparation d\'articles domestiques'),(517,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'521A','Commerce de détail de produits surgelés'),(518,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'521B','Commerce d\'alimentation générale'),(519,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'521C','Superettes'),(520,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'521D','Supermarchés'),(521,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'521E','Magasins populaires'),(522,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'521F','Hypermarchés'),(523,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'521H','Grands magasins'),(524,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'521J','Autres commerces de détail en magasin non spécialisé'),(525,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'522A','Commerce de détail de fruits et légumes'),(526,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'522C','Commerce de détail de viandes et produits à base de viande'),(527,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'522E','Commerce de détail de poissons, crustacés et mollusques'),(528,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'522G','Commerce de détail de pain, pâtisserie et confiserie'),(529,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'522J','Commerce de détail de boissons'),(530,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'522L','Commerce de détail de tabac'),(531,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'522N','Commerce de détail de produits laitiers'),(532,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'522P','Commerces de détail alimentaires spécialisés divers'),(533,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'523A','Commerce de détail de produits pharmaceutiques'),(534,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'523C','Commerce de détail d\'articles médicaux et orthopédiques'),(535,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'523E','Commerce de détail de parfumerie et de produits de beauté'),(536,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'524A','Commerce de détail de textiles'),(537,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'524C','Commerce de détail d\'habillement'),(538,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'524E','Commerce de détail de la chaussure'),(539,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'524F','Commerce de détail de maroquinerie et d\'articles de voyage'),(540,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'524H','Commerce de détail de meubles'),(541,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'524J','Commerce de détail d\'équipements du foyer'),(542,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'524L','Comm détail d\'appareils électroménagers et de radio télévision'),(543,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'524N','Commerce de détail de quincaillerie'),(544,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'524P','Commerce de détail de bricolage'),(545,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'524R','Commerce de détail de livres, journaux et papeterie'),(546,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'524T','Commerce de détail d\'optique et de photographie'),(547,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'524U','Commerce de détail de revêtements de sols et de murs'),(548,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'524V','Commerce de détail d\'horlogerie et de bijouterie'),(549,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'524W','Commerce de détail d\'articles de sport et de loisir'),(550,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'524X','Commerce de détail de fleurs'),(551,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'524Y','Commerce de détail de charbons et combustibles'),(552,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'524Z','Commerces de détail divers en magasin spécialisé'),(553,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'525Z','Commerce de détail de biens d\'occasion en magasin'),(554,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'526A','Vente par correspondance sur catalogue général'),(555,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'526B','Vente par correspondance spécialisée'),(556,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'526D','Commerce de détail alimentaire sur éventaires et marchés'),(557,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'526E','Commerce de détail non alimentaire sur éventaires et marchés'),(558,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'526G','Vente à domicile'),(559,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'526H','Vente par automate'),(560,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'527A','Réparation de chaussures et articles en cuir'),(561,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'527C','Réparation de matériel électronique grand public'),(562,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'527D','Réparation d\'articles électriques à usage domestique'),(563,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'527F','Réparation de montres, horloges et bijoux'),(564,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'527H','Réparation d\'articles personnels et domestiques n.c.a.'),(565,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'55','Hôtels et restaurants'),(566,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'551A','Hôtels avec restaurant'),(567,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'551C','Hôtels de tourisme sans restaurant'),(568,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'551D','Hôtels de préfecture'),(569,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'551E','Autres hôtels'),(570,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'552A','Auberges de jeunesse et refuges'),(571,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'552C','Exploitation de terrains de camping'),(572,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'552E','Autre hébergement touristique'),(573,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'552F','Hébergement collectif non touristique'),(574,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'553A','Restauration de type traditionnel'),(575,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'553B','Restauration de type rapide'),(576,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'554A','Cafés tabacs'),(577,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'554B','Débits de boisson'),(578,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'554C','Discothèques'),(579,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'555A','Cantines, restaurants d\'entreprises'),(580,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'555C','Restauration collective sous contrat'),(581,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'555D','Traiteurs, organisation de réceptions'),(582,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'60','Transports terrestres'),(583,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'601Z','Transports ferroviaires'),(584,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'602A','Transports urbains de voyageurs'),(585,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'602B','Transports routiers réguliers de voyageurs'),(586,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'602C','Téléphériques, remontées mécaniques'),(587,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'602E','Transport de voyageurs par taxis'),(588,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'602G','Autres transports routiers de voyageurs'),(589,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'602L','Transports routiers de marchandises de proximité'),(590,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'602M','Transports routiers de marchandises interurbains'),(591,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'602N','Déménagement'),(592,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'602P','Location de camions avec conducteur'),(593,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'603Z','Transports par conduites'),(594,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'61','Transports par eaux'),(595,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'611A','Transports maritimes'),(596,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'611B','Transports côtiers'),(597,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'612Z','Transports fluviaux'),(598,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'62','Transports aériens'),(599,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'621Z','Transports aériens réguliers'),(600,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'622Z','Transports aériens non réguliers'),(601,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'623Z','Transports spatiaux'),(602,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'63','Services auxilliaires des transports'),(603,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'631A','Manutention portuaire'),(604,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'631B','Manutention non portuaire'),(605,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'631D','Entreposage frigorifique'),(606,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'631E','Entreposage non frigorifique'),(607,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'632A','Gestion d\'infrastructures de transports terrestres'),(608,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'632C','Services portuaires, maritimes et fluviaux'),(609,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'632E','Services aéroportuaires'),(610,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'633Z','Agences de voyage'),(611,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'634A','Messagerie, fret expres'),(612,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'634B','Affretement'),(613,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'634C','Organisation des transports internationaux'),(614,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'64','Postes et télécommunications'),(615,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'641A','Postes nationales'),(616,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'641C','Autres activités de courrier'),(617,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'642A','Télécommunications nationales'),(618,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'642B','Autres activités de télécommunications'),(619,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'642C','Télécommunications hors transmissions audiovisuelles'),(620,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'642D','Transmission d\'émissions de radio er de télévision'),(621,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'65','Intermédiation financières'),(622,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'651A','Banque centrale'),(623,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'651C','Banques'),(624,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'651D','Banques mutualistes'),(625,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'651E','Caisses d\'épargne'),(626,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'651F','Intermédiations monétaires n.c.a.'),(627,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'652A','Crédit bail'),(628,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'652C','Distribution de crédit'),(629,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'652E','Organismes de placement en valeurs mobilières'),(630,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'652F','Intermédiations financières diverses'),(631,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'66','Assurances'),(632,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'660A','Assurance vie et capitalisation'),(633,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'660C','Caisses de retraite'),(634,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'660E','Assurance dommages'),(635,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'660F','Réassurance'),(636,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'660G','Assurance relevant du code de la mutualité'),(637,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'67','Auxiliaires financiers et d\'assurances'),(638,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'671A','Administration de marchés financiers'),(639,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'671C','Gestion de portefeuilles'),(640,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'671E','Autres auxiliaires financiers'),(641,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'672Z','Auxiliaires d\'assurance'),(642,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'70','Activités immobilières'),(643,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'701A','Promotion immobilière de logements'),(644,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'701B','Promotion immobilière de bureaux'),(645,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'701C','Promotion immobilière d\'infrastructures'),(646,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'701D','Supports juridiques de programmes'),(647,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'701F','Marchands de biens immobiliers'),(648,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'702A','Location de logements'),(649,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'702B','Location de terrains'),(650,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'702C','Location d\'autres biens immobiliers'),(651,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'703A','Agences immobilières'),(652,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'703C','Administration d\'immeubles résidentiels'),(653,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'703D','Administration d\'autres biens immobiliers'),(654,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'703E','Supports juridiques de gestion de patrimoine'),(655,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'71','Location sans opérateurs'),(656,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'711A','Location de courte durée de véhicules automobiles'),(657,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'711B','Location de longue durée de véhicules automobiles'),(658,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'711Z','Location de véhicules automobiles'),(659,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'712A','Location d\'autres matériels de transport terrestre'),(660,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'712C','Location de matériels de transport par eau'),(661,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'712E','Location de matériels de transport aérien'),(662,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'713A','Location de matériel agricole'),(663,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'713C','Location de machines et équipements pour la construction'),(664,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'713E','Location de machines de bureau et de matériel informatique'),(665,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'713G','Location de machines et équipements divers'),(666,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'714A','Location de linge'),(667,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'714B','Location d\'autres biens personnels et domestiques'),(668,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'72','Activités informatiques'),(669,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'721Z','Conseil en systèmes informatiques'),(670,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'722A','Edition de logiciels (non personnalisés)'),(671,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'722C','Autres activités de réalisation de logiciels'),(672,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'722Z','Réalisation de logiciels'),(673,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'723Z','Traitement de données'),(674,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'724Z','Activités de banques de données'),(675,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'725Z','Entretien, réparation machines de bureau et matériel informatique'),(676,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'726Z','Autres activités rattachées à l\'informatique'),(677,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'73','Recherche et développements'),(678,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'731Z','Recherche développement en sciences physiques et naturelles'),(679,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'732Z','Recherche développement en sciences humaines et sociales'),(680,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'74','Services fournis principalement aux entreprises'),(681,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'741A','Activités juridiques'),(682,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'741C','Activités comptables'),(683,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'741E','Etudes de marché et sondages'),(684,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'741G','Conseil pour les affaires et la gestion'),(685,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'741J','Administration d\'entreprises'),(686,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'742A','Activités d\'architecture'),(687,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'742B','Métreurs, géomètres'),(688,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'742C','Ingénierie, études techniques'),(689,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'743A','Contrôle technique automobile'),(690,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'743B','Analyses, essais et inspections techniques'),(691,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'744A','Gestion de supports de publicité'),(692,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'744B','Agences, conseil en publicité'),(693,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'745A','Sélection et mise à disposition de personnel'),(694,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'745B','Travail temporaire'),(695,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'746Z','Enquêtes et sécurité'),(696,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'747Z','Activités de nettoyage'),(697,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'748A','Studios et autres activités photographiques'),(698,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'748B','Laboratoires de développement et de tirage'),(699,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'748D','Conditionnement à façon'),(700,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'748F','Secrétariat et traduction'),(701,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'748G','Routage'),(702,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'748H','Centres d\'appel'),(703,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'748J','Organisation de foires et salons'),(704,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'748K','Services annexes à la production'),(705,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'75','Administration publiques'),(706,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'751A','Administration publique générale'),(707,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'751C','Tutelle des activités sociales'),(708,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'751E','Tutelle des activités économiques'),(709,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'751G','Activités de soutien aux administrations'),(710,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'752A','Affaires étrangères'),(711,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'752C','Défense'),(712,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'752E','Justice'),(713,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'752G','Police'),(714,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'752J','Protection civile'),(715,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'753A','Activités générales de sécurité sociale'),(716,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'753B','Gestion des retraites complémentaires'),(717,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'753C','Distribution sociale de revenus'),(718,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'80','Educations'),(719,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'801Z','Enseignement primaire'),(720,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'802A','Enseignement secondaire général'),(721,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'802C','Enseignement secondaire technique ou professionnel'),(722,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'803Z','Enseignement supérieur'),(723,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'804A','Ecoles de conduite'),(724,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'804C','Formation des adultes et formation continue'),(725,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'804D','Autres enseignements'),(726,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'85','Santé et action sociales'),(727,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'851A','Activités hospitalières'),(728,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'851C','Pratique médicale'),(729,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'851E','Pratique dentaire'),(730,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'851G','Activités des auxiliaires médicaux'),(731,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'851H','Soins hors d\'un cadre règlementé'),(732,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'851J','Ambulances'),(733,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'851K','Laboratoires d\'analyses médicales'),(734,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'851L','Centres de collecte et banques d\'organes'),(735,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'852Z','Activités vétérinaires'),(736,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'853A','Accueil des enfants handicapés'),(737,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'853B','Accueil des enfants en difficulté'),(738,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'853C','Accueil des adultes handicapés'),(739,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'853D','Accueil des personnes âgées'),(740,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'853E','Autres hébergements sociaux'),(741,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'853G','Crèches et garderies d\'enfants'),(742,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'853H','Aide par le travail, ateliers protégés'),(743,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'853J','Aide à domicile'),(744,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'853K','Autres formes d\'action sociale'),(745,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'90','Assainissement, voierie et gestion des déchets'),(746,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'900A','Epuration des eaux usées'),(747,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'900B','Enlèvement et traitement des ordures ménagères'),(748,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'900C','Elimination et traitement des autres déchets'),(749,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'900E','Traitements des autres déchets solides'),(750,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'900G','Autres travaux d\'assainissement et de voirie'),(751,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'91','Activités associatives'),(752,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'911A','Organisations patronales et consulaires'),(753,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'911C','Organisations professionnelles'),(754,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'912Z','Syndicats de salariés'),(755,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'913A','Organisations religieuses'),(756,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'913C','Organisations politiques'),(757,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'913E','Organisations associatives n.c.a.'),(758,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'92','Activités récréatives, culturelles et sportives'),(759,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'921A','Production de films pour la télévision'),(760,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'921B','Production de films institutionnels et publicitaires'),(761,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'921C','Production de films pour le cinéma'),(762,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'921D','Prestations techniques pour le cinéma et la télévision'),(763,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'921F','Distribution de films cinématographiques'),(764,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'921G','Edition et distribution vidéo'),(765,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'921J','Projection de films cinématographiques'),(766,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'922A','Activités de radio'),(767,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'922B','Production de programmes de télévision'),(768,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'922C','Diffusion de programmes de télévision'),(769,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'922D','Edition de chaînes généralistes'),(770,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'922E','Edition de chaînes thématiques'),(771,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'922F','Distribution de bouquets de programmes de radio et de télévision'),(772,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'923A','Activités artistiques'),(773,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'923B','Services annexes aux spectacles'),(774,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'923D','Gestion de salles de spectacle'),(775,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'923F','Manèges forains et parcs d\'attractions'),(776,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'923H','Bals et discothèques'),(777,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'923J','Autres spectacles'),(778,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'923K','Activités diverses du spectacle'),(779,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'924Z','Agences de presse'),(780,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'925A','Gestion des bibliothèques'),(781,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'925C','Gestion du patrimoine culturel'),(782,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'925E','Gestion du patrimoine naturel'),(783,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'926A','Gestion d\'installations sportives'),(784,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'926C','Autres activités sportives'),(785,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'927A','Jeux de hasard et d\'argent'),(786,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'927C','Autres activités récréatives'),(787,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'93','Services personnels'),(788,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'930A','Blanchisserie-teinturerie de gros'),(789,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'930B','Blanchisserie-teinturerie de détail'),(790,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'930D','Coiffure'),(791,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'930E','Soins de beauté'),(792,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'930G','Soins aux défunts'),(793,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'930H','Pompes funèbres'),(794,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'930K','Activités thermales et de thalassothérapie'),(795,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'930L','Autres soins corporels'),(796,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'930N','Autres services personnels'),(797,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'95','Services domestiques'),(798,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'950Z','Services domestiques'),(799,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'960Z','Activités indifférenciées des ménages en tant que producteurs de biens pour usage propre'),(800,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'970Z','Activités indifférenciées des ménages en tant que producteurs de services pour usage propre'),(801,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,1,'99','Activités extra territoriales'),(802,1,'2008-12-17 14:00:32','0000-00-00 00:00:00',NULL,NULL,0,'990Z','Activités extra territoriales');
/*!40000 ALTER TABLE `CompanyNafCode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CompanyType`
--

DROP TABLE IF EXISTS `CompanyType`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `CompanyType` (
  `companytype_id` int(8) NOT NULL auto_increment,
  `companytype_domain_id` int(8) NOT NULL,
  `companytype_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `companytype_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `companytype_userupdate` int(8) default NULL,
  `companytype_usercreate` int(8) default NULL,
  `companytype_code` varchar(10) default '',
  `companytype_label` char(12) default NULL,
  PRIMARY KEY  (`companytype_id`),
  KEY `companytype_domain_id_domain_id_fkey` (`companytype_domain_id`),
  KEY `companytype_userupdate_userobm_id_fkey` (`companytype_userupdate`),
  KEY `companytype_usercreate_userobm_id_fkey` (`companytype_usercreate`),
  CONSTRAINT `companytype_usercreate_userobm_id_fkey` FOREIGN KEY (`companytype_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `companytype_domain_id_domain_id_fkey` FOREIGN KEY (`companytype_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `companytype_userupdate_userobm_id_fkey` FOREIGN KEY (`companytype_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `CompanyType`
--

LOCK TABLES `CompanyType` WRITE;
/*!40000 ALTER TABLE `CompanyType` DISABLE KEYS */;
INSERT INTO `CompanyType` VALUES (1,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'','Client'),(2,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'','Fournisseur'),(3,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'','Partenaire'),(4,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'','Prospect'),(5,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'','Media');
/*!40000 ALTER TABLE `CompanyType` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Contact`
--

DROP TABLE IF EXISTS `Contact`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `Contact` (
  `contact_id` int(8) NOT NULL auto_increment,
  `contact_domain_id` int(8) NOT NULL,
  `contact_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `contact_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `contact_userupdate` int(8) default NULL,
  `contact_usercreate` int(8) default NULL,
  `contact_datasource_id` int(8) default NULL,
  `contact_company_id` int(8) default NULL,
  `contact_company` varchar(64) default NULL,
  `contact_kind_id` int(8) default NULL,
  `contact_marketingmanager_id` int(8) default NULL,
  `contact_lastname` varchar(64) NOT NULL default '',
  `contact_firstname` varchar(64) default NULL,
  `contact_aka` varchar(255) default NULL,
  `contact_sound` varchar(48) default NULL,
  `contact_service` varchar(64) default NULL,
  `contact_function_id` int(8) default NULL,
  `contact_title` varchar(64) default NULL,
  `contact_mailing_ok` char(1) default '0',
  `contact_newsletter` char(1) default '0',
  `contact_archive` char(1) default '0',
  `contact_privacy` int(2) NOT NULL default '0',
  `contact_date` timestamp NOT NULL default '0000-00-00 00:00:00',
  `contact_birthday_id` int(8) default NULL,
  `contact_comment` text,
  `contact_comment2` text,
  `contact_comment3` text,
  `contact_collected` int(1) default '0',
  `contact_origin` varchar(255) NOT NULL,
  PRIMARY KEY  (`contact_id`),
  KEY `contact_domain_id_domain_id_fkey` (`contact_domain_id`),
  KEY `contact_company_id_company_id_fkey` (`contact_company_id`),
  KEY `contact_userupdate_userobm_id_fkey` (`contact_userupdate`),
  KEY `contact_usercreate_userobm_id_fkey` (`contact_usercreate`),
  KEY `contact_datasource_id_datasource_id_fkey` (`contact_datasource_id`),
  KEY `contact_kind_id_kind_id_fkey` (`contact_kind_id`),
  KEY `contact_marketingmanager_id_userobm_id_fkey` (`contact_marketingmanager_id`),
  KEY `contact_function_id_contactfunction_id_fkey` (`contact_function_id`),
  KEY `contact_birthday_id_fkey` (`contact_birthday_id`),
  CONSTRAINT `contact_function_id_contactfunction_id_fkey` FOREIGN KEY (`contact_function_id`) REFERENCES `ContactFunction` (`contactfunction_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `contact_company_id_company_id_fkey` FOREIGN KEY (`contact_company_id`) REFERENCES `Company` (`company_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `contact_datasource_id_datasource_id_fkey` FOREIGN KEY (`contact_datasource_id`) REFERENCES `DataSource` (`datasource_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `contact_domain_id_domain_id_fkey` FOREIGN KEY (`contact_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `contact_kind_id_kind_id_fkey` FOREIGN KEY (`contact_kind_id`) REFERENCES `Kind` (`kind_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `contact_marketingmanager_id_userobm_id_fkey` FOREIGN KEY (`contact_marketingmanager_id`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `contact_usercreate_userobm_id_fkey` FOREIGN KEY (`contact_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `contact_userupdate_userobm_id_fkey` FOREIGN KEY (`contact_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `contact_birthday_id_fkey` FOREIGN KEY (`contact_birthday_id`) REFERENCES `Event` (`event_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `Contact`
--

LOCK TABLES `Contact` WRITE;
/*!40000 ALTER TABLE `Contact` DISABLE KEYS */;
/*!40000 ALTER TABLE `Contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ContactEntity`
--

DROP TABLE IF EXISTS `ContactEntity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ContactEntity` (
  `contactentity_entity_id` int(8) NOT NULL,
  `contactentity_contact_id` int(8) NOT NULL,
  PRIMARY KEY  (`contactentity_entity_id`,`contactentity_contact_id`),
  KEY `contactentity_contact_id_contact_id_fkey` (`contactentity_contact_id`),
  CONSTRAINT `contactentity_contact_id_contact_id_fkey` FOREIGN KEY (`contactentity_contact_id`) REFERENCES `Contact` (`contact_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `contactentity_entity_id_entity_id_fkey` FOREIGN KEY (`contactentity_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ContactEntity`
--

LOCK TABLES `ContactEntity` WRITE;
/*!40000 ALTER TABLE `ContactEntity` DISABLE KEYS */;
/*!40000 ALTER TABLE `ContactEntity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ContactFunction`
--

DROP TABLE IF EXISTS `ContactFunction`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ContactFunction` (
  `contactfunction_id` int(8) NOT NULL auto_increment,
  `contactfunction_domain_id` int(8) NOT NULL,
  `contactfunction_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `contactfunction_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `contactfunction_userupdate` int(8) default NULL,
  `contactfunction_usercreate` int(8) default NULL,
  `contactfunction_code` varchar(10) default '',
  `contactfunction_label` varchar(64) default NULL,
  PRIMARY KEY  (`contactfunction_id`),
  KEY `contactfunction_domain_id_domain_id_fkey` (`contactfunction_domain_id`),
  KEY `contactfunction_userupdate_userobm_id_fkey` (`contactfunction_userupdate`),
  KEY `contactfunction_usercreate_userobm_id_fkey` (`contactfunction_usercreate`),
  CONSTRAINT `contactfunction_usercreate_userobm_id_fkey` FOREIGN KEY (`contactfunction_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `contactfunction_domain_id_domain_id_fkey` FOREIGN KEY (`contactfunction_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `contactfunction_userupdate_userobm_id_fkey` FOREIGN KEY (`contactfunction_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ContactFunction`
--

LOCK TABLES `ContactFunction` WRITE;
/*!40000 ALTER TABLE `ContactFunction` DISABLE KEYS */;
/*!40000 ALTER TABLE `ContactFunction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ContactList`
--

DROP TABLE IF EXISTS `ContactList`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ContactList` (
  `contactlist_list_id` int(8) NOT NULL,
  `contactlist_contact_id` int(8) NOT NULL,
  KEY `contactlist_list_id_list_id_fkey` (`contactlist_list_id`),
  KEY `contactlist_contact_id_contact_id_fkey` (`contactlist_contact_id`),
  CONSTRAINT `contactlist_contact_id_contact_id_fkey` FOREIGN KEY (`contactlist_contact_id`) REFERENCES `Contact` (`contact_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `contactlist_list_id_list_id_fkey` FOREIGN KEY (`contactlist_list_id`) REFERENCES `List` (`list_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ContactList`
--

LOCK TABLES `ContactList` WRITE;
/*!40000 ALTER TABLE `ContactList` DISABLE KEYS */;
/*!40000 ALTER TABLE `ContactList` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Contract`
--

DROP TABLE IF EXISTS `Contract`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `Contract` (
  `contract_id` int(8) NOT NULL auto_increment,
  `contract_domain_id` int(8) NOT NULL,
  `contract_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `contract_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `contract_userupdate` int(8) default NULL,
  `contract_usercreate` int(8) default NULL,
  `contract_deal_id` int(8) default NULL,
  `contract_company_id` int(8) default NULL,
  `contract_label` varchar(128) default NULL,
  `contract_number` varchar(20) default NULL,
  `contract_datesignature` date default NULL,
  `contract_datebegin` date default NULL,
  `contract_dateexp` date default NULL,
  `contract_daterenew` date default NULL,
  `contract_datecancel` date default NULL,
  `contract_type_id` int(8) default NULL,
  `contract_priority_id` int(8) default NULL,
  `contract_status_id` int(8) default NULL,
  `contract_kind` int(2) default NULL,
  `contract_format` int(2) default NULL,
  `contract_ticketnumber` int(8) default NULL,
  `contract_duration` int(8) default NULL,
  `contract_autorenewal` int(2) default NULL,
  `contract_contact1_id` int(8) default NULL,
  `contract_contact2_id` int(8) default NULL,
  `contract_techmanager_id` int(8) default NULL,
  `contract_marketmanager_id` int(8) default NULL,
  `contract_privacy` int(2) default '0',
  `contract_archive` int(1) default '0',
  `contract_clause` text,
  `contract_comment` text,
  PRIMARY KEY  (`contract_id`),
  KEY `contract_domain_id_domain_id_fkey` (`contract_domain_id`),
  KEY `contract_deal_id_deal_id_fkey` (`contract_deal_id`),
  KEY `contract_company_id_company_id_fkey` (`contract_company_id`),
  KEY `contract_userupdate_userobm_id_fkey` (`contract_userupdate`),
  KEY `contract_usercreate_userobm_id_fkey` (`contract_usercreate`),
  KEY `contract_type_id_contracttype_id_fkey` (`contract_type_id`),
  KEY `contract_priority_id_contractpriority_id_fkey` (`contract_priority_id`),
  KEY `contract_status_id_contractstatus_id_fkey` (`contract_status_id`),
  KEY `contract_contact1_id_contact_id_fkey` (`contract_contact1_id`),
  KEY `contract_contact2_id_contact_id_fkey` (`contract_contact2_id`),
  KEY `contract_techmanager_id_userobm_id_fkey` (`contract_techmanager_id`),
  KEY `contract_marketmanager_id_userobm_id_fkey` (`contract_marketmanager_id`),
  CONSTRAINT `contract_marketmanager_id_userobm_id_fkey` FOREIGN KEY (`contract_marketmanager_id`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `contract_company_id_company_id_fkey` FOREIGN KEY (`contract_company_id`) REFERENCES `Company` (`company_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `contract_contact1_id_contact_id_fkey` FOREIGN KEY (`contract_contact1_id`) REFERENCES `Contact` (`contact_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `contract_contact2_id_contact_id_fkey` FOREIGN KEY (`contract_contact2_id`) REFERENCES `Contact` (`contact_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `contract_deal_id_deal_id_fkey` FOREIGN KEY (`contract_deal_id`) REFERENCES `Deal` (`deal_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `contract_domain_id_domain_id_fkey` FOREIGN KEY (`contract_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `contract_priority_id_contractpriority_id_fkey` FOREIGN KEY (`contract_priority_id`) REFERENCES `ContractPriority` (`contractpriority_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `contract_status_id_contractstatus_id_fkey` FOREIGN KEY (`contract_status_id`) REFERENCES `ContractStatus` (`contractstatus_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `contract_techmanager_id_userobm_id_fkey` FOREIGN KEY (`contract_techmanager_id`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `contract_type_id_contracttype_id_fkey` FOREIGN KEY (`contract_type_id`) REFERENCES `ContractType` (`contracttype_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `contract_usercreate_userobm_id_fkey` FOREIGN KEY (`contract_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `contract_userupdate_userobm_id_fkey` FOREIGN KEY (`contract_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `Contract`
--

LOCK TABLES `Contract` WRITE;
/*!40000 ALTER TABLE `Contract` DISABLE KEYS */;
/*!40000 ALTER TABLE `Contract` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ContractEntity`
--

DROP TABLE IF EXISTS `ContractEntity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ContractEntity` (
  `contractentity_entity_id` int(8) NOT NULL,
  `contractentity_contract_id` int(8) NOT NULL,
  PRIMARY KEY  (`contractentity_entity_id`,`contractentity_contract_id`),
  KEY `contractentity_contract_id_contract_id_fkey` (`contractentity_contract_id`),
  CONSTRAINT `contractentity_contract_id_contract_id_fkey` FOREIGN KEY (`contractentity_contract_id`) REFERENCES `Contract` (`contract_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `contractentity_entity_id_entity_id_fkey` FOREIGN KEY (`contractentity_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ContractEntity`
--

LOCK TABLES `ContractEntity` WRITE;
/*!40000 ALTER TABLE `ContractEntity` DISABLE KEYS */;
/*!40000 ALTER TABLE `ContractEntity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ContractPriority`
--

DROP TABLE IF EXISTS `ContractPriority`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ContractPriority` (
  `contractpriority_id` int(8) NOT NULL auto_increment,
  `contractpriority_domain_id` int(8) NOT NULL,
  `contractpriority_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `contractpriority_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `contractpriority_userupdate` int(8) default NULL,
  `contractpriority_usercreate` int(8) default NULL,
  `contractpriority_code` varchar(10) default '',
  `contractpriority_color` varchar(6) default NULL,
  `contractpriority_label` varchar(64) default NULL,
  PRIMARY KEY  (`contractpriority_id`),
  KEY `contractpriority_domain_id_domain_id_fkey` (`contractpriority_domain_id`),
  KEY `contractpriority_userupdate_userobm_id_fkey` (`contractpriority_userupdate`),
  KEY `contractpriority_usercreate_userobm_id_fkey` (`contractpriority_usercreate`),
  CONSTRAINT `contractpriority_usercreate_userobm_id_fkey` FOREIGN KEY (`contractpriority_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `contractpriority_domain_id_domain_id_fkey` FOREIGN KEY (`contractpriority_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `contractpriority_userupdate_userobm_id_fkey` FOREIGN KEY (`contractpriority_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ContractPriority`
--

LOCK TABLES `ContractPriority` WRITE;
/*!40000 ALTER TABLE `ContractPriority` DISABLE KEYS */;
INSERT INTO `ContractPriority` VALUES (1,1,'2008-12-17 14:00:31','0000-00-00 00:00:00',NULL,NULL,'1','FF0000','Haute'),(2,1,'2008-12-17 14:00:31','0000-00-00 00:00:00',NULL,NULL,'2','FFA0A0','Normale'),(3,1,'2008-12-17 14:00:31','0000-00-00 00:00:00',NULL,NULL,'3','FFF0F0','Faible');
/*!40000 ALTER TABLE `ContractPriority` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ContractStatus`
--

DROP TABLE IF EXISTS `ContractStatus`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ContractStatus` (
  `contractstatus_id` int(8) NOT NULL auto_increment,
  `contractstatus_domain_id` int(8) NOT NULL,
  `contractstatus_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `contractstatus_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `contractstatus_userupdate` int(8) default NULL,
  `contractstatus_usercreate` int(8) default NULL,
  `contractstatus_code` varchar(10) default '',
  `contractstatus_label` varchar(64) default NULL,
  PRIMARY KEY  (`contractstatus_id`),
  KEY `contractstatus_domain_id_domain_id_fkey` (`contractstatus_domain_id`),
  KEY `contractstatus_userupdate_userobm_id_fkey` (`contractstatus_userupdate`),
  KEY `contractstatus_usercreate_userobm_id_fkey` (`contractstatus_usercreate`),
  CONSTRAINT `contractstatus_usercreate_userobm_id_fkey` FOREIGN KEY (`contractstatus_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `contractstatus_domain_id_domain_id_fkey` FOREIGN KEY (`contractstatus_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `contractstatus_userupdate_userobm_id_fkey` FOREIGN KEY (`contractstatus_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ContractStatus`
--

LOCK TABLES `ContractStatus` WRITE;
/*!40000 ALTER TABLE `ContractStatus` DISABLE KEYS */;
INSERT INTO `ContractStatus` VALUES (1,1,'2008-12-17 14:00:31','0000-00-00 00:00:00',NULL,NULL,'1','En cours'),(2,1,'2008-12-17 14:00:31','0000-00-00 00:00:00',NULL,NULL,'2','Clos');
/*!40000 ALTER TABLE `ContractStatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ContractType`
--

DROP TABLE IF EXISTS `ContractType`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ContractType` (
  `contracttype_id` int(8) NOT NULL auto_increment,
  `contracttype_domain_id` int(8) NOT NULL,
  `contracttype_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `contracttype_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `contracttype_userupdate` int(8) default NULL,
  `contracttype_usercreate` int(8) default NULL,
  `contracttype_code` varchar(10) default '',
  `contracttype_label` varchar(64) default NULL,
  PRIMARY KEY  (`contracttype_id`),
  KEY `contracttype_domain_id_domain_id_fkey` (`contracttype_domain_id`),
  KEY `contracttype_userupdate_userobm_id_fkey` (`contracttype_userupdate`),
  KEY `contracttype_usercreate_userobm_id_fkey` (`contracttype_usercreate`),
  CONSTRAINT `contracttype_usercreate_userobm_id_fkey` FOREIGN KEY (`contracttype_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `contracttype_domain_id_domain_id_fkey` FOREIGN KEY (`contracttype_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `contracttype_userupdate_userobm_id_fkey` FOREIGN KEY (`contracttype_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ContractType`
--

LOCK TABLES `ContractType` WRITE;
/*!40000 ALTER TABLE `ContractType` DISABLE KEYS */;
/*!40000 ALTER TABLE `ContractType` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Country`
--

DROP TABLE IF EXISTS `Country`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `Country` (
  `country_domain_id` int(8) NOT NULL,
  `country_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `country_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `country_userupdate` int(8) default NULL,
  `country_usercreate` int(8) default NULL,
  `country_iso3166` char(2) NOT NULL,
  `country_name` varchar(64) default NULL,
  `country_lang` char(2) NOT NULL,
  `country_phone` varchar(4) default NULL,
  PRIMARY KEY  (`country_iso3166`,`country_lang`),
  KEY `country_domain_id_domain_id_fkey` (`country_domain_id`),
  KEY `country_userupdate_userobm_id_fkey` (`country_userupdate`),
  KEY `country_usercreate_userobm_id_fkey` (`country_usercreate`),
  CONSTRAINT `country_usercreate_userobm_id_fkey` FOREIGN KEY (`country_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `country_domain_id_domain_id_fkey` FOREIGN KEY (`country_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `country_userupdate_userobm_id_fkey` FOREIGN KEY (`country_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `Country`
--

LOCK TABLES `Country` WRITE;
/*!40000 ALTER TABLE `Country` DISABLE KEYS */;
INSERT INTO `Country` VALUES (1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'AD','Andorre','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'AE','Emirats Arabes Unis','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'AL','Albanie','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'AM','Arménie','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'AO','Angola','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'AR','Argentine','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'AT','Autriche','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'AU','Australie','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'AZ','Azerbaidjan','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'BA','Bosnie-Herzégovine','FR','+387'),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'BB','La Barbade','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'BD','Bangladesh','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'BE','Belgique','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'BF','Burkina Faso','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'BG','Bulgarie','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'BJ','Benin','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'BO','Bolivie','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'BR','Brésil','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'BS','Bahamas','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'BY','Bielorussie','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'CA','Canada','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'CF','Rép. Centraficaine','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'CG','Congo','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'CH','Suisse','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'CI','Rep. Côte D\'ivoire','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'CL','Chili','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'CM','Cameroun','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'CN','Chine','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'CO','Colombie','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'CR','Costa Rica','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'CS','Serbie-Monténégro','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'CU','Cuba','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'CY','Chypre','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'CZ','Rep.Tchèque','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'DE','Allemagne','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'DK','Danemark','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'DZ','Algérie','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'EC','Equateur','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'EE','Estonie','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'EG','Egypte','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'ES','Espagne','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'FI','Finlande','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'FR','France','EN','+33'),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'FR','France','FR','+33'),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'GA','Gabon','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'GB','Royaume Uni','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'GE','Georgie','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'GH','Ghana','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'GI','Gibraltar','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'GL','Groenland','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'GN','Guinée','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'GR','Grèce','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'GT','Guatemala','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'HK','Hong Kong','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'HR','Croatie','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'HU','Hongrie','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'ID','Indonésie','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'IE','Irlande','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'IL','Israel','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'IN','Inde','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'IQ','Irak','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'IR','Iran','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'IS','Islande','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'IT','Italie','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'JM','Jamaique','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'JO','Jordanie','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'JP','Japon','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'KE','Kenya','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'KP','Corée du Nord','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'KR','Corée du Sud','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'KW','Koweit','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'KZ','Kazakhstan','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'LB','Liban','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'LI','Liechtenstein','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'LK','Sri Lanka','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'LT','Lituanie','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'LU','Luxembourg','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'LV','Lettonie','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'LY','Libye','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'MA','Maroc','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'MC','Monaco','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'MD','Moldova','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'MG','Madagascar','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'MK','« L\'ex République Yougoslave de Macedoine »','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'ML','Mali','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'MT','Malte','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'MU','Mauritius','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'MW','Malawi','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'MX','Mexique','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'MY','Malaisie','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'NA','Namibie','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'NE','Nigeria','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'NI','Nicaragua','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'NL','Pays Bas','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'NO','Norvège','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'NP','Népal','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'NZ','Nouvelle Zélande','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'OM','Oman','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'PE','Pérou','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'PF','Polynésie Française','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'PH','Phillipines','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'PK','Pakistan','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'PL','Pologne','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'PR','Porto Rico','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'PT','Portugal','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'PY','Paraguay','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'RO','Roumanie','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'RU','Russie','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'SA','Arabie Saoudite','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'SE','Suède','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'SG','Singapour','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'SI','Slovenie','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'SK','Slovaquie','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'SM','San Marino','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'SN','Sénégal','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'SY','Syrie','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'TG','Togo','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'TH','Thailande','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'TN','Tunisie','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'TR','Turquie','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'TT','Trinité & Tobago','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'TW','Taiwan','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'UA','Ukraine','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'US','USA','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'UY','Uruguay','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'VA','Saint-Siège','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'VE','Vénézuela','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'VN','Vietnam','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'ZA','Afriq. Sud','FR',''),(1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'ZW','Zimbabwe','FR','');
/*!40000 ALTER TABLE `Country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CvEntity`
--

DROP TABLE IF EXISTS `CvEntity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `CvEntity` (
  `cventity_entity_id` int(8) NOT NULL,
  `cventity_cv_id` int(8) NOT NULL,
  PRIMARY KEY  (`cventity_entity_id`,`cventity_cv_id`),
  KEY `cventity_cv_id_cv_id_fkey` (`cventity_cv_id`),
  CONSTRAINT `cventity_cv_id_cv_id_fkey` FOREIGN KEY (`cventity_cv_id`) REFERENCES `CV` (`cv_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cventity_entity_id_entity_id_fkey` FOREIGN KEY (`cventity_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `CvEntity`
--

LOCK TABLES `CvEntity` WRITE;
/*!40000 ALTER TABLE `CvEntity` DISABLE KEYS */;
/*!40000 ALTER TABLE `CvEntity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DataSource`
--

DROP TABLE IF EXISTS `DataSource`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `DataSource` (
  `datasource_id` int(8) NOT NULL auto_increment,
  `datasource_domain_id` int(8) NOT NULL,
  `datasource_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `datasource_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `datasource_userupdate` int(8) default NULL,
  `datasource_usercreate` int(8) default NULL,
  `datasource_name` varchar(64) default NULL,
  PRIMARY KEY  (`datasource_id`),
  KEY `datasource_domain_id_domain_id_fkey` (`datasource_domain_id`),
  KEY `datasource_userupdate_userobm_id_fkey` (`datasource_userupdate`),
  KEY `datasource_usercreate_userobm_id_fkey` (`datasource_usercreate`),
  CONSTRAINT `datasource_usercreate_userobm_id_fkey` FOREIGN KEY (`datasource_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `datasource_domain_id_domain_id_fkey` FOREIGN KEY (`datasource_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `datasource_userupdate_userobm_id_fkey` FOREIGN KEY (`datasource_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `DataSource`
--

LOCK TABLES `DataSource` WRITE;
/*!40000 ALTER TABLE `DataSource` DISABLE KEYS */;
/*!40000 ALTER TABLE `DataSource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Deal`
--

DROP TABLE IF EXISTS `Deal`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `Deal` (
  `deal_id` int(8) NOT NULL auto_increment,
  `deal_domain_id` int(8) NOT NULL,
  `deal_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `deal_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `deal_userupdate` int(8) default NULL,
  `deal_usercreate` int(8) default NULL,
  `deal_number` varchar(32) default NULL,
  `deal_label` varchar(128) default NULL,
  `deal_datebegin` date default NULL,
  `deal_parentdeal_id` int(8) default NULL,
  `deal_type_id` int(8) default NULL,
  `deal_region_id` int(8) default NULL,
  `deal_tasktype_id` int(8) default NULL,
  `deal_company_id` int(8) NOT NULL,
  `deal_contact1_id` int(8) default NULL,
  `deal_contact2_id` int(8) default NULL,
  `deal_marketingmanager_id` int(8) default NULL,
  `deal_technicalmanager_id` int(8) default NULL,
  `deal_source_id` int(8) default NULL,
  `deal_source` varchar(64) default NULL,
  `deal_dateproposal` date default NULL,
  `deal_dateexpected` date default NULL,
  `deal_datealarm` date default NULL,
  `deal_dateend` date default NULL,
  `deal_amount` decimal(12,2) default NULL,
  `deal_margin` decimal(12,2) default NULL,
  `deal_commission` decimal(5,2) default '0.00',
  `deal_hitrate` int(3) default '0',
  `deal_status_id` int(2) default NULL,
  `deal_archive` char(1) default '0',
  `deal_todo` varchar(128) default NULL,
  `deal_privacy` int(2) NOT NULL default '0',
  `deal_comment` text,
  PRIMARY KEY  (`deal_id`),
  KEY `deal_domain_id_domain_id_fkey` (`deal_domain_id`),
  KEY `deal_parentdeal_id_parentdeal_id_fkey` (`deal_parentdeal_id`),
  KEY `deal_company_id_company_id_fkey` (`deal_company_id`),
  KEY `deal_userupdate_userobm_id_fkey` (`deal_userupdate`),
  KEY `deal_usercreate_userobm_id_fkey` (`deal_usercreate`),
  KEY `deal_type_id_dealtype_id_fkey` (`deal_type_id`),
  KEY `deal_region_id_region_id_fkey` (`deal_region_id`),
  KEY `deal_tasktype_id_tasktype_id_fkey` (`deal_tasktype_id`),
  KEY `deal_contact1_id_contact_id_fkey` (`deal_contact1_id`),
  KEY `deal_contact2_id_contact_id_fkey` (`deal_contact2_id`),
  KEY `deal_marketingmanager_id_userobm_id_fkey` (`deal_marketingmanager_id`),
  KEY `deal_technicalmanager_id_userobm_id_fkey` (`deal_technicalmanager_id`),
  KEY `deal_source_id_leadsource_id_fkey` (`deal_source_id`),
  CONSTRAINT `deal_source_id_leadsource_id_fkey` FOREIGN KEY (`deal_source_id`) REFERENCES `LeadSource` (`leadsource_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `deal_company_id_company_id_fkey` FOREIGN KEY (`deal_company_id`) REFERENCES `Company` (`company_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `deal_contact1_id_contact_id_fkey` FOREIGN KEY (`deal_contact1_id`) REFERENCES `Contact` (`contact_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `deal_contact2_id_contact_id_fkey` FOREIGN KEY (`deal_contact2_id`) REFERENCES `Contact` (`contact_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `deal_domain_id_domain_id_fkey` FOREIGN KEY (`deal_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `deal_marketingmanager_id_userobm_id_fkey` FOREIGN KEY (`deal_marketingmanager_id`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `deal_parentdeal_id_parentdeal_id_fkey` FOREIGN KEY (`deal_parentdeal_id`) REFERENCES `ParentDeal` (`parentdeal_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `deal_region_id_region_id_fkey` FOREIGN KEY (`deal_region_id`) REFERENCES `Region` (`region_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `deal_tasktype_id_tasktype_id_fkey` FOREIGN KEY (`deal_tasktype_id`) REFERENCES `TaskType` (`tasktype_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `deal_technicalmanager_id_userobm_id_fkey` FOREIGN KEY (`deal_technicalmanager_id`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `deal_type_id_dealtype_id_fkey` FOREIGN KEY (`deal_type_id`) REFERENCES `DealType` (`dealtype_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `deal_usercreate_userobm_id_fkey` FOREIGN KEY (`deal_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `deal_userupdate_userobm_id_fkey` FOREIGN KEY (`deal_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `Deal`
--

LOCK TABLES `Deal` WRITE;
/*!40000 ALTER TABLE `Deal` DISABLE KEYS */;
/*!40000 ALTER TABLE `Deal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DealCompany`
--

DROP TABLE IF EXISTS `DealCompany`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `DealCompany` (
  `dealcompany_id` int(8) NOT NULL auto_increment,
  `dealcompany_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `dealcompany_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `dealcompany_userupdate` int(8) default NULL,
  `dealcompany_usercreate` int(8) default NULL,
  `dealcompany_deal_id` int(8) NOT NULL,
  `dealcompany_company_id` int(8) NOT NULL,
  `dealcompany_role_id` int(8) default NULL,
  PRIMARY KEY  (`dealcompany_id`),
  KEY `dealcompany_idx_deal` (`dealcompany_deal_id`),
  KEY `dealcompany_company_id_company_id_fkey` (`dealcompany_company_id`),
  KEY `dealcompany_role_id_dealcompanyrole_id_fkey` (`dealcompany_role_id`),
  KEY `dealcompany_userupdate_userobm_id_fkey` (`dealcompany_userupdate`),
  KEY `dealcompany_usercreate_userobm_id_fkey` (`dealcompany_usercreate`),
  CONSTRAINT `dealcompany_usercreate_userobm_id_fkey` FOREIGN KEY (`dealcompany_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `dealcompany_company_id_company_id_fkey` FOREIGN KEY (`dealcompany_company_id`) REFERENCES `Company` (`company_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `dealcompany_deal_id_deal_id_fkey` FOREIGN KEY (`dealcompany_deal_id`) REFERENCES `Deal` (`deal_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `dealcompany_role_id_dealcompanyrole_id_fkey` FOREIGN KEY (`dealcompany_role_id`) REFERENCES `DealCompanyRole` (`dealcompanyrole_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `dealcompany_userupdate_userobm_id_fkey` FOREIGN KEY (`dealcompany_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `DealCompany`
--

LOCK TABLES `DealCompany` WRITE;
/*!40000 ALTER TABLE `DealCompany` DISABLE KEYS */;
/*!40000 ALTER TABLE `DealCompany` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DealCompanyRole`
--

DROP TABLE IF EXISTS `DealCompanyRole`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `DealCompanyRole` (
  `dealcompanyrole_id` int(8) NOT NULL auto_increment,
  `dealcompanyrole_domain_id` int(8) NOT NULL,
  `dealcompanyrole_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `dealcompanyrole_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `dealcompanyrole_userupdate` int(8) default NULL,
  `dealcompanyrole_usercreate` int(8) default NULL,
  `dealcompanyrole_code` varchar(10) default '',
  `dealcompanyrole_label` varchar(64) NOT NULL default '',
  PRIMARY KEY  (`dealcompanyrole_id`),
  KEY `dealcompanyrole_domain_id_domain_id_fkey` (`dealcompanyrole_domain_id`),
  KEY `dealcompanyrole_userupdate_userobm_id_fkey` (`dealcompanyrole_userupdate`),
  KEY `dealcompanyrole_usercreate_userobm_id_fkey` (`dealcompanyrole_usercreate`),
  CONSTRAINT `dealcompanyrole_usercreate_userobm_id_fkey` FOREIGN KEY (`dealcompanyrole_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `dealcompanyrole_domain_id_domain_id_fkey` FOREIGN KEY (`dealcompanyrole_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `dealcompanyrole_userupdate_userobm_id_fkey` FOREIGN KEY (`dealcompanyrole_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `DealCompanyRole`
--

LOCK TABLES `DealCompanyRole` WRITE;
/*!40000 ALTER TABLE `DealCompanyRole` DISABLE KEYS */;
/*!40000 ALTER TABLE `DealCompanyRole` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DealEntity`
--

DROP TABLE IF EXISTS `DealEntity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `DealEntity` (
  `dealentity_entity_id` int(8) NOT NULL,
  `dealentity_deal_id` int(8) NOT NULL,
  PRIMARY KEY  (`dealentity_entity_id`,`dealentity_deal_id`),
  KEY `dealentity_deal_id_deal_id_fkey` (`dealentity_deal_id`),
  CONSTRAINT `dealentity_deal_id_deal_id_fkey` FOREIGN KEY (`dealentity_deal_id`) REFERENCES `Deal` (`deal_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `dealentity_entity_id_entity_id_fkey` FOREIGN KEY (`dealentity_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `DealEntity`
--

LOCK TABLES `DealEntity` WRITE;
/*!40000 ALTER TABLE `DealEntity` DISABLE KEYS */;
/*!40000 ALTER TABLE `DealEntity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DealStatus`
--

DROP TABLE IF EXISTS `DealStatus`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `DealStatus` (
  `dealstatus_id` int(2) NOT NULL auto_increment,
  `dealstatus_domain_id` int(8) NOT NULL,
  `dealstatus_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `dealstatus_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `dealstatus_userupdate` int(8) default NULL,
  `dealstatus_usercreate` int(8) default NULL,
  `dealstatus_label` varchar(24) default NULL,
  `dealstatus_order` int(2) default NULL,
  `dealstatus_hitrate` char(3) default NULL,
  PRIMARY KEY  (`dealstatus_id`),
  KEY `dealstatus_domain_id_domain_id_fkey` (`dealstatus_domain_id`),
  KEY `dealstatus_userupdate_userobm_id_fkey` (`dealstatus_userupdate`),
  KEY `dealstatus_usercreate_userobm_id_fkey` (`dealstatus_usercreate`),
  CONSTRAINT `dealstatus_usercreate_userobm_id_fkey` FOREIGN KEY (`dealstatus_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `dealstatus_domain_id_domain_id_fkey` FOREIGN KEY (`dealstatus_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `dealstatus_userupdate_userobm_id_fkey` FOREIGN KEY (`dealstatus_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `DealStatus`
--

LOCK TABLES `DealStatus` WRITE;
/*!40000 ALTER TABLE `DealStatus` DISABLE KEYS */;
INSERT INTO `DealStatus` VALUES (1,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'CONTACT',1,NULL),(2,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'RDV',2,NULL),(3,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'Attente de Proposition.',3,NULL),(4,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'PROPOSITION',4,NULL),(5,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'SIGNEE',5,'100'),(6,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'REALISEE',6,'100'),(7,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'FACTUREE',7,'100'),(8,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'PAYEE',8,'100'),(9,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'PERDUE',9,'0'),(10,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'SANS SUITE',10,'0');
/*!40000 ALTER TABLE `DealStatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DealType`
--

DROP TABLE IF EXISTS `DealType`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `DealType` (
  `dealtype_id` int(8) NOT NULL auto_increment,
  `dealtype_domain_id` int(8) NOT NULL,
  `dealtype_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `dealtype_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `dealtype_userupdate` int(8) default NULL,
  `dealtype_usercreate` int(8) default NULL,
  `dealtype_inout` varchar(1) default '-',
  `dealtype_code` varchar(10) default NULL,
  `dealtype_label` varchar(16) default NULL,
  PRIMARY KEY  (`dealtype_id`),
  KEY `dealtype_domain_id_domain_id_fkey` (`dealtype_domain_id`),
  KEY `dealtype_userupdate_userobm_id_fkey` (`dealtype_userupdate`),
  KEY `dealtype_usercreate_userobm_id_fkey` (`dealtype_usercreate`),
  CONSTRAINT `dealtype_usercreate_userobm_id_fkey` FOREIGN KEY (`dealtype_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `dealtype_domain_id_domain_id_fkey` FOREIGN KEY (`dealtype_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `dealtype_userupdate_userobm_id_fkey` FOREIGN KEY (`dealtype_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `DealType`
--

LOCK TABLES `DealType` WRITE;
/*!40000 ALTER TABLE `DealType` DISABLE KEYS */;
INSERT INTO `DealType` VALUES (1,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'+',NULL,'VENTE'),(2,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'-',NULL,'ACHAT'),(3,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'-',NULL,'MEDIA'),(4,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'-',NULL,'SOCIAL'),(5,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'-',NULL,'JURIDIQUE');
/*!40000 ALTER TABLE `DealType` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DefaultOdtTemplate`
--

DROP TABLE IF EXISTS `DefaultOdtTemplate`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `DefaultOdtTemplate` (
  `defaultodttemplate_id` int(8) NOT NULL auto_increment,
  `defaultodttemplate_domain_id` int(8) NOT NULL,
  `defaultodttemplate_entity` varchar(32) default NULL,
  `defaultodttemplate_document_id` int(8) NOT NULL,
  `defaultodttemplate_label` varchar(64) default '',
  PRIMARY KEY  (`defaultodttemplate_id`),
  KEY `defaultodttemplate_domain_id_domain_id_fkey` (`defaultodttemplate_domain_id`),
  KEY `defaultodttemplate_document_id_document_id_fkey` (`defaultodttemplate_document_id`),
  CONSTRAINT `defaultodttemplate_document_id_document_id_fkey` FOREIGN KEY (`defaultodttemplate_document_id`) REFERENCES `Document` (`document_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `defaultodttemplate_domain_id_domain_id_fkey` FOREIGN KEY (`defaultodttemplate_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `DefaultOdtTemplate`
--

LOCK TABLES `DefaultOdtTemplate` WRITE;
/*!40000 ALTER TABLE `DefaultOdtTemplate` DISABLE KEYS */;
/*!40000 ALTER TABLE `DefaultOdtTemplate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Deleted`
--

DROP TABLE IF EXISTS `Deleted`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `Deleted` (
  `deleted_id` int(8) NOT NULL auto_increment,
  `deleted_domain_id` int(8) default NULL,
  `deleted_user_id` int(8) default NULL,
  `deleted_delegation` varchar(64) default '',
  `deleted_table` varchar(32) default NULL,
  `deleted_entity_id` int(8) default NULL,
  `deleted_timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`deleted_id`),
  KEY `deleted_user_id_userobm_id_fkey` (`deleted_user_id`),
  KEY `deleted_domain_id_domain_id_fkey` (`deleted_domain_id`),
  CONSTRAINT `deleted_domain_id_domain_id_fkey` FOREIGN KEY (`deleted_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `deleted_user_id_userobm_id_fkey` FOREIGN KEY (`deleted_user_id`) REFERENCES `UserObm` (`userobm_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `Deleted`
--

LOCK TABLES `Deleted` WRITE;
/*!40000 ALTER TABLE `Deleted` DISABLE KEYS */;
/*!40000 ALTER TABLE `Deleted` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DeletedContact`
--

DROP TABLE IF EXISTS `DeletedContact`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `DeletedContact` (
  `deletedcontact_contact_id` int(8) NOT NULL,
  `deletedcontact_user_id` int(8) NOT NULL,
  `deletedcontact_timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `deletedcontact_origin` varchar(255) NOT NULL,
  PRIMARY KEY  (`deletedcontact_contact_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `DeletedContact`
--

LOCK TABLES `DeletedContact` WRITE;
/*!40000 ALTER TABLE `DeletedContact` DISABLE KEYS */;
/*!40000 ALTER TABLE `DeletedContact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DeletedEvent`
--

DROP TABLE IF EXISTS `DeletedEvent`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `DeletedEvent` (
  `deletedevent_id` int(8) NOT NULL auto_increment,
  `deletedevent_event_id` int(8) default NULL,
  `deletedevent_user_id` int(8) default NULL,
  `deletedevent_origin` varchar(255) NOT NULL,
  `deletedevent_type` enum('VEVENT','VTODO','VJOURNAL','VFREEBUSY') default 'VEVENT',
  `deletedevent_timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`deletedevent_id`),
  KEY `idx_dce_event` (`deletedevent_event_id`),
  KEY `idx_dce_user` (`deletedevent_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `DeletedEvent`
--

LOCK TABLES `DeletedEvent` WRITE;
/*!40000 ALTER TABLE `DeletedEvent` DISABLE KEYS */;
/*!40000 ALTER TABLE `DeletedEvent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DeletedUser`
--

DROP TABLE IF EXISTS `DeletedUser`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `DeletedUser` (
  `deleteduser_user_id` int(8) NOT NULL,
  `deleteduser_timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`deleteduser_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `DeletedUser`
--

LOCK TABLES `DeletedUser` WRITE;
/*!40000 ALTER TABLE `DeletedUser` DISABLE KEYS */;
/*!40000 ALTER TABLE `DeletedUser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DisplayPref`
--

DROP TABLE IF EXISTS `DisplayPref`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `DisplayPref` (
  `display_id` int(8) NOT NULL auto_increment,
  `display_user_id` int(8) default NULL,
  `display_entity` varchar(32) NOT NULL default '',
  `display_fieldname` varchar(64) NOT NULL default '',
  `display_fieldorder` int(3) unsigned default NULL,
  `display_display` int(1) unsigned NOT NULL default '1',
  PRIMARY KEY  (`display_id`),
  UNIQUE KEY `displaypref_key` (`display_user_id`,`display_entity`,`display_fieldname`),
  KEY `idx_user` (`display_user_id`),
  KEY `idx_entity` (`display_entity`),
  CONSTRAINT `display_user_id_userobm_id_fkey` FOREIGN KEY (`display_user_id`) REFERENCES `UserObm` (`userobm_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=325 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `DisplayPref`
--

LOCK TABLES `DisplayPref` WRITE;
/*!40000 ALTER TABLE `DisplayPref` DISABLE KEYS */;
INSERT INTO `DisplayPref` VALUES (1,NULL,'company','company_name',1,2),(2,NULL,'company','company_aka',2,0),(3,NULL,'company','company_archive',3,1),(4,NULL,'company','company_contact_number',4,1),(5,NULL,'company','company_new_contact',5,1),(6,NULL,'company','company_deal_number',6,1),(7,NULL,'company','company_number',7,1),(8,NULL,'company','company_vat',8,1),(9,NULL,'company','company_siret',9,1),(10,NULL,'company','type_label',10,1),(11,NULL,'company','activity_label',11,1),(12,NULL,'company','nafcode_code',12,1),(13,NULL,'company','company_address',13,1),(14,NULL,'company','address_street',14,0),(15,NULL,'company','address_zipcode',15,0),(16,NULL,'company','address_town',16,0),(17,NULL,'company','address_expresspostal',17,0),(18,NULL,'company','country_name',18,0),(19,NULL,'company','phone_number',19,1),(20,NULL,'company','email_address',20,1),(21,NULL,'company','website_url',21,1),(22,NULL,'contact','contact_lastname',1,2),(23,NULL,'contact','contact_firstname',2,1),(24,NULL,'contact','contact_aka',3,0),(25,NULL,'contact','contact_archive',4,1),(26,NULL,'contact','function_label',5,1),(27,NULL,'contact','contact_title',6,1),(28,NULL,'contact','kind_minilabel',7,1),(29,NULL,'contact','kind_header',8,1),(30,NULL,'contact','kind_lang',9,1),(31,NULL,'contact','company_name',10,2),(32,NULL,'contact','company_aka',11,0),(33,NULL,'contact','contact_address',12,1),(34,NULL,'contact','address_street',13,0),(35,NULL,'contact','contact_service',14,0),(36,NULL,'contact','address_zipcode',15,0),(37,NULL,'contact','address_town',16,0),(38,NULL,'contact','address_expresspostal',17,0),(39,NULL,'contact','country_name',18,0),(40,NULL,'contact','phone_number',19,1),(41,NULL,'contact','email_address',20,1),(42,NULL,'contact','contact_date',21,1),(43,NULL,'contact','contact_mailing_ok',22,1),(44,NULL,'contact','contact_newsletter',23,1),(45,NULL,'lead','lead_name',1,2),(46,NULL,'lead','company_name',2,2),(47,NULL,'lead','company_zipcode',3,2),(48,NULL,'lead','company_phone',4,1),(49,NULL,'lead','lead_contact',5,1),(50,NULL,'lead','leadsource_label',6,1),(51,NULL,'lead','date',7,1),(52,NULL,'lead','manager',8,1),(53,NULL,'lead','datealarm',9,1),(54,NULL,'lead','lead_todo',10,1),(55,NULL,'lead','leadstatus_label',11,1),(56,NULL,'lead','lead_archive',12,1),(57,NULL,'deal','deal_label',1,2),(58,NULL,'deal','deal_number',2,1),(59,NULL,'deal','deal_company_name',3,2),(60,NULL,'deal','deal_company_zipcode',4,2),(61,NULL,'deal','dealtype_label',5,1),(62,NULL,'deal','region_label',6,0),(63,NULL,'deal','tasktype_label',7,1),(64,NULL,'deal','dealstatus_label',8,1),(65,NULL,'deal','deal_marketingmanager',9,1),(66,NULL,'deal','deal_source',10,0),(67,NULL,'deal','deal_commission',11,0),(68,NULL,'deal','deal_amount',12,1),(69,NULL,'deal','deal_margin',13,1),(70,NULL,'deal','deal_hitrate',14,1),(71,NULL,'deal','deal_datebegin',15,0),(72,NULL,'deal','deal_dateproposal',16,0),(73,NULL,'deal','deal_dateexpected',17,1),(74,NULL,'deal','expected_quarter',18,0),(75,NULL,'deal','sale_delay',19,0),(76,NULL,'deal','deal_dateend',20,0),(77,NULL,'deal','end_quarter',21,0),(78,NULL,'deal','deal_todo',22,1),(79,NULL,'deal','deal_archive',23,1),(80,NULL,'deal','deal_datealarm',24,2),(81,NULL,'deal','deal_relation',25,0),(82,NULL,'parentdeal','parentdeal_label',1,2),(83,NULL,'parentdeal','parentdeal_marketing_lastname',2,1),(84,NULL,'parentdeal','parentdeal_technical_lastname',3,1),(85,NULL,'list','list_name',1,2),(86,NULL,'list','list_subject',2,1),(87,NULL,'list','list_nb_contact',3,2),(88,NULL,'list','list_info_publication',4,1),(89,NULL,'list','list_mode',5,1),(90,NULL,'list','usercreate',6,1),(91,NULL,'list','timecreate',7,1),(92,NULL,'list','userupdate',8,1),(93,NULL,'list','timeupdate',9,1),(94,NULL,'list_contact','contact_lastname',1,2),(95,NULL,'list_contact','contact_firstname',2,1),(96,NULL,'list_contact','function_label',3,1),(97,NULL,'list_contact','contact_title',4,1),(98,NULL,'list_contact','kind_minilabel',5,1),(99,NULL,'list_contact','kind_header',6,1),(100,NULL,'list_contact','kind_lang',7,1),(101,NULL,'list_contact','company_name',8,2),(102,NULL,'list_contact','address',9,1),(103,NULL,'list_contact','service',10,0),(104,NULL,'list_contact','address1',11,0),(105,NULL,'list_contact','address2',12,0),(106,NULL,'list_contact','address3',13,0),(107,NULL,'list_contact','zipcode',14,1),(108,NULL,'list_contact','town',15,1),(109,NULL,'list_contact','expresspostal',16,1),(110,NULL,'list_contact','country_name',17,1),(111,NULL,'list_contact','contact_phone',18,1),(112,NULL,'list_contact','contact_homephone',19,1),(113,NULL,'list_contact','contact_mobilephone',20,1),(114,NULL,'list_contact','contact_fax',21,1),(115,NULL,'list_contact','publication_lang',22,1),(116,NULL,'list_contact','publication_title',23,1),(117,NULL,'list_contact','subscription_quantity',24,1),(118,NULL,'list_contact','contact_email',25,1),(119,NULL,'todo','event_title',1,2),(120,NULL,'todo','event_priority',2,1),(121,NULL,'todo','eventlink_percent',3,1),(122,NULL,'todo','event_date',4,1),(123,NULL,'todo','date_create',5,1),(124,NULL,'todo','event_update',6,2),(125,NULL,'contract','contract_label',1,1),(126,NULL,'contract','contract_number',2,1),(127,NULL,'contract','contract_company_name',3,2),(128,NULL,'contract','contracttype_label',4,1),(129,NULL,'contract','contract_priority',5,1),(130,NULL,'contract','contract_kind',6,1),(131,NULL,'contract','contract_format',7,1),(132,NULL,'contract','contract_datebegin',8,1),(133,NULL,'contract','contract_dateexp',9,1),(134,NULL,'contract','contract_techmanager',10,1),(135,NULL,'contract','contract_marketmanager',11,1),(136,NULL,'contract','contract_archive',12,1),(137,NULL,'incident','incident_label',1,2),(138,NULL,'incident','incident_reference',2,2),(139,NULL,'incident','incident_company_name',3,2),(140,NULL,'incident','contract_label',4,0),(141,NULL,'incident','incident_logger_lastname',5,1),(142,NULL,'incident','incident_owner_lastname',6,1),(143,NULL,'incident','incident_priority',7,1),(144,NULL,'incident','incident_status',8,2),(145,NULL,'incident','resolutiontype_label',9,1),(146,NULL,'incident','incident_date',10,1),(147,NULL,'incident','incident_duration',11,1),(148,NULL,'incident','timeupdate',12,1),(149,NULL,'incident','incident_archive',13,1),(150,NULL,'account','account_label',1,2),(151,NULL,'account','account_bank',2,1),(152,NULL,'account','account_number',3,1),(153,NULL,'account','account_today',4,1),(154,NULL,'account','account_balance',5,1),(155,NULL,'invoice','invoice_label',1,2),(156,NULL,'invoice','invoice_archive',2,2),(157,NULL,'invoice','invoice_number',3,1),(158,NULL,'invoice','invoice_date',4,1),(159,NULL,'invoice','invoice_expiration_date',5,1),(160,NULL,'invoice','invoice_payment_date',6,1),(161,NULL,'invoice','invoice_company',7,2),(162,NULL,'invoice','invoice_inout',8,1),(163,NULL,'invoice','invoice_credit_memo',9,1),(164,NULL,'invoice','invoice_amount_ht',10,1),(165,NULL,'invoice','invoice_amount_ttc',11,1),(166,NULL,'invoice','invoice_status',12,1),(167,NULL,'invoice','invoice_deal',13,1),(168,NULL,'invoice','invoice_project',14,1),(169,NULL,'payment','payment_date',1,2),(170,NULL,'payment','company_name',2,2),(171,NULL,'payment','payment_amount',3,2),(172,NULL,'payment','payment_number',4,1),(173,NULL,'payment','paymentkind_label',5,1),(174,NULL,'payment','payment_comment',6,1),(175,NULL,'time','date_task',1,1),(176,NULL,'time','timetask_company_name',2,1),(177,NULL,'time','tasktype_label',3,1),(178,NULL,'time','timetask_project_name',4,1),(179,NULL,'time','projecttask_label',5,1),(180,NULL,'time','timetask_label',6,1),(181,NULL,'time','timetask_length',7,2),(182,NULL,'time','timetask_id',8,1),(183,NULL,'project','project_name',1,2),(184,NULL,'project','project_shortname',2,1),(185,NULL,'project','project_company',3,1),(186,NULL,'project','project_type',4,1),(187,NULL,'project','project_tasktype',5,1),(188,NULL,'project','project_code',6,1),(189,NULL,'project','project_soldtime',7,1),(190,NULL,'project','project_estimatedtime',8,1),(191,NULL,'project','project_datebegin',9,1),(192,NULL,'project','project_dateend',10,1),(193,NULL,'project','project_archive',11,1),(194,NULL,'document','document_title',1,2),(195,NULL,'document','document_name',2,1),(196,NULL,'document','document_size',3,1),(197,NULL,'document','document_author',4,1),(198,NULL,'document','timecreate',5,1),(199,NULL,'document','timeupdate',6,1),(200,NULL,'document','documentmimetype_label',9,1),(201,NULL,'user','userobm_login',1,2),(202,NULL,'user','userobm_archive',2,2),(203,NULL,'user','userobm_system',3,0),(204,NULL,'user','domain_label',4,1),(205,NULL,'user','userobm_delegation',5,1),(206,NULL,'user','userobm_local',6,1),(207,NULL,'user','userobm_ext_id',7,1),(208,NULL,'user','userobm_lastname',8,1),(209,NULL,'user','userobm_firstname',9,1),(210,NULL,'user','userobm_title',10,1),(211,NULL,'user','userobm_perms',11,1),(212,NULL,'user','datebegin',12,1),(213,NULL,'user','timelastaccess',13,1),(214,NULL,'user','userobm_phone',14,1),(215,NULL,'user','userobm_phone2',15,1),(216,NULL,'user','userobm_mobile',16,1),(217,NULL,'user','userobm_fax',17,1),(218,NULL,'user','userobm_fax2',18,1),(219,NULL,'user','userobm_email',19,1),(220,NULL,'user','userobm_mail_quota',20,1),(221,NULL,'user','userobm_mail_login_date',21,1),(222,NULL,'user','userobm_nomade',22,1),(223,NULL,'user','userobm_web_perms',23,1),(224,NULL,'user','userobm_samba_perms',24,1),(225,NULL,'user','userobm_description',25,1),(226,NULL,'user','userobm_account_dateexp',26,1),(227,NULL,'group','group_name',1,2),(228,NULL,'group','group_delegation',2,1),(229,NULL,'group','group_gid',3,0),(230,NULL,'group','group_system',4,2),(231,NULL,'group','group_privacy',5,1),(232,NULL,'group','group_local',6,1),(233,NULL,'group','group_ext_id',7,1),(234,NULL,'group','group_samba',8,1),(235,NULL,'group','group_desc',9,1),(236,NULL,'group','group_email',10,1),(237,NULL,'group','group_nb_user',11,2),(238,NULL,'group','usercreate',12,1),(239,NULL,'group','timecreate',13,1),(240,NULL,'group','userupdate',14,1),(241,NULL,'group','timeupdate',15,1),(242,NULL,'group_user','group_user_login',1,2),(243,NULL,'group_user','group_user_lastname',2,1),(244,NULL,'group_user','group_user_firstname',3,1),(245,NULL,'group_user','group_user_phone',4,1),(246,NULL,'group_user','group_user_email',5,1),(247,NULL,'group_group','group_name',1,2),(248,NULL,'group_group','group_desc',2,1),(249,NULL,'group_group','group_email',3,1),(250,NULL,'host','host_name',1,2),(251,NULL,'host','host_delegation',2,1),(252,NULL,'host','host_ip',3,1),(253,NULL,'host','host_samba',4,1),(254,NULL,'host','host_description',5,1),(255,NULL,'host','usercreate',6,1),(256,NULL,'host','timecreate',7,1),(257,NULL,'host','userupdate',8,1),(258,NULL,'host','timeupdate',9,1),(259,NULL,'mailshare','mailshare_name',1,2),(260,NULL,'mailshare','mailshare_delegation',2,1),(261,NULL,'mailshare','mailshare_quota',3,1),(262,NULL,'mailshare','mailshare_email',4,1),(263,NULL,'mailshare','mailshare_description',5,1),(264,NULL,'mailshare','usercreate',6,1),(265,NULL,'mailshare','timecreate',7,1),(266,NULL,'mailshare','userupdate',8,1),(267,NULL,'mailshare','timeupdate',9,1),(268,NULL,'import','import_name',1,2),(269,NULL,'import','import_datasource',2,2),(270,NULL,'import','import_market',3,1),(271,NULL,'import','import_separator',4,1),(272,NULL,'import','import_enclosed',5,1),(273,NULL,'publication','publication_title',1,2),(274,NULL,'publication','publicationtype_label',2,2),(275,NULL,'publication','publication_year',3,1),(276,NULL,'publication','publication_lang',4,1),(277,NULL,'profile','profile_name',1,2),(278,NULL,'resource','resource_name',1,2),(279,NULL,'resource','resource_description',2,1),(280,NULL,'resource','resource_qty',3,1),(281,NULL,'resource','resourcetype_label',4,1),(282,NULL,'resourcegroup','rgroup_name',1,2),(283,NULL,'resourcegroup','rgroup_privacy',2,2),(284,NULL,'resourcegroup','rgroup_desc',3,1),(285,NULL,'resourcegroup','rgroup_nb_resource',4,2),(286,NULL,'resourcegroup','usercreate',5,1),(287,NULL,'resourcegroup','timecreate',6,1),(288,NULL,'resourcegroup','userupdate',7,1),(289,NULL,'resourcegroup','timeupdate',8,1),(290,NULL,'resourcegroup_resource','resourcegroup_resource_name',1,2),(291,NULL,'resourcegroup_resource','resourcegroup_resource_desc',2,1),(292,NULL,'resourcegroup_resource','resourcegroup_resource_qty',3,1),(293,NULL,'domain','domain_label',1,2),(294,NULL,'domain','domain_description',2,1),(295,NULL,'domain','domain_name',3,1),(296,NULL,'domain','domain_alias',4,1),(297,NULL,'mailserver','host_name',1,2),(298,NULL,'mailserver','host_ip',2,1),(299,NULL,'mailserver','mailserver_imap',3,1),(300,NULL,'mailserver','mailserver_smtp_in',4,1),(301,NULL,'mailserver','mailserver_smtp_out',5,1),(302,NULL,'cv','cv_title',1,1),(303,NULL,'cv','lastname',2,2),(304,NULL,'cv','firstname',3,2),(305,NULL,'cv','timeupdate',4,1),(306,NULL,'cv','timecreate',5,1),(307,NULL,'cv_reference','project_name',1,1),(308,NULL,'cv_reference','projectcv_role',2,2),(309,NULL,'cv_reference','project_reference_date',3,2),(310,NULL,'cv_reference','project_reference_duration',4,2),(311,NULL,'cv_reference','project_reference_desc',5,2),(312,NULL,'cv_reference','project_reference_tech',6,2),(313,NULL,'organizationalchart','organizationalchart_name',1,2),(314,NULL,'organizationalchart','organizationalchart_description',2,2),(315,NULL,'organizationalchart','organizationalchart_archive',3,2),(316,NULL,'campaign','campaign_name',1,2),(317,NULL,'campaign','campaign_status',2,1),(318,NULL,'campaign','campaign_start_date',3,1),(319,NULL,'campaign','campaign_end_date',4,1),(320,NULL,'campaign','campaign_progress',5,0),(321,NULL,'campaign_list','list_name',1,1),(322,NULL,'campaign_user','userobm_lastname',1,1),(323,NULL,'campaign_user','userobm_firstname',2,1),(324,NULL,'campaign_group','group_name',1,1);
/*!40000 ALTER TABLE `DisplayPref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Document`
--

DROP TABLE IF EXISTS `Document`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `Document` (
  `document_id` int(8) NOT NULL auto_increment,
  `document_domain_id` int(8) NOT NULL,
  `document_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `document_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `document_userupdate` int(8) default NULL,
  `document_usercreate` int(8) default NULL,
  `document_title` varchar(255) default NULL,
  `document_name` varchar(255) default NULL,
  `document_kind` int(2) default NULL,
  `document_mimetype_id` int(8) default NULL,
  `document_privacy` int(2) NOT NULL default '0',
  `document_size` int(15) default NULL,
  `document_author` varchar(255) default NULL,
  `document_path` text,
  `document_acl` text,
  PRIMARY KEY  (`document_id`),
  KEY `document_domain_id_domain_id_fkey` (`document_domain_id`),
  KEY `document_userupdate_userobm_id_fkey` (`document_userupdate`),
  KEY `document_usercreate_userobm_id_fkey` (`document_usercreate`),
  KEY `document_mimetype_id_documentmimetype_id_fkey` (`document_mimetype_id`),
  CONSTRAINT `document_mimetype_id_documentmimetype_id_fkey` FOREIGN KEY (`document_mimetype_id`) REFERENCES `DocumentMimeType` (`documentmimetype_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `document_domain_id_domain_id_fkey` FOREIGN KEY (`document_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `document_usercreate_userobm_id_fkey` FOREIGN KEY (`document_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `document_userupdate_userobm_id_fkey` FOREIGN KEY (`document_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `Document`
--

LOCK TABLES `Document` WRITE;
/*!40000 ALTER TABLE `Document` DISABLE KEYS */;
/*!40000 ALTER TABLE `Document` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DocumentEntity`
--

DROP TABLE IF EXISTS `DocumentEntity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `DocumentEntity` (
  `documententity_entity_id` int(8) NOT NULL,
  `documententity_document_id` int(8) NOT NULL,
  PRIMARY KEY  (`documententity_entity_id`,`documententity_document_id`),
  KEY `documententity_document_id_document_id_fkey` (`documententity_document_id`),
  CONSTRAINT `documententity_document_id_document_id_fkey` FOREIGN KEY (`documententity_document_id`) REFERENCES `Document` (`document_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `documententity_entity_id_entity_id_fkey` FOREIGN KEY (`documententity_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `DocumentEntity`
--

LOCK TABLES `DocumentEntity` WRITE;
/*!40000 ALTER TABLE `DocumentEntity` DISABLE KEYS */;
/*!40000 ALTER TABLE `DocumentEntity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DocumentLink`
--

DROP TABLE IF EXISTS `DocumentLink`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `DocumentLink` (
  `documentlink_document_id` int(8) NOT NULL,
  `documentlink_entity_id` int(8) NOT NULL,
  PRIMARY KEY  (`documentlink_document_id`,`documentlink_entity_id`),
  KEY `documentlink_entity_id_entity_id_fkey` (`documentlink_entity_id`),
  CONSTRAINT `documentlink_document_id_document_id_fkey` FOREIGN KEY (`documentlink_document_id`) REFERENCES `Document` (`document_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `documentlink_entity_id_entity_id_fkey` FOREIGN KEY (`documentlink_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `DocumentLink`
--

LOCK TABLES `DocumentLink` WRITE;
/*!40000 ALTER TABLE `DocumentLink` DISABLE KEYS */;
/*!40000 ALTER TABLE `DocumentLink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DocumentMimeType`
--

DROP TABLE IF EXISTS `DocumentMimeType`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `DocumentMimeType` (
  `documentmimetype_id` int(8) NOT NULL auto_increment,
  `documentmimetype_domain_id` int(8) NOT NULL,
  `documentmimetype_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `documentmimetype_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `documentmimetype_userupdate` int(8) default NULL,
  `documentmimetype_usercreate` int(8) default NULL,
  `documentmimetype_label` varchar(255) default NULL,
  `documentmimetype_extension` varchar(10) default NULL,
  `documentmimetype_mime` varchar(255) default NULL,
  PRIMARY KEY  (`documentmimetype_id`),
  KEY `documentmimetype_domain_id_domain_id_fkey` (`documentmimetype_domain_id`),
  KEY `documentmimetype_userupdate_userobm_id_fkey` (`documentmimetype_userupdate`),
  KEY `documentmimetype_usercreate_userobm_id_fkey` (`documentmimetype_usercreate`),
  CONSTRAINT `documentmimetype_usercreate_userobm_id_fkey` FOREIGN KEY (`documentmimetype_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `documentmimetype_domain_id_domain_id_fkey` FOREIGN KEY (`documentmimetype_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `documentmimetype_userupdate_userobm_id_fkey` FOREIGN KEY (`documentmimetype_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `DocumentMimeType`
--

LOCK TABLES `DocumentMimeType` WRITE;
/*!40000 ALTER TABLE `DocumentMimeType` DISABLE KEYS */;
INSERT INTO `DocumentMimeType` VALUES (1,1,'2008-12-17 14:00:31','0000-00-00 00:00:00',NULL,NULL,'Fichier Html','html','text/html'),(2,1,'2008-12-17 14:00:31','0000-00-00 00:00:00',NULL,NULL,'Image PNG','png','image/png'),(3,1,'2008-12-17 14:00:31','0000-00-00 00:00:00',NULL,NULL,'Image Gif','gif','image/gif'),(4,1,'2008-12-17 14:00:31','0000-00-00 00:00:00',NULL,NULL,'Image JPG','jpg','image/jpg'),(5,1,'2008-12-17 14:00:31','0000-00-00 00:00:00',NULL,NULL,'Fichier PDF','pdf','application/pdf'),(6,1,'2008-12-17 14:00:31','0000-00-00 00:00:00',NULL,NULL,'Fichier Excel','xls','application/vnd.ms-excel'),(7,1,'2008-12-17 14:00:31','0000-00-00 00:00:00',NULL,NULL,'Fichier Texte','txt','text/plain'),(8,1,'2008-12-17 14:00:31','0000-00-00 00:00:00',NULL,NULL,'Fichier Word','doc','application/msword'),(9,1,'2008-12-17 14:00:31','0000-00-00 00:00:00',NULL,NULL,'Fichier Binaire','exe','application/octet-stream'),(10,1,'2008-12-17 14:00:31','0000-00-00 00:00:00',NULL,NULL,'Fichier PowerPoint','ppt','application/vnd.ms-powerpoint'),(11,1,'2008-12-17 14:00:31','0000-00-00 00:00:00',NULL,NULL,'Fichier CSV','csv','text/x-csv');
/*!40000 ALTER TABLE `DocumentMimeType` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Domain`
--

DROP TABLE IF EXISTS `Domain`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `Domain` (
  `domain_id` int(8) NOT NULL auto_increment,
  `domain_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `domain_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `domain_usercreate` int(8) default NULL,
  `domain_userupdate` int(8) default NULL,
  `domain_label` varchar(32) NOT NULL,
  `domain_description` varchar(255) default NULL,
  `domain_name` varchar(128) default NULL,
  `domain_alias` text,
  `domain_global` tinyint(1) default '0',
  PRIMARY KEY  (`domain_id`),
  KEY `domain_userupdate_userobm_id_fkey` (`domain_userupdate`),
  KEY `domain_usercreate_userobm_id_fkey` (`domain_usercreate`),
  CONSTRAINT `domain_usercreate_userobm_id_fkey` FOREIGN KEY (`domain_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `domain_userupdate_userobm_id_fkey` FOREIGN KEY (`domain_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `Domain`
--

LOCK TABLES `Domain` WRITE;
/*!40000 ALTER TABLE `Domain` DISABLE KEYS */;
INSERT INTO `Domain` VALUES (1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'Global Domain','Virtual domain for managing domains','global.virt',NULL,1);
/*!40000 ALTER TABLE `Domain` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DomainEntity`
--

DROP TABLE IF EXISTS `DomainEntity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `DomainEntity` (
  `domainentity_entity_id` int(8) NOT NULL,
  `domainentity_domain_id` int(8) NOT NULL,
  PRIMARY KEY  (`domainentity_entity_id`,`domainentity_domain_id`),
  KEY `domainentity_domain_id_domain_id_fkey` (`domainentity_domain_id`),
  CONSTRAINT `domainentity_domain_id_domain_id_fkey` FOREIGN KEY (`domainentity_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `domainentity_entity_id_entity_id_fkey` FOREIGN KEY (`domainentity_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `DomainEntity`
--

LOCK TABLES `DomainEntity` WRITE;
/*!40000 ALTER TABLE `DomainEntity` DISABLE KEYS */;
INSERT INTO `DomainEntity` VALUES (1,1);
/*!40000 ALTER TABLE `DomainEntity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DomainProperty`
--

DROP TABLE IF EXISTS `DomainProperty`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `DomainProperty` (
  `domainproperty_key` varchar(255) NOT NULL,
  `domainproperty_type` varchar(32) default NULL,
  `domainproperty_default` varchar(64) default NULL,
  `domainproperty_readonly` int(1) default '0',
  PRIMARY KEY  (`domainproperty_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `DomainProperty`
--

LOCK TABLES `DomainProperty` WRITE;
/*!40000 ALTER TABLE `DomainProperty` DISABLE KEYS */;
INSERT INTO `DomainProperty` VALUES ('address1','text','',0),('address2','text','',0),('address3','text','',0),('delegation','text','',0),('group_admin','integer','0',0),('group_com','integer','0',0),('group_prod','integer','0',0),('last_public_contact_export','timestamp','0',1),('mail_quota','integer','0',0),('max_mailshares','integer','0',0),('max_resources','integer','0',0),('max_users','integer','0',0),('postcode','text','',0),('town','text','',0),('update_state','integer','1',1);
/*!40000 ALTER TABLE `DomainProperty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DomainPropertyValue`
--

DROP TABLE IF EXISTS `DomainPropertyValue`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `DomainPropertyValue` (
  `domainpropertyvalue_domain_id` int(8) NOT NULL,
  `domainpropertyvalue_property_key` varchar(255) NOT NULL,
  `domainpropertyvalue_value` varchar(255) NOT NULL,
  PRIMARY KEY  (`domainpropertyvalue_domain_id`,`domainpropertyvalue_property_key`),
  CONSTRAINT `domainpropertyvalue_domain_id_domain_id_fkey` FOREIGN KEY (`domainpropertyvalue_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `DomainPropertyValue`
--

LOCK TABLES `DomainPropertyValue` WRITE;
/*!40000 ALTER TABLE `DomainPropertyValue` DISABLE KEYS */;
INSERT INTO `DomainPropertyValue` VALUES (1,'update_state','1');
/*!40000 ALTER TABLE `DomainPropertyValue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Email`
--

DROP TABLE IF EXISTS `Email`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `Email` (
  `email_id` int(8) NOT NULL auto_increment,
  `email_entity_id` int(8) NOT NULL,
  `email_label` varchar(255) NOT NULL,
  `email_address` varchar(255) default NULL,
  PRIMARY KEY  (`email_id`),
  KEY `email_address` (`email_address`),
  KEY `email_entity_id_entity_id_fkey` (`email_entity_id`),
  CONSTRAINT `email_entity_id_entity_id_fkey` FOREIGN KEY (`email_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `Email`
--

LOCK TABLES `Email` WRITE;
/*!40000 ALTER TABLE `Email` DISABLE KEYS */;
/*!40000 ALTER TABLE `Email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Entity`
--

DROP TABLE IF EXISTS `Entity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `Entity` (
  `entity_id` int(8) NOT NULL auto_increment,
  `entity_mailing` tinyint(1) default NULL,
  PRIMARY KEY  (`entity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `Entity`
--

LOCK TABLES `Entity` WRITE;
/*!40000 ALTER TABLE `Entity` DISABLE KEYS */;
INSERT INTO `Entity` VALUES (1,1),(2,1);
/*!40000 ALTER TABLE `Entity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EntityRight`
--

DROP TABLE IF EXISTS `EntityRight`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `EntityRight` (
  `entityright_id` int(8) NOT NULL auto_increment,
  `entityright_entity_id` int(8) NOT NULL,
  `entityright_consumer_id` int(8) default NULL,
  `entityright_access` int(1) NOT NULL default '0',
  `entityright_read` int(1) NOT NULL default '0',
  `entityright_write` int(1) NOT NULL default '0',
  `entityright_admin` int(1) NOT NULL default '0',
  PRIMARY KEY  (`entityright_id`),
  KEY `entityright_entity_id_entity_id` (`entityright_entity_id`),
  KEY `entityright_consumer_id_entity_id` (`entityright_consumer_id`),
  CONSTRAINT `entityright_entity_id_entity_id` FOREIGN KEY (`entityright_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `entityright_consumer_id_entity_id` FOREIGN KEY (`entityright_consumer_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `EntityRight`
--

LOCK TABLES `EntityRight` WRITE;
/*!40000 ALTER TABLE `EntityRight` DISABLE KEYS */;
/*!40000 ALTER TABLE `EntityRight` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Event`
--

DROP TABLE IF EXISTS `Event`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `Event` (
  `event_id` int(8) NOT NULL auto_increment,
  `event_domain_id` int(8) NOT NULL,
  `event_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `event_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `event_userupdate` int(8) default NULL,
  `event_usercreate` int(8) default NULL,
  `event_parent_id` int(8) default NULL,
  `event_ext_id` varchar(255) default '',
  `event_type` enum('VEVENT','VTODO','VJOURNAL','VFREEBUSY') default 'VEVENT',
  `event_origin` varchar(255) NOT NULL default '',
  `event_owner` int(8) default NULL,
  `event_timezone` varchar(255) default 'GMT',
  `event_opacity` enum('OPAQUE','TRANSPARENT') default 'OPAQUE',
  `event_title` varchar(255) default NULL,
  `event_location` varchar(100) default NULL,
  `event_category1_id` int(8) default NULL,
  `event_priority` int(2) default NULL,
  `event_privacy` int(2) NOT NULL default '0',
  `event_date` datetime default NULL,
  `event_duration` int(8) NOT NULL default '0',
  `event_allday` tinyint(1) default '0',
  `event_repeatkind` varchar(20) default NULL,
  `event_repeatfrequence` int(3) default NULL,
  `event_repeatdays` varchar(7) default NULL,
  `event_endrepeat` datetime default NULL,
  `event_color` varchar(7) default NULL,
  `event_completed` datetime default NULL,
  `event_url` text,
  `event_description` text,
  `event_properties` text,
  PRIMARY KEY  (`event_id`),
  KEY `event_domain_id_domain_id_fkey` (`event_domain_id`),
  KEY `event_owner_userobm_id_fkey` (`event_owner`),
  KEY `event_userupdate_userobm_id_fkey` (`event_userupdate`),
  KEY `event_usercreate_userobm_id_fkey` (`event_usercreate`),
  KEY `event_category1_id_eventcategory1_id_fkey` (`event_category1_id`),
  CONSTRAINT `event_category1_id_eventcategory1_id_fkey` FOREIGN KEY (`event_category1_id`) REFERENCES `EventCategory1` (`eventcategory1_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `event_domain_id_domain_id_fkey` FOREIGN KEY (`event_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `event_owner_userobm_id_fkey` FOREIGN KEY (`event_owner`) REFERENCES `UserObm` (`userobm_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `event_usercreate_userobm_id_fkey` FOREIGN KEY (`event_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `event_userupdate_userobm_id_fkey` FOREIGN KEY (`event_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `Event`
--

LOCK TABLES `Event` WRITE;
/*!40000 ALTER TABLE `Event` DISABLE KEYS */;
/*!40000 ALTER TABLE `Event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EventAlert`
--

DROP TABLE IF EXISTS `EventAlert`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `EventAlert` (
  `eventalert_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `eventalert_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `eventalert_userupdate` int(8) default NULL,
  `eventalert_usercreate` int(8) default NULL,
  `eventalert_event_id` int(8) default NULL,
  `eventalert_user_id` int(8) default NULL,
  `eventalert_duration` int(8) NOT NULL default '0',
  KEY `idx_eventalert_user` (`eventalert_user_id`),
  KEY `eventalert_event_id_event_id_fkey` (`eventalert_event_id`),
  KEY `eventalert_userupdate_userobm_id_fkey` (`eventalert_userupdate`),
  KEY `eventalert_usercreate_userobm_id_fkey` (`eventalert_usercreate`),
  CONSTRAINT `eventalert_usercreate_userobm_id_fkey` FOREIGN KEY (`eventalert_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `eventalert_event_id_event_id_fkey` FOREIGN KEY (`eventalert_event_id`) REFERENCES `Event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `eventalert_userupdate_userobm_id_fkey` FOREIGN KEY (`eventalert_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `eventalert_user_id_userobm_id_fkey` FOREIGN KEY (`eventalert_user_id`) REFERENCES `UserObm` (`userobm_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `EventAlert`
--

LOCK TABLES `EventAlert` WRITE;
/*!40000 ALTER TABLE `EventAlert` DISABLE KEYS */;
/*!40000 ALTER TABLE `EventAlert` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EventCategory1`
--

DROP TABLE IF EXISTS `EventCategory1`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `EventCategory1` (
  `eventcategory1_id` int(8) NOT NULL auto_increment,
  `eventcategory1_domain_id` int(8) NOT NULL,
  `eventcategory1_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `eventcategory1_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `eventcategory1_userupdate` int(8) default NULL,
  `eventcategory1_usercreate` int(8) default NULL,
  `eventcategory1_code` varchar(10) default '',
  `eventcategory1_label` varchar(128) default NULL,
  `eventcategory1_color` char(6) default NULL,
  PRIMARY KEY  (`eventcategory1_id`),
  KEY `eventcategory1_domain_id_domain_id_fkey` (`eventcategory1_domain_id`),
  KEY `eventcategory1_userupdate_userobm_id_fkey` (`eventcategory1_userupdate`),
  KEY `eventcategory1_usercreate_userobm_id_fkey` (`eventcategory1_usercreate`),
  CONSTRAINT `eventcategory1_usercreate_userobm_id_fkey` FOREIGN KEY (`eventcategory1_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `eventcategory1_domain_id_domain_id_fkey` FOREIGN KEY (`eventcategory1_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `eventcategory1_userupdate_userobm_id_fkey` FOREIGN KEY (`eventcategory1_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `EventCategory1`
--

LOCK TABLES `EventCategory1` WRITE;
/*!40000 ALTER TABLE `EventCategory1` DISABLE KEYS */;
INSERT INTO `EventCategory1` VALUES (1,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'','RDV',NULL),(2,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'','Formation',NULL),(3,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'','Commercial',NULL),(4,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'','Reunion',NULL),(5,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'','Appel tel.',NULL),(6,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'','Support',NULL),(7,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'','Intervention',NULL),(8,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'','Personnel',NULL);
/*!40000 ALTER TABLE `EventCategory1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EventEntity`
--

DROP TABLE IF EXISTS `EventEntity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `EventEntity` (
  `evententity_entity_id` int(8) NOT NULL,
  `evententity_event_id` int(8) NOT NULL,
  PRIMARY KEY  (`evententity_entity_id`,`evententity_event_id`),
  KEY `evententity_event_id_event_id_fkey` (`evententity_event_id`),
  CONSTRAINT `evententity_event_id_event_id_fkey` FOREIGN KEY (`evententity_event_id`) REFERENCES `Event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `evententity_entity_id_entity_id_fkey` FOREIGN KEY (`evententity_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `EventEntity`
--

LOCK TABLES `EventEntity` WRITE;
/*!40000 ALTER TABLE `EventEntity` DISABLE KEYS */;
/*!40000 ALTER TABLE `EventEntity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EventException`
--

DROP TABLE IF EXISTS `EventException`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `EventException` (
  `eventexception_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `eventexception_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `eventexception_userupdate` int(8) default NULL,
  `eventexception_usercreate` int(8) default NULL,
  `eventexception_event_id` int(8) NOT NULL,
  `eventexception_date` datetime NOT NULL,
  PRIMARY KEY  (`eventexception_event_id`,`eventexception_date`),
  KEY `eventexception_userupdate_userobm_id_fkey` (`eventexception_userupdate`),
  KEY `eventexception_usercreate_userobm_id_fkey` (`eventexception_usercreate`),
  CONSTRAINT `eventexception_usercreate_userobm_id_fkey` FOREIGN KEY (`eventexception_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `eventexception_event_id_eventevent_id_fkey` FOREIGN KEY (`eventexception_event_id`) REFERENCES `Event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `eventexception_userupdate_userobm_id_fkey` FOREIGN KEY (`eventexception_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `EventException`
--

LOCK TABLES `EventException` WRITE;
/*!40000 ALTER TABLE `EventException` DISABLE KEYS */;
/*!40000 ALTER TABLE `EventException` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EventLink`
--

DROP TABLE IF EXISTS `EventLink`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `EventLink` (
  `eventlink_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `eventlink_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `eventlink_userupdate` int(8) default NULL,
  `eventlink_usercreate` int(8) default NULL,
  `eventlink_event_id` int(8) NOT NULL,
  `eventlink_entity_id` int(8) NOT NULL,
  `eventlink_state` enum('NEEDS-ACTION','ACCEPTED','DECLINED','TENTATIVE','DELEGATED','COMPLETED','IN-PROGRESS') default 'NEEDS-ACTION',
  `eventlink_required` enum('CHAIR','REQ','OPT','NON') default 'REQ',
  `eventlink_percent` int(3) default '0',
  PRIMARY KEY  (`eventlink_event_id`,`eventlink_entity_id`),
  KEY `eventlink_userupdate_userobm_id_fkey` (`eventlink_userupdate`),
  KEY `eventlink_usercreate_userobm_id_fkey` (`eventlink_usercreate`),
  KEY `eventlink_entity_id_entity_id_fkey` (`eventlink_entity_id`),
  CONSTRAINT `eventlink_entity_id_entity_id_fkey` FOREIGN KEY (`eventlink_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `eventlink_usercreate_userobm_id_fkey` FOREIGN KEY (`eventlink_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `eventlink_event_id_event_id_fkey` FOREIGN KEY (`eventlink_event_id`) REFERENCES `Event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `eventlink_userupdate_userobm_id_fkey` FOREIGN KEY (`eventlink_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `EventLink`
--

LOCK TABLES `EventLink` WRITE;
/*!40000 ALTER TABLE `EventLink` DISABLE KEYS */;
/*!40000 ALTER TABLE `EventLink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GroupEntity`
--

DROP TABLE IF EXISTS `GroupEntity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `GroupEntity` (
  `groupentity_entity_id` int(8) NOT NULL,
  `groupentity_group_id` int(8) NOT NULL,
  PRIMARY KEY  (`groupentity_entity_id`,`groupentity_group_id`),
  KEY `groupentity_group_id_group_id_fkey` (`groupentity_group_id`),
  CONSTRAINT `groupentity_group_id_group_id_fkey` FOREIGN KEY (`groupentity_group_id`) REFERENCES `UGroup` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `groupentity_entity_id_entity_id_fkey` FOREIGN KEY (`groupentity_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `GroupEntity`
--

LOCK TABLES `GroupEntity` WRITE;
/*!40000 ALTER TABLE `GroupEntity` DISABLE KEYS */;
/*!40000 ALTER TABLE `GroupEntity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GroupGroup`
--

DROP TABLE IF EXISTS `GroupGroup`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `GroupGroup` (
  `groupgroup_parent_id` int(8) NOT NULL,
  `groupgroup_child_id` int(8) NOT NULL,
  PRIMARY KEY  (`groupgroup_parent_id`,`groupgroup_child_id`),
  KEY `groupgroup_child_id_group_id_fkey` (`groupgroup_child_id`),
  CONSTRAINT `groupgroup_child_id_group_id_fkey` FOREIGN KEY (`groupgroup_child_id`) REFERENCES `UGroup` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `groupgroup_parent_id_group_id_fkey` FOREIGN KEY (`groupgroup_parent_id`) REFERENCES `UGroup` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `GroupGroup`
--

LOCK TABLES `GroupGroup` WRITE;
/*!40000 ALTER TABLE `GroupGroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `GroupGroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Host`
--

DROP TABLE IF EXISTS `Host`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `Host` (
  `host_id` int(8) NOT NULL auto_increment,
  `host_domain_id` int(8) NOT NULL,
  `host_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `host_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `host_userupdate` int(8) default NULL,
  `host_usercreate` int(8) default NULL,
  `host_uid` int(8) default NULL,
  `host_gid` int(8) default NULL,
  `host_archive` int(1) NOT NULL default '0',
  `host_name` varchar(32) NOT NULL,
  `host_fqdn` varchar(255) default NULL,
  `host_ip` varchar(16) default NULL,
  `host_delegation` varchar(64) default '',
  `host_description` varchar(128) default NULL,
  PRIMARY KEY  (`host_id`),
  UNIQUE KEY `host_name` (`host_name`),
  UNIQUE KEY `k_uid_host` (`host_uid`),
  KEY `host_domain_id_domain_id_fkey` (`host_domain_id`),
  KEY `host_userupdate_userobm_id_fkey` (`host_userupdate`),
  KEY `host_usercreate_userobm_id_fkey` (`host_usercreate`),
  CONSTRAINT `host_usercreate_userobm_id_fkey` FOREIGN KEY (`host_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `host_domain_id_domain_id_fkey` FOREIGN KEY (`host_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `host_userupdate_userobm_id_fkey` FOREIGN KEY (`host_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `Host`
--

LOCK TABLES `Host` WRITE;
/*!40000 ALTER TABLE `Host` DISABLE KEYS */;
/*!40000 ALTER TABLE `Host` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HostEntity`
--

DROP TABLE IF EXISTS `HostEntity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `HostEntity` (
  `hostentity_entity_id` int(8) NOT NULL,
  `hostentity_host_id` int(8) NOT NULL,
  PRIMARY KEY  (`hostentity_entity_id`,`hostentity_host_id`),
  KEY `hostentity_host_id_host_id_fkey` (`hostentity_host_id`),
  CONSTRAINT `hostentity_host_id_host_id_fkey` FOREIGN KEY (`hostentity_host_id`) REFERENCES `Host` (`host_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `hostentity_entity_id_entity_id_fkey` FOREIGN KEY (`hostentity_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `HostEntity`
--

LOCK TABLES `HostEntity` WRITE;
/*!40000 ALTER TABLE `HostEntity` DISABLE KEYS */;
/*!40000 ALTER TABLE `HostEntity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IM`
--

DROP TABLE IF EXISTS `IM`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `IM` (
  `im_id` int(8) NOT NULL auto_increment,
  `im_entity_id` int(8) NOT NULL,
  `im_label` varchar(255) NOT NULL,
  `im_address` varchar(255) default NULL,
  `im_protocol` varchar(255) default NULL,
  PRIMARY KEY  (`im_id`),
  KEY `im_address` (`im_address`),
  KEY `im_entity_id_entity_id_fkey` (`im_entity_id`),
  CONSTRAINT `im_entity_id_entity_id_fkey` FOREIGN KEY (`im_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `IM`
--

LOCK TABLES `IM` WRITE;
/*!40000 ALTER TABLE `IM` DISABLE KEYS */;
/*!40000 ALTER TABLE `IM` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Import`
--

DROP TABLE IF EXISTS `Import`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `Import` (
  `import_id` int(8) NOT NULL auto_increment,
  `import_domain_id` int(8) NOT NULL,
  `import_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `import_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `import_userupdate` int(8) default NULL,
  `import_usercreate` int(8) default NULL,
  `import_name` varchar(64) NOT NULL,
  `import_datasource_id` int(8) default NULL,
  `import_marketingmanager_id` int(8) default NULL,
  `import_separator` varchar(3) default NULL,
  `import_enclosed` char(1) default NULL,
  `import_desc` text,
  PRIMARY KEY  (`import_id`),
  UNIQUE KEY `import_name` (`import_name`),
  KEY `import_domain_id_domain_id_fkey` (`import_domain_id`),
  KEY `import_userupdate_userobm_id_fkey` (`import_userupdate`),
  KEY `import_usercreate_userobm_id_fkey` (`import_usercreate`),
  KEY `import_datasource_id_datasource_id_fkey` (`import_datasource_id`),
  KEY `import_marketingmanager_id_userobm_id_fkey` (`import_marketingmanager_id`),
  CONSTRAINT `import_marketingmanager_id_userobm_id_fkey` FOREIGN KEY (`import_marketingmanager_id`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `import_datasource_id_datasource_id_fkey` FOREIGN KEY (`import_datasource_id`) REFERENCES `DataSource` (`datasource_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `import_domain_id_domain_id_fkey` FOREIGN KEY (`import_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `import_usercreate_userobm_id_fkey` FOREIGN KEY (`import_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `import_userupdate_userobm_id_fkey` FOREIGN KEY (`import_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `Import`
--

LOCK TABLES `Import` WRITE;
/*!40000 ALTER TABLE `Import` DISABLE KEYS */;
/*!40000 ALTER TABLE `Import` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ImportEntity`
--

DROP TABLE IF EXISTS `ImportEntity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ImportEntity` (
  `importentity_entity_id` int(8) NOT NULL,
  `importentity_import_id` int(8) NOT NULL,
  PRIMARY KEY  (`importentity_entity_id`,`importentity_import_id`),
  KEY `importentity_import_id_import_id_fkey` (`importentity_import_id`),
  CONSTRAINT `importentity_import_id_import_id_fkey` FOREIGN KEY (`importentity_import_id`) REFERENCES `Import` (`import_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `importentity_entity_id_entity_id_fkey` FOREIGN KEY (`importentity_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ImportEntity`
--

LOCK TABLES `ImportEntity` WRITE;
/*!40000 ALTER TABLE `ImportEntity` DISABLE KEYS */;
/*!40000 ALTER TABLE `ImportEntity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Incident`
--

DROP TABLE IF EXISTS `Incident`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `Incident` (
  `incident_id` int(8) NOT NULL auto_increment,
  `incident_domain_id` int(8) NOT NULL,
  `incident_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `incident_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `incident_userupdate` int(8) default NULL,
  `incident_usercreate` int(8) default NULL,
  `incident_contract_id` int(8) NOT NULL,
  `incident_label` varchar(100) default NULL,
  `incident_reference` varchar(32) default NULL,
  `incident_date` timestamp NOT NULL default '0000-00-00 00:00:00',
  `incident_priority_id` int(8) default NULL,
  `incident_status_id` int(8) default NULL,
  `incident_resolutiontype_id` int(11) default NULL,
  `incident_logger` int(8) default NULL,
  `incident_owner` int(8) default NULL,
  `incident_duration` char(4) default '0',
  `incident_archive` char(1) NOT NULL default '0',
  `incident_comment` text,
  `incident_resolution` text,
  PRIMARY KEY  (`incident_id`),
  KEY `incident_domain_id_domain_id_fkey` (`incident_domain_id`),
  KEY `incident_contract_id_contract_id_fkey` (`incident_contract_id`),
  KEY `incident_userupdate_userobm_id_fkey` (`incident_userupdate`),
  KEY `incident_usercreate_userobm_id_fkey` (`incident_usercreate`),
  KEY `incident_priority_id_incidentpriority_id_fkey` (`incident_priority_id`),
  KEY `incident_status_id_incidentstatus_id_fkey` (`incident_status_id`),
  KEY `incident_resolutiontype_id_incidentresolutiontype_id_fkey` (`incident_resolutiontype_id`),
  KEY `incident_logger_userobm_id_fkey` (`incident_logger`),
  KEY `incident_owner_userobm_id_fkey` (`incident_owner`),
  CONSTRAINT `incident_owner_userobm_id_fkey` FOREIGN KEY (`incident_owner`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `incident_contract_id_contract_id_fkey` FOREIGN KEY (`incident_contract_id`) REFERENCES `Contract` (`contract_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `incident_domain_id_domain_id_fkey` FOREIGN KEY (`incident_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `incident_logger_userobm_id_fkey` FOREIGN KEY (`incident_logger`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `incident_priority_id_incidentpriority_id_fkey` FOREIGN KEY (`incident_priority_id`) REFERENCES `IncidentPriority` (`incidentpriority_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `incident_resolutiontype_id_incidentresolutiontype_id_fkey` FOREIGN KEY (`incident_resolutiontype_id`) REFERENCES `IncidentResolutionType` (`incidentresolutiontype_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `incident_status_id_incidentstatus_id_fkey` FOREIGN KEY (`incident_status_id`) REFERENCES `IncidentStatus` (`incidentstatus_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `incident_usercreate_userobm_id_fkey` FOREIGN KEY (`incident_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `incident_userupdate_userobm_id_fkey` FOREIGN KEY (`incident_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `Incident`
--

LOCK TABLES `Incident` WRITE;
/*!40000 ALTER TABLE `Incident` DISABLE KEYS */;
/*!40000 ALTER TABLE `Incident` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IncidentEntity`
--

DROP TABLE IF EXISTS `IncidentEntity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `IncidentEntity` (
  `incidententity_entity_id` int(8) NOT NULL,
  `incidententity_incident_id` int(8) NOT NULL,
  PRIMARY KEY  (`incidententity_entity_id`,`incidententity_incident_id`),
  KEY `incidententity_incident_id_incident_id_fkey` (`incidententity_incident_id`),
  CONSTRAINT `incidententity_incident_id_incident_id_fkey` FOREIGN KEY (`incidententity_incident_id`) REFERENCES `Incident` (`incident_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `incidententity_entity_id_entity_id_fkey` FOREIGN KEY (`incidententity_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `IncidentEntity`
--

LOCK TABLES `IncidentEntity` WRITE;
/*!40000 ALTER TABLE `IncidentEntity` DISABLE KEYS */;
/*!40000 ALTER TABLE `IncidentEntity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IncidentPriority`
--

DROP TABLE IF EXISTS `IncidentPriority`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `IncidentPriority` (
  `incidentpriority_id` int(8) NOT NULL auto_increment,
  `incidentpriority_domain_id` int(8) NOT NULL,
  `incidentpriority_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `incidentpriority_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `incidentpriority_userupdate` int(8) default NULL,
  `incidentpriority_usercreate` int(8) default NULL,
  `incidentpriority_code` varchar(10) default '',
  `incidentpriority_label` varchar(32) default NULL,
  `incidentpriority_color` char(6) default NULL,
  PRIMARY KEY  (`incidentpriority_id`),
  KEY `incidentpriority_domain_id_domain_id_fkey` (`incidentpriority_domain_id`),
  KEY `incidentpriority_userupdate_userobm_id_fkey` (`incidentpriority_userupdate`),
  KEY `incidentpriority_usercreate_userobm_id_fkey` (`incidentpriority_usercreate`),
  CONSTRAINT `incidentpriority_usercreate_userobm_id_fkey` FOREIGN KEY (`incidentpriority_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `incidentpriority_domain_id_domain_id_fkey` FOREIGN KEY (`incidentpriority_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `incidentpriority_userupdate_userobm_id_fkey` FOREIGN KEY (`incidentpriority_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `IncidentPriority`
--

LOCK TABLES `IncidentPriority` WRITE;
/*!40000 ALTER TABLE `IncidentPriority` DISABLE KEYS */;
INSERT INTO `IncidentPriority` VALUES (1,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,1,'1','Urgente','FF0000'),(2,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,1,'2','Forte','EE9D00'),(3,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,1,'3','Normale','550000'),(4,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,1,'4','Basse','000000');
/*!40000 ALTER TABLE `IncidentPriority` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IncidentResolutionType`
--

DROP TABLE IF EXISTS `IncidentResolutionType`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `IncidentResolutionType` (
  `incidentresolutiontype_id` int(8) NOT NULL auto_increment,
  `incidentresolutiontype_domain_id` int(8) NOT NULL,
  `incidentresolutiontype_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `incidentresolutiontype_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `incidentresolutiontype_userupdate` int(8) default NULL,
  `incidentresolutiontype_usercreate` int(8) default NULL,
  `incidentresolutiontype_code` varchar(10) default '',
  `incidentresolutiontype_label` varchar(32) default NULL,
  PRIMARY KEY  (`incidentresolutiontype_id`),
  KEY `incidentresolutiontype_domain_id_domain_id_fkey` (`incidentresolutiontype_domain_id`),
  KEY `incidentresolutiontype_userupdate_userobm_id_fkey` (`incidentresolutiontype_userupdate`),
  KEY `incidentresolutiontype_usercreate_userobm_id_fkey` (`incidentresolutiontype_usercreate`),
  CONSTRAINT `incidentresolutiontype_usercreate_userobm_id_fkey` FOREIGN KEY (`incidentresolutiontype_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `incidentresolutiontype_domain_id_domain_id_fkey` FOREIGN KEY (`incidentresolutiontype_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `incidentresolutiontype_userupdate_userobm_id_fkey` FOREIGN KEY (`incidentresolutiontype_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `IncidentResolutionType`
--

LOCK TABLES `IncidentResolutionType` WRITE;
/*!40000 ALTER TABLE `IncidentResolutionType` DISABLE KEYS */;
/*!40000 ALTER TABLE `IncidentResolutionType` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IncidentStatus`
--

DROP TABLE IF EXISTS `IncidentStatus`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `IncidentStatus` (
  `incidentstatus_id` int(8) NOT NULL auto_increment,
  `incidentstatus_domain_id` int(8) NOT NULL,
  `incidentstatus_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `incidentstatus_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `incidentstatus_userupdate` int(8) default NULL,
  `incidentstatus_usercreate` int(8) default NULL,
  `incidentstatus_code` varchar(10) default '',
  `incidentstatus_label` varchar(32) default NULL,
  PRIMARY KEY  (`incidentstatus_id`),
  KEY `incidentstatus_domain_id_domain_id_fkey` (`incidentstatus_domain_id`),
  KEY `incidentstatus_userupdate_userobm_id_fkey` (`incidentstatus_userupdate`),
  KEY `incidentstatus_usercreate_userobm_id_fkey` (`incidentstatus_usercreate`),
  CONSTRAINT `incidentstatus_usercreate_userobm_id_fkey` FOREIGN KEY (`incidentstatus_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `incidentstatus_domain_id_domain_id_fkey` FOREIGN KEY (`incidentstatus_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `incidentstatus_userupdate_userobm_id_fkey` FOREIGN KEY (`incidentstatus_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `IncidentStatus`
--

LOCK TABLES `IncidentStatus` WRITE;
/*!40000 ALTER TABLE `IncidentStatus` DISABLE KEYS */;
INSERT INTO `IncidentStatus` VALUES (1,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,1,'1','Ouvert'),(2,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,1,'2','Appel'),(3,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,1,'3','Attente Appel'),(4,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,1,'4','En Pause'),(5,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,1,'5','Cloturé');
/*!40000 ALTER TABLE `IncidentStatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Invoice`
--

DROP TABLE IF EXISTS `Invoice`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `Invoice` (
  `invoice_id` int(8) NOT NULL auto_increment,
  `invoice_domain_id` int(8) NOT NULL,
  `invoice_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `invoice_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `invoice_userupdate` int(8) default NULL,
  `invoice_usercreate` int(8) default NULL,
  `invoice_company_id` int(8) NOT NULL,
  `invoice_deal_id` int(8) default NULL,
  `invoice_project_id` int(8) default NULL,
  `invoice_number` varchar(10) default '0',
  `invoice_label` varchar(40) NOT NULL default '',
  `invoice_amount_ht` double(10,2) default NULL,
  `invoice_amount_ttc` double(10,2) default NULL,
  `invoice_status_id` int(4) NOT NULL,
  `invoice_date` date NOT NULL default '0000-00-00',
  `invoice_expiration_date` date default NULL,
  `invoice_payment_date` date default NULL,
  `invoice_inout` char(1) default NULL,
  `invoice_credit_memo` int(1) NOT NULL default '0',
  `invoice_archive` char(1) NOT NULL default '0',
  `invoice_comment` text,
  PRIMARY KEY  (`invoice_id`),
  KEY `invoice_domain_id_domain_id_fkey` (`invoice_domain_id`),
  KEY `invoice_company_id_company_id_fkey` (`invoice_company_id`),
  KEY `invoice_project_id_project_id_fkey` (`invoice_project_id`),
  KEY `invoice_deal_id_deal_id_fkey` (`invoice_deal_id`),
  KEY `invoice_userupdate_userobm_id_fkey` (`invoice_userupdate`),
  KEY `invoice_usercreate_userobm_id_fkey` (`invoice_usercreate`),
  CONSTRAINT `invoice_usercreate_userobm_id_fkey` FOREIGN KEY (`invoice_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `invoice_company_id_company_id_fkey` FOREIGN KEY (`invoice_company_id`) REFERENCES `Company` (`company_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `invoice_deal_id_deal_id_fkey` FOREIGN KEY (`invoice_deal_id`) REFERENCES `Deal` (`deal_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `invoice_domain_id_domain_id_fkey` FOREIGN KEY (`invoice_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `invoice_project_id_project_id_fkey` FOREIGN KEY (`invoice_project_id`) REFERENCES `Project` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `invoice_userupdate_userobm_id_fkey` FOREIGN KEY (`invoice_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `Invoice`
--

LOCK TABLES `Invoice` WRITE;
/*!40000 ALTER TABLE `Invoice` DISABLE KEYS */;
/*!40000 ALTER TABLE `Invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `InvoiceEntity`
--

DROP TABLE IF EXISTS `InvoiceEntity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `InvoiceEntity` (
  `invoiceentity_entity_id` int(8) NOT NULL,
  `invoiceentity_invoice_id` int(8) NOT NULL,
  PRIMARY KEY  (`invoiceentity_entity_id`,`invoiceentity_invoice_id`),
  KEY `invoiceentity_invoice_id_invoice_id_fkey` (`invoiceentity_invoice_id`),
  CONSTRAINT `invoiceentity_invoice_id_invoice_id_fkey` FOREIGN KEY (`invoiceentity_invoice_id`) REFERENCES `Invoice` (`invoice_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `invoiceentity_entity_id_entity_id_fkey` FOREIGN KEY (`invoiceentity_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `InvoiceEntity`
--

LOCK TABLES `InvoiceEntity` WRITE;
/*!40000 ALTER TABLE `InvoiceEntity` DISABLE KEYS */;
/*!40000 ALTER TABLE `InvoiceEntity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Kind`
--

DROP TABLE IF EXISTS `Kind`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `Kind` (
  `kind_id` int(8) NOT NULL auto_increment,
  `kind_domain_id` int(8) NOT NULL,
  `kind_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `kind_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `kind_userupdate` int(8) default NULL,
  `kind_usercreate` int(8) default NULL,
  `kind_minilabel` varchar(64) default NULL,
  `kind_header` varchar(64) default NULL,
  `kind_lang` char(2) default NULL,
  `kind_default` int(1) NOT NULL default '0',
  PRIMARY KEY  (`kind_id`),
  KEY `kind_domain_id_domain_id_fkey` (`kind_domain_id`),
  KEY `kind_userupdate_userobm_id_fkey` (`kind_userupdate`),
  KEY `kind_usercreate_userobm_id_fkey` (`kind_usercreate`),
  CONSTRAINT `kind_usercreate_userobm_id_fkey` FOREIGN KEY (`kind_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `kind_domain_id_domain_id_fkey` FOREIGN KEY (`kind_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `kind_userupdate_userobm_id_fkey` FOREIGN KEY (`kind_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `Kind`
--

LOCK TABLES `Kind` WRITE;
/*!40000 ALTER TABLE `Kind` DISABLE KEYS */;
INSERT INTO `Kind` VALUES (1,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'M.','Monsieur','FR',0),(2,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'Mme','Madame','FR',0),(3,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',NULL,NULL,'Mlle','Mademoiselle','FR',0);
/*!40000 ALTER TABLE `Kind` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Lead`
--

DROP TABLE IF EXISTS `Lead`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `Lead` (
  `lead_id` int(8) NOT NULL auto_increment,
  `lead_domain_id` int(8) NOT NULL,
  `lead_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `lead_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `lead_userupdate` int(8) default NULL,
  `lead_usercreate` int(8) default NULL,
  `lead_source_id` int(8) default NULL,
  `lead_manager_id` int(8) default NULL,
  `lead_company_id` int(8) NOT NULL,
  `lead_contact_id` int(8) default NULL,
  `lead_priority` int(2) default '0',
  `lead_privacy` int(2) NOT NULL default '0',
  `lead_name` varchar(64) default NULL,
  `lead_date` date default NULL,
  `lead_datealarm` date default NULL,
  `lead_status_id` int(2) default NULL,
  `lead_archive` char(1) default '0',
  `lead_todo` varchar(128) default NULL,
  `lead_comment` text,
  PRIMARY KEY  (`lead_id`),
  KEY `lead_domain_id_domain_id_fkey` (`lead_domain_id`),
  KEY `lead_company_id_company_id_fkey` (`lead_company_id`),
  KEY `lead_userupdate_userobm_id_fkey` (`lead_userupdate`),
  KEY `lead_usercreate_userobm_id_fkey` (`lead_usercreate`),
  KEY `lead_source_id_leadsource_id_fkey` (`lead_source_id`),
  KEY `lead_manager_id_userobm_id_fkey` (`lead_manager_id`),
  KEY `lead_contact_id_contact_id_fkey` (`lead_contact_id`),
  KEY `lead_status_id_leadstatus_id_fkey` (`lead_status_id`),
  CONSTRAINT `lead_status_id_leadstatus_id_fkey` FOREIGN KEY (`lead_status_id`) REFERENCES `LeadStatus` (`leadstatus_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `lead_company_id_company_id_fkey` FOREIGN KEY (`lead_company_id`) REFERENCES `Company` (`company_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `lead_contact_id_contact_id_fkey` FOREIGN KEY (`lead_contact_id`) REFERENCES `Contact` (`contact_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `lead_domain_id_domain_id_fkey` FOREIGN KEY (`lead_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `lead_manager_id_userobm_id_fkey` FOREIGN KEY (`lead_manager_id`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `lead_source_id_leadsource_id_fkey` FOREIGN KEY (`lead_source_id`) REFERENCES `LeadSource` (`leadsource_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `lead_usercreate_userobm_id_fkey` FOREIGN KEY (`lead_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `lead_userupdate_userobm_id_fkey` FOREIGN KEY (`lead_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `Lead`
--

LOCK TABLES `Lead` WRITE;
/*!40000 ALTER TABLE `Lead` DISABLE KEYS */;
/*!40000 ALTER TABLE `Lead` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LeadEntity`
--

DROP TABLE IF EXISTS `LeadEntity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `LeadEntity` (
  `leadentity_entity_id` int(8) NOT NULL,
  `leadentity_lead_id` int(8) NOT NULL,
  PRIMARY KEY  (`leadentity_entity_id`,`leadentity_lead_id`),
  KEY `leadentity_lead_id_lead_id_fkey` (`leadentity_lead_id`),
  CONSTRAINT `leadentity_lead_id_lead_id_fkey` FOREIGN KEY (`leadentity_lead_id`) REFERENCES `Lead` (`lead_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `leadentity_entity_id_entity_id_fkey` FOREIGN KEY (`leadentity_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `LeadEntity`
--

LOCK TABLES `LeadEntity` WRITE;
/*!40000 ALTER TABLE `LeadEntity` DISABLE KEYS */;
/*!40000 ALTER TABLE `LeadEntity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LeadSource`
--

DROP TABLE IF EXISTS `LeadSource`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `LeadSource` (
  `leadsource_id` int(8) NOT NULL auto_increment,
  `leadsource_domain_id` int(8) NOT NULL,
  `leadsource_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `leadsource_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `leadsource_userupdate` int(8) default NULL,
  `leadsource_usercreate` int(8) default NULL,
  `leadsource_code` varchar(10) default '',
  `leadsource_label` varchar(100) NOT NULL default '',
  PRIMARY KEY  (`leadsource_id`),
  KEY `leadsource_domain_id_domain_id_fkey` (`leadsource_domain_id`),
  KEY `leadsource_userupdate_userobm_id_fkey` (`leadsource_userupdate`),
  KEY `leadsource_usercreate_userobm_id_fkey` (`leadsource_usercreate`),
  CONSTRAINT `leadsource_usercreate_userobm_id_fkey` FOREIGN KEY (`leadsource_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `leadsource_domain_id_domain_id_fkey` FOREIGN KEY (`leadsource_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `leadsource_userupdate_userobm_id_fkey` FOREIGN KEY (`leadsource_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `LeadSource`
--

LOCK TABLES `LeadSource` WRITE;
/*!40000 ALTER TABLE `LeadSource` DISABLE KEYS */;
/*!40000 ALTER TABLE `LeadSource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LeadStatus`
--

DROP TABLE IF EXISTS `LeadStatus`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `LeadStatus` (
  `leadstatus_id` int(2) NOT NULL auto_increment,
  `leadstatus_domain_id` int(8) NOT NULL,
  `leadstatus_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `leadstatus_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `leadstatus_userupdate` int(8) default NULL,
  `leadstatus_usercreate` int(8) default NULL,
  `leadstatus_code` varchar(10) default NULL,
  `leadstatus_label` varchar(24) default NULL,
  PRIMARY KEY  (`leadstatus_id`),
  KEY `leadstatus_domain_id_domain_id_fkey` (`leadstatus_domain_id`),
  KEY `leadstatus_userupdate_userobm_id_fkey` (`leadstatus_userupdate`),
  KEY `leadstatus_usercreate_userobm_id_fkey` (`leadstatus_usercreate`),
  CONSTRAINT `leadstatus_usercreate_userobm_id_fkey` FOREIGN KEY (`leadstatus_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `leadstatus_domain_id_domain_id_fkey` FOREIGN KEY (`leadstatus_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `leadstatus_userupdate_userobm_id_fkey` FOREIGN KEY (`leadstatus_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `LeadStatus`
--

LOCK TABLES `LeadStatus` WRITE;
/*!40000 ALTER TABLE `LeadStatus` DISABLE KEYS */;
/*!40000 ALTER TABLE `LeadStatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `List`
--

DROP TABLE IF EXISTS `List`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `List` (
  `list_id` int(8) NOT NULL auto_increment,
  `list_domain_id` int(8) NOT NULL,
  `list_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `list_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `list_userupdate` int(8) default NULL,
  `list_usercreate` int(8) default NULL,
  `list_privacy` int(2) NOT NULL default '0',
  `list_name` varchar(64) NOT NULL,
  `list_subject` varchar(128) default NULL,
  `list_email` varchar(128) default NULL,
  `list_mode` int(1) default '0',
  `list_mailing_ok` int(1) default '0',
  `list_contact_archive` int(1) default '0',
  `list_info_publication` int(1) default '0',
  `list_static_nb` int(10) default '0',
  `list_query_nb` int(10) default '0',
  `list_query` text,
  `list_structure` text,
  PRIMARY KEY  (`list_id`),
  UNIQUE KEY `list_name` (`list_name`),
  KEY `list_domain_id_domain_id_fkey` (`list_domain_id`),
  KEY `list_userupdate_userobm_id_fkey` (`list_userupdate`),
  KEY `list_usercreate_userobm_id_fkey` (`list_usercreate`),
  CONSTRAINT `list_usercreate_userobm_id_fkey` FOREIGN KEY (`list_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `list_domain_id_domain_id_fkey` FOREIGN KEY (`list_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `list_userupdate_userobm_id_fkey` FOREIGN KEY (`list_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `List`
--

LOCK TABLES `List` WRITE;
/*!40000 ALTER TABLE `List` DISABLE KEYS */;
/*!40000 ALTER TABLE `List` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ListEntity`
--

DROP TABLE IF EXISTS `ListEntity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ListEntity` (
  `listentity_entity_id` int(8) NOT NULL,
  `listentity_list_id` int(8) NOT NULL,
  PRIMARY KEY  (`listentity_entity_id`,`listentity_list_id`),
  KEY `listentity_list_id_list_id_fkey` (`listentity_list_id`),
  CONSTRAINT `listentity_list_id_list_id_fkey` FOREIGN KEY (`listentity_list_id`) REFERENCES `List` (`list_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `listentity_entity_id_entity_id_fkey` FOREIGN KEY (`listentity_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ListEntity`
--

LOCK TABLES `ListEntity` WRITE;
/*!40000 ALTER TABLE `ListEntity` DISABLE KEYS */;
/*!40000 ALTER TABLE `ListEntity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MailShare`
--

DROP TABLE IF EXISTS `MailShare`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `MailShare` (
  `mailshare_id` int(8) NOT NULL auto_increment,
  `mailshare_domain_id` int(8) NOT NULL,
  `mailshare_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `mailshare_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `mailshare_userupdate` int(8) default NULL,
  `mailshare_usercreate` int(8) default NULL,
  `mailshare_name` varchar(32) default NULL,
  `mailshare_archive` int(1) NOT NULL default '0',
  `mailshare_quota` int(11) NOT NULL default '0',
  `mailshare_mail_server_id` int(8) default NULL,
  `mailshare_delegation` varchar(64) default '',
  `mailshare_description` varchar(255) default NULL,
  `mailshare_email` text,
  PRIMARY KEY  (`mailshare_id`),
  KEY `mailshare_domain_id_domain_id_fkey` (`mailshare_domain_id`),
  KEY `mailshare_mail_server_id_mailserver_id_fkey` (`mailshare_mail_server_id`),
  KEY `mailshare_userupdate_userobm_id_fkey` (`mailshare_userupdate`),
  KEY `mailshare_usercreate_userobm_id_fkey` (`mailshare_usercreate`),
  CONSTRAINT `mailshare_usercreate_userobm_id_fkey` FOREIGN KEY (`mailshare_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `mailshare_domain_id_domain_id_fkey` FOREIGN KEY (`mailshare_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mailshare_mail_server_id_mailserver_id_fkey` FOREIGN KEY (`mailshare_mail_server_id`) REFERENCES `Host` (`host_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mailshare_userupdate_userobm_id_fkey` FOREIGN KEY (`mailshare_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `MailShare`
--

LOCK TABLES `MailShare` WRITE;
/*!40000 ALTER TABLE `MailShare` DISABLE KEYS */;
/*!40000 ALTER TABLE `MailShare` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MailboxEntity`
--

DROP TABLE IF EXISTS `MailboxEntity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `MailboxEntity` (
  `mailboxentity_entity_id` int(8) NOT NULL,
  `mailboxentity_mailbox_id` int(8) NOT NULL,
  PRIMARY KEY  (`mailboxentity_entity_id`,`mailboxentity_mailbox_id`),
  KEY `mailboxentity_mailbox_id_mailbox_id_fkey` (`mailboxentity_mailbox_id`),
  CONSTRAINT `mailboxentity_mailbox_id_mailbox_id_fkey` FOREIGN KEY (`mailboxentity_mailbox_id`) REFERENCES `UserObm` (`userobm_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mailboxentity_entity_id_entity_id_fkey` FOREIGN KEY (`mailboxentity_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `MailboxEntity`
--

LOCK TABLES `MailboxEntity` WRITE;
/*!40000 ALTER TABLE `MailboxEntity` DISABLE KEYS */;
/*!40000 ALTER TABLE `MailboxEntity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MailshareEntity`
--

DROP TABLE IF EXISTS `MailshareEntity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `MailshareEntity` (
  `mailshareentity_entity_id` int(8) NOT NULL,
  `mailshareentity_mailshare_id` int(8) NOT NULL,
  PRIMARY KEY  (`mailshareentity_entity_id`,`mailshareentity_mailshare_id`),
  KEY `mailshareentity_mailshare_id_mailshare_id_fkey` (`mailshareentity_mailshare_id`),
  CONSTRAINT `mailshareentity_mailshare_id_mailshare_id_fkey` FOREIGN KEY (`mailshareentity_mailshare_id`) REFERENCES `MailShare` (`mailshare_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mailshareentity_entity_id_entity_id_fkey` FOREIGN KEY (`mailshareentity_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `MailshareEntity`
--

LOCK TABLES `MailshareEntity` WRITE;
/*!40000 ALTER TABLE `MailshareEntity` DISABLE KEYS */;
/*!40000 ALTER TABLE `MailshareEntity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OGroup`
--

DROP TABLE IF EXISTS `OGroup`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `OGroup` (
  `ogroup_id` int(8) NOT NULL auto_increment,
  `ogroup_domain_id` int(8) NOT NULL,
  `ogroup_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `ogroup_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `ogroup_userupdate` int(8) default NULL,
  `ogroup_usercreate` int(8) default NULL,
  `ogroup_organizationalchart_id` int(8) NOT NULL,
  `ogroup_parent_id` int(8) default NULL,
  `ogroup_name` varchar(32) NOT NULL,
  `ogroup_level` varchar(16) default NULL,
  PRIMARY KEY  (`ogroup_id`),
  KEY `ogroup_domain_id_domain_id_fkey` (`ogroup_domain_id`),
  KEY `ogroup_organizationalchart_id_organizationalchart_id_fkey` (`ogroup_organizationalchart_id`),
  KEY `ogroup_parent_id_ogroup_id_fkey` (`ogroup_parent_id`),
  KEY `ogroup_userupdate_userobm_id_fkey` (`ogroup_userupdate`),
  KEY `ogroup_usercreate_userobm_id_fkey` (`ogroup_usercreate`),
  CONSTRAINT `ogroup_usercreate_userobm_id_fkey` FOREIGN KEY (`ogroup_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `ogroup_domain_id_domain_id_fkey` FOREIGN KEY (`ogroup_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ogroup_organizationalchart_id_organizationalchart_id_fkey` FOREIGN KEY (`ogroup_organizationalchart_id`) REFERENCES `OrganizationalChart` (`organizationalchart_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ogroup_parent_id_ogroup_id_fkey` FOREIGN KEY (`ogroup_parent_id`) REFERENCES `OGroup` (`ogroup_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ogroup_userupdate_userobm_id_fkey` FOREIGN KEY (`ogroup_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `OGroup`
--

LOCK TABLES `OGroup` WRITE;
/*!40000 ALTER TABLE `OGroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `OGroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OGroupLink`
--

DROP TABLE IF EXISTS `OGroupLink`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `OGroupLink` (
  `ogrouplink_id` int(8) NOT NULL auto_increment,
  `ogrouplink_domain_id` int(8) NOT NULL,
  `ogrouplink_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `ogrouplink_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `ogrouplink_userupdate` int(8) default NULL,
  `ogrouplink_usercreate` int(8) default NULL,
  `ogrouplink_ogroup_id` int(8) NOT NULL,
  `ogrouplink_entity_id` int(8) NOT NULL,
  PRIMARY KEY  (`ogrouplink_id`),
  KEY `ogrouplink_ogroup_id_ogroup_id_fkey` (`ogrouplink_ogroup_id`),
  KEY `ogrouplink_domain_id_domain_id_fkey` (`ogrouplink_domain_id`),
  KEY `ogrouplink_userupdate_userobm_id_fkey` (`ogrouplink_userupdate`),
  KEY `ogrouplink_usercreate_userobm_id_fkey` (`ogrouplink_usercreate`),
  KEY `ogrouplink_entity_id_entity_id_fkey` (`ogrouplink_entity_id`),
  CONSTRAINT `ogrouplink_entity_id_entity_id_fkey` FOREIGN KEY (`ogrouplink_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ogrouplink_usercreate_userobm_id_fkey` FOREIGN KEY (`ogrouplink_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `ogrouplink_domain_id_domain_id_fkey` FOREIGN KEY (`ogrouplink_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ogrouplink_ogroup_id_ogroup_id_fkey` FOREIGN KEY (`ogrouplink_ogroup_id`) REFERENCES `OGroup` (`ogroup_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ogrouplink_userupdate_userobm_id_fkey` FOREIGN KEY (`ogrouplink_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `OGroupLink`
--

LOCK TABLES `OGroupLink` WRITE;
/*!40000 ALTER TABLE `OGroupLink` DISABLE KEYS */;
/*!40000 ALTER TABLE `OGroupLink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ObmBookmark`
--

DROP TABLE IF EXISTS `ObmBookmark`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ObmBookmark` (
  `obmbookmark_id` int(8) NOT NULL auto_increment,
  `obmbookmark_user_id` int(8) NOT NULL,
  `obmbookmark_label` varchar(48) NOT NULL default '',
  `obmbookmark_entity` varchar(24) NOT NULL default '',
  PRIMARY KEY  (`obmbookmark_id`),
  KEY `bkm_idx_user` (`obmbookmark_user_id`),
  CONSTRAINT `obmbookmark_user_id_userobm_id_fkey` FOREIGN KEY (`obmbookmark_user_id`) REFERENCES `UserObm` (`userobm_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ObmBookmark`
--

LOCK TABLES `ObmBookmark` WRITE;
/*!40000 ALTER TABLE `ObmBookmark` DISABLE KEYS */;
/*!40000 ALTER TABLE `ObmBookmark` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ObmBookmarkProperty`
--

DROP TABLE IF EXISTS `ObmBookmarkProperty`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ObmBookmarkProperty` (
  `obmbookmarkproperty_id` int(8) NOT NULL auto_increment,
  `obmbookmarkproperty_bookmark_id` int(8) NOT NULL,
  `obmbookmarkproperty_property` varchar(64) NOT NULL default '',
  `obmbookmarkproperty_value` varchar(64) NOT NULL default '',
  PRIMARY KEY  (`obmbookmarkproperty_id`),
  KEY `bkmprop_idx_bkm` (`obmbookmarkproperty_bookmark_id`),
  CONSTRAINT `obmbookmarkproperty_bookmark_id_obmbookmark_id_fkey` FOREIGN KEY (`obmbookmarkproperty_bookmark_id`) REFERENCES `ObmBookmark` (`obmbookmark_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ObmBookmarkProperty`
--

LOCK TABLES `ObmBookmarkProperty` WRITE;
/*!40000 ALTER TABLE `ObmBookmarkProperty` DISABLE KEYS */;
/*!40000 ALTER TABLE `ObmBookmarkProperty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ObmInfo`
--

DROP TABLE IF EXISTS `ObmInfo`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ObmInfo` (
  `obminfo_name` varchar(32) NOT NULL default '',
  `obminfo_value` varchar(255) default '',
  PRIMARY KEY  (`obminfo_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ObmInfo`
--

LOCK TABLES `ObmInfo` WRITE;
/*!40000 ALTER TABLE `ObmInfo` DISABLE KEYS */;
INSERT INTO `ObmInfo` VALUES ('db_version','2.1'),('remote_access','0'),('update_lock','0');
/*!40000 ALTER TABLE `ObmInfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ObmSession`
--

DROP TABLE IF EXISTS `ObmSession`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ObmSession` (
  `obmsession_sid` varchar(32) NOT NULL default '',
  `obmsession_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `obmsession_name` varchar(32) NOT NULL default '',
  `obmsession_data` text,
  PRIMARY KEY  (`obmsession_sid`,`obmsession_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ObmSession`
--

LOCK TABLES `ObmSession` WRITE;
/*!40000 ALTER TABLE `ObmSession` DISABLE KEYS */;
/*!40000 ALTER TABLE `ObmSession` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ObmbookmarkEntity`
--

DROP TABLE IF EXISTS `ObmbookmarkEntity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ObmbookmarkEntity` (
  `obmbookmarkentity_entity_id` int(8) NOT NULL,
  `obmbookmarkentity_obmbookmark_id` int(8) NOT NULL,
  PRIMARY KEY  (`obmbookmarkentity_entity_id`,`obmbookmarkentity_obmbookmark_id`),
  KEY `obmbookmarkentity_obmbookmark_id_obmbookmark_id_fkey` (`obmbookmarkentity_obmbookmark_id`),
  CONSTRAINT `obmbookmarkentity_obmbookmark_id_obmbookmark_id_fkey` FOREIGN KEY (`obmbookmarkentity_obmbookmark_id`) REFERENCES `ObmBookmark` (`obmbookmark_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `obmbookmarkentity_entity_id_entity_id_fkey` FOREIGN KEY (`obmbookmarkentity_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ObmbookmarkEntity`
--

LOCK TABLES `ObmbookmarkEntity` WRITE;
/*!40000 ALTER TABLE `ObmbookmarkEntity` DISABLE KEYS */;
/*!40000 ALTER TABLE `ObmbookmarkEntity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OgroupEntity`
--

DROP TABLE IF EXISTS `OgroupEntity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `OgroupEntity` (
  `ogroupentity_entity_id` int(8) NOT NULL,
  `ogroupentity_ogroup_id` int(8) NOT NULL,
  PRIMARY KEY  (`ogroupentity_entity_id`,`ogroupentity_ogroup_id`),
  KEY `ogroupentity_ogroup_id_ogroup_id_fkey` (`ogroupentity_ogroup_id`),
  CONSTRAINT `ogroupentity_ogroup_id_ogroup_id_fkey` FOREIGN KEY (`ogroupentity_ogroup_id`) REFERENCES `OGroup` (`ogroup_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ogroupentity_entity_id_entity_id_fkey` FOREIGN KEY (`ogroupentity_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `OgroupEntity`
--

LOCK TABLES `OgroupEntity` WRITE;
/*!40000 ALTER TABLE `OgroupEntity` DISABLE KEYS */;
/*!40000 ALTER TABLE `OgroupEntity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OrganizationalChart`
--

DROP TABLE IF EXISTS `OrganizationalChart`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `OrganizationalChart` (
  `organizationalchart_id` int(8) NOT NULL auto_increment,
  `organizationalchart_domain_id` int(8) NOT NULL,
  `organizationalchart_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `organizationalchart_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `organizationalchart_userupdate` int(8) default NULL,
  `organizationalchart_usercreate` int(8) default NULL,
  `organizationalchart_name` varchar(32) NOT NULL,
  `organizationalchart_description` varchar(64) default NULL,
  `organizationalchart_archive` int(1) NOT NULL default '0',
  PRIMARY KEY  (`organizationalchart_id`),
  KEY `organizationalchart_domain_id_domain_id_fkey` (`organizationalchart_domain_id`),
  KEY `organizationalchart_userupdate_userobm_id_fkey` (`organizationalchart_userupdate`),
  KEY `organizationalchart_usercreate_userobm_id_fkey` (`organizationalchart_usercreate`),
  CONSTRAINT `organizationalchart_usercreate_userobm_id_fkey` FOREIGN KEY (`organizationalchart_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `organizationalchart_domain_id_domain_id_fkey` FOREIGN KEY (`organizationalchart_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `organizationalchart_userupdate_userobm_id_fkey` FOREIGN KEY (`organizationalchart_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `OrganizationalChart`
--

LOCK TABLES `OrganizationalChart` WRITE;
/*!40000 ALTER TABLE `OrganizationalChart` DISABLE KEYS */;
/*!40000 ALTER TABLE `OrganizationalChart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OrganizationalchartEntity`
--

DROP TABLE IF EXISTS `OrganizationalchartEntity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `OrganizationalchartEntity` (
  `organizationalchartentity_entity_id` int(8) NOT NULL,
  `organizationalchartentity_organizationalchart_id` int(8) NOT NULL,
  PRIMARY KEY  (`organizationalchartentity_entity_id`,`organizationalchartentity_organizationalchart_id`),
  KEY `organizationalchart_id_organizationalchart_id_fkey` (`organizationalchartentity_organizationalchart_id`),
  CONSTRAINT `organizationalchart_id_organizationalchart_id_fkey` FOREIGN KEY (`organizationalchartentity_organizationalchart_id`) REFERENCES `OrganizationalChart` (`organizationalchart_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `organizationalchartentity_entity_id_entity_id_fkey` FOREIGN KEY (`organizationalchartentity_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `OrganizationalchartEntity`
--

LOCK TABLES `OrganizationalchartEntity` WRITE;
/*!40000 ALTER TABLE `OrganizationalchartEntity` DISABLE KEYS */;
/*!40000 ALTER TABLE `OrganizationalchartEntity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `P_Domain`
--

DROP TABLE IF EXISTS `P_Domain`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `P_Domain` (
  `domain_id` int(8) NOT NULL auto_increment,
  `domain_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `domain_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `domain_usercreate` int(8) default NULL,
  `domain_userupdate` int(8) default NULL,
  `domain_label` varchar(32) NOT NULL,
  `domain_description` varchar(255) default NULL,
  `domain_name` varchar(128) default NULL,
  `domain_alias` text,
  `domain_global` tinyint(1) default '0',
  PRIMARY KEY  (`domain_id`),
  KEY `domain_userupdate_userobm_id_fkey` (`domain_userupdate`),
  KEY `domain_usercreate_userobm_id_fkey` (`domain_usercreate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `P_Domain`
--

LOCK TABLES `P_Domain` WRITE;
/*!40000 ALTER TABLE `P_Domain` DISABLE KEYS */;
/*!40000 ALTER TABLE `P_Domain` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `P_DomainEntity`
--

DROP TABLE IF EXISTS `P_DomainEntity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `P_DomainEntity` (
  `domainentity_entity_id` int(8) NOT NULL,
  `domainentity_domain_id` int(8) NOT NULL,
  PRIMARY KEY  (`domainentity_entity_id`,`domainentity_domain_id`),
  KEY `domainentity_domain_id_domain_id_fkey` (`domainentity_domain_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `P_DomainEntity`
--

LOCK TABLES `P_DomainEntity` WRITE;
/*!40000 ALTER TABLE `P_DomainEntity` DISABLE KEYS */;
/*!40000 ALTER TABLE `P_DomainEntity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `P_EntityRight`
--

DROP TABLE IF EXISTS `P_EntityRight`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `P_EntityRight` (
  `entityright_id` int(8) NOT NULL auto_increment,
  `entityright_entity_id` int(8) NOT NULL,
  `entityright_consumer_id` int(8) default NULL,
  `entityright_access` int(1) NOT NULL default '0',
  `entityright_read` int(1) NOT NULL default '0',
  `entityright_write` int(1) NOT NULL default '0',
  `entityright_admin` int(1) NOT NULL default '0',
  PRIMARY KEY  (`entityright_id`),
  KEY `entityright_entity_id_entity_id` (`entityright_entity_id`),
  KEY `entityright_consumer_id_entity_id` (`entityright_consumer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `P_EntityRight`
--

LOCK TABLES `P_EntityRight` WRITE;
/*!40000 ALTER TABLE `P_EntityRight` DISABLE KEYS */;
/*!40000 ALTER TABLE `P_EntityRight` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `P_GroupEntity`
--

DROP TABLE IF EXISTS `P_GroupEntity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `P_GroupEntity` (
  `groupentity_entity_id` int(8) NOT NULL,
  `groupentity_group_id` int(8) NOT NULL,
  PRIMARY KEY  (`groupentity_entity_id`,`groupentity_group_id`),
  KEY `groupentity_group_id_group_id_fkey` (`groupentity_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `P_GroupEntity`
--

LOCK TABLES `P_GroupEntity` WRITE;
/*!40000 ALTER TABLE `P_GroupEntity` DISABLE KEYS */;
/*!40000 ALTER TABLE `P_GroupEntity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `P_Host`
--

DROP TABLE IF EXISTS `P_Host`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `P_Host` (
  `host_id` int(8) NOT NULL auto_increment,
  `host_domain_id` int(8) NOT NULL,
  `host_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `host_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `host_userupdate` int(8) default NULL,
  `host_usercreate` int(8) default NULL,
  `host_uid` int(8) default NULL,
  `host_gid` int(8) default NULL,
  `host_archive` int(1) NOT NULL default '0',
  `host_name` varchar(32) NOT NULL,
  `host_fqdn` varchar(255) default NULL,
  `host_ip` varchar(16) default NULL,
  `host_delegation` varchar(64) default '',
  `host_description` varchar(128) default NULL,
  PRIMARY KEY  (`host_id`),
  UNIQUE KEY `host_name` (`host_name`),
  UNIQUE KEY `k_uid_host` (`host_uid`),
  KEY `host_domain_id_domain_id_fkey` (`host_domain_id`),
  KEY `host_userupdate_userobm_id_fkey` (`host_userupdate`),
  KEY `host_usercreate_userobm_id_fkey` (`host_usercreate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `P_Host`
--

LOCK TABLES `P_Host` WRITE;
/*!40000 ALTER TABLE `P_Host` DISABLE KEYS */;
/*!40000 ALTER TABLE `P_Host` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `P_HostEntity`
--

DROP TABLE IF EXISTS `P_HostEntity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `P_HostEntity` (
  `hostentity_entity_id` int(8) NOT NULL,
  `hostentity_host_id` int(8) NOT NULL,
  PRIMARY KEY  (`hostentity_entity_id`,`hostentity_host_id`),
  KEY `hostentity_host_id_host_id_fkey` (`hostentity_host_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `P_HostEntity`
--

LOCK TABLES `P_HostEntity` WRITE;
/*!40000 ALTER TABLE `P_HostEntity` DISABLE KEYS */;
/*!40000 ALTER TABLE `P_HostEntity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `P_MailShare`
--

DROP TABLE IF EXISTS `P_MailShare`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `P_MailShare` (
  `mailshare_id` int(8) NOT NULL auto_increment,
  `mailshare_domain_id` int(8) NOT NULL,
  `mailshare_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `mailshare_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `mailshare_userupdate` int(8) default NULL,
  `mailshare_usercreate` int(8) default NULL,
  `mailshare_name` varchar(32) default NULL,
  `mailshare_archive` int(1) NOT NULL default '0',
  `mailshare_quota` int(11) NOT NULL default '0',
  `mailshare_mail_server_id` int(8) default NULL,
  `mailshare_delegation` varchar(64) default '',
  `mailshare_description` varchar(255) default NULL,
  `mailshare_email` text,
  PRIMARY KEY  (`mailshare_id`),
  KEY `mailshare_domain_id_domain_id_fkey` (`mailshare_domain_id`),
  KEY `mailshare_mail_server_id_mailserver_id_fkey` (`mailshare_mail_server_id`),
  KEY `mailshare_userupdate_userobm_id_fkey` (`mailshare_userupdate`),
  KEY `mailshare_usercreate_userobm_id_fkey` (`mailshare_usercreate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `P_MailShare`
--

LOCK TABLES `P_MailShare` WRITE;
/*!40000 ALTER TABLE `P_MailShare` DISABLE KEYS */;
/*!40000 ALTER TABLE `P_MailShare` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `P_MailboxEntity`
--

DROP TABLE IF EXISTS `P_MailboxEntity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `P_MailboxEntity` (
  `mailboxentity_entity_id` int(8) NOT NULL,
  `mailboxentity_mailbox_id` int(8) NOT NULL,
  PRIMARY KEY  (`mailboxentity_entity_id`,`mailboxentity_mailbox_id`),
  KEY `mailboxentity_mailbox_id_mailbox_id_fkey` (`mailboxentity_mailbox_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `P_MailboxEntity`
--

LOCK TABLES `P_MailboxEntity` WRITE;
/*!40000 ALTER TABLE `P_MailboxEntity` DISABLE KEYS */;
/*!40000 ALTER TABLE `P_MailboxEntity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `P_MailshareEntity`
--

DROP TABLE IF EXISTS `P_MailshareEntity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `P_MailshareEntity` (
  `mailshareentity_entity_id` int(8) NOT NULL,
  `mailshareentity_mailshare_id` int(8) NOT NULL,
  PRIMARY KEY  (`mailshareentity_entity_id`,`mailshareentity_mailshare_id`),
  KEY `mailshareentity_mailshare_id_mailshare_id_fkey` (`mailshareentity_mailshare_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `P_MailshareEntity`
--

LOCK TABLES `P_MailshareEntity` WRITE;
/*!40000 ALTER TABLE `P_MailshareEntity` DISABLE KEYS */;
/*!40000 ALTER TABLE `P_MailshareEntity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `P_Service`
--

DROP TABLE IF EXISTS `P_Service`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `P_Service` (
  `service_id` int(8) NOT NULL auto_increment,
  `service_service` varchar(255) NOT NULL,
  `service_entity_id` int(8) NOT NULL,
  PRIMARY KEY  (`service_id`),
  KEY `service_service_key` (`service_service`),
  KEY `service_entity_id_entity_id_fkey` (`service_entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `P_Service`
--

LOCK TABLES `P_Service` WRITE;
/*!40000 ALTER TABLE `P_Service` DISABLE KEYS */;
/*!40000 ALTER TABLE `P_Service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `P_ServiceProperty`
--

DROP TABLE IF EXISTS `P_ServiceProperty`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `P_ServiceProperty` (
  `serviceproperty_id` int(8) NOT NULL auto_increment,
  `serviceproperty_service` varchar(255) NOT NULL,
  `serviceproperty_property` varchar(255) NOT NULL,
  `serviceproperty_entity_id` int(8) NOT NULL,
  `serviceproperty_value` text,
  PRIMARY KEY  (`serviceproperty_id`),
  KEY `serviceproperty_service_key` (`serviceproperty_service`),
  KEY `serviceproperty_property_key` (`serviceproperty_property`),
  KEY `serviceproperty_entity_id_entity_id_fkey` (`serviceproperty_entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `P_ServiceProperty`
--

LOCK TABLES `P_ServiceProperty` WRITE;
/*!40000 ALTER TABLE `P_ServiceProperty` DISABLE KEYS */;
/*!40000 ALTER TABLE `P_ServiceProperty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `P_UGroup`
--

DROP TABLE IF EXISTS `P_UGroup`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `P_UGroup` (
  `group_id` int(8) NOT NULL auto_increment,
  `group_domain_id` int(8) NOT NULL,
  `group_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `group_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `group_userupdate` int(8) default NULL,
  `group_usercreate` int(8) default NULL,
  `group_system` int(1) default '0',
  `group_archive` int(1) NOT NULL default '0',
  `group_privacy` int(2) default '0',
  `group_local` int(1) default '1',
  `group_ext_id` varchar(24) default NULL,
  `group_samba` int(1) default '0',
  `group_gid` int(8) default NULL,
  `group_mailing` int(1) default '0',
  `group_delegation` varchar(64) default '',
  `group_manager_id` int(8) default NULL,
  `group_name` varchar(255) NOT NULL,
  `group_desc` varchar(128) default NULL,
  `group_email` varchar(128) default NULL,
  `group_contacts` text,
  PRIMARY KEY  (`group_id`),
  UNIQUE KEY `group_gid` (`group_gid`),
  KEY `group_domain_id_domain_id_fkey` (`group_domain_id`),
  KEY `group_userupdate_userobm_id_fkey` (`group_userupdate`),
  KEY `group_usercreate_userobm_id_fkey` (`group_usercreate`),
  KEY `group_manager_id_userobm_id_fkey` (`group_manager_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `P_UGroup`
--

LOCK TABLES `P_UGroup` WRITE;
/*!40000 ALTER TABLE `P_UGroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `P_UGroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `P_UserEntity`
--

DROP TABLE IF EXISTS `P_UserEntity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `P_UserEntity` (
  `userentity_entity_id` int(8) NOT NULL,
  `userentity_user_id` int(8) NOT NULL,
  PRIMARY KEY  (`userentity_entity_id`,`userentity_user_id`),
  KEY `userentity_user_id_user_id_fkey` (`userentity_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `P_UserEntity`
--

LOCK TABLES `P_UserEntity` WRITE;
/*!40000 ALTER TABLE `P_UserEntity` DISABLE KEYS */;
/*!40000 ALTER TABLE `P_UserEntity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `P_UserObm`
--

DROP TABLE IF EXISTS `P_UserObm`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `P_UserObm` (
  `userobm_id` int(8) NOT NULL auto_increment,
  `userobm_domain_id` int(8) default NULL,
  `userobm_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `userobm_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `userobm_userupdate` int(8) default NULL,
  `userobm_usercreate` int(8) default NULL,
  `userobm_local` int(1) default '1',
  `userobm_ext_id` varchar(16) default NULL,
  `userobm_system` int(1) default '0',
  `userobm_archive` int(1) NOT NULL default '0',
  `userobm_timelastaccess` timestamp NOT NULL default '0000-00-00 00:00:00',
  `userobm_login` varchar(32) NOT NULL default '',
  `userobm_nb_login_failed` int(2) default '0',
  `userobm_password_type` char(6) NOT NULL default 'PLAIN',
  `userobm_password` varchar(64) NOT NULL default '',
  `userobm_password_dateexp` date default NULL,
  `userobm_account_dateexp` date default NULL,
  `userobm_perms` varchar(254) default NULL,
  `userobm_delegation_target` varchar(64) default '',
  `userobm_delegation` varchar(64) default '',
  `userobm_calendar_version` timestamp NOT NULL default '0000-00-00 00:00:00',
  `userobm_uid` int(8) default NULL,
  `userobm_gid` int(8) default NULL,
  `userobm_datebegin` date default NULL,
  `userobm_hidden` int(1) default '0',
  `userobm_kind` varchar(12) default NULL,
  `userobm_lastname` varchar(64) default '',
  `userobm_firstname` varchar(64) default '',
  `userobm_title` varchar(64) default '',
  `userobm_sound` varchar(64) default NULL,
  `userobm_company` varchar(64) default NULL,
  `userobm_direction` varchar(64) default NULL,
  `userobm_service` varchar(64) default NULL,
  `userobm_address1` varchar(64) default NULL,
  `userobm_address2` varchar(64) default NULL,
  `userobm_address3` varchar(64) default NULL,
  `userobm_zipcode` varchar(14) default NULL,
  `userobm_town` varchar(64) default NULL,
  `userobm_expresspostal` varchar(16) default NULL,
  `userobm_country_iso3166` char(2) default '0',
  `userobm_phone` varchar(32) default '',
  `userobm_phone2` varchar(32) default '',
  `userobm_mobile` varchar(32) default '',
  `userobm_fax` varchar(32) default '',
  `userobm_fax2` varchar(32) default '',
  `userobm_web_perms` int(1) default '0',
  `userobm_web_list` text,
  `userobm_web_all` int(1) default '0',
  `userobm_mail_perms` int(1) default '0',
  `userobm_mail_ext_perms` int(1) default '0',
  `userobm_email` text,
  `userobm_mail_server_id` int(8) default NULL,
  `userobm_mail_quota` int(8) default '0',
  `userobm_mail_quota_use` int(8) default '0',
  `userobm_mail_login_date` timestamp NOT NULL default '0000-00-00 00:00:00',
  `userobm_nomade_perms` int(1) default '0',
  `userobm_nomade_enable` int(1) default '0',
  `userobm_nomade_local_copy` int(1) default '0',
  `userobm_nomade_datebegin` timestamp NOT NULL default '0000-00-00 00:00:00',
  `userobm_nomade_dateend` timestamp NOT NULL default '0000-00-00 00:00:00',
  `userobm_email_nomade` text,
  `userobm_vacation_enable` int(1) default '0',
  `userobm_vacation_datebegin` timestamp NOT NULL default '0000-00-00 00:00:00',
  `userobm_vacation_dateend` timestamp NOT NULL default '0000-00-00 00:00:00',
  `userobm_vacation_message` text,
  `userobm_samba_perms` int(1) default '0',
  `userobm_samba_home` varchar(255) default '',
  `userobm_samba_home_drive` char(2) default '',
  `userobm_samba_logon_script` varchar(128) default '',
  `userobm_host_id` int(8) default NULL,
  `userobm_description` varchar(255) default NULL,
  `userobm_location` varchar(255) default NULL,
  `userobm_education` varchar(255) default NULL,
  `userobm_photo_id` int(8) default NULL,
  PRIMARY KEY  (`userobm_id`),
  KEY `k_login_user` (`userobm_login`),
  KEY `k_uid_user` (`userobm_uid`),
  KEY `userobm_domain_id_domain_id_fkey` (`userobm_domain_id`),
  KEY `userobm_userupdate_userobm_id_fkey` (`userobm_userupdate`),
  KEY `userobm_usercreate_userobm_id_fkey` (`userobm_usercreate`),
  KEY `userobm_mail_server_id_mailserver_id_fkey` (`userobm_mail_server_id`),
  KEY `userobm_host_id_host_id_fkey` (`userobm_host_id`),
  KEY `userobm_photo_id_document_id_fkey` (`userobm_photo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `P_UserObm`
--

LOCK TABLES `P_UserObm` WRITE;
/*!40000 ALTER TABLE `P_UserObm` DISABLE KEYS */;
/*!40000 ALTER TABLE `P_UserObm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `P_of_usergroup`
--

DROP TABLE IF EXISTS `P_of_usergroup`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `P_of_usergroup` (
  `of_usergroup_group_id` int(8) NOT NULL,
  `of_usergroup_user_id` int(8) NOT NULL,
  PRIMARY KEY  (`of_usergroup_group_id`,`of_usergroup_user_id`),
  KEY `of_usergroup_user_id_userobm_id_fkey` (`of_usergroup_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `P_of_usergroup`
--

LOCK TABLES `P_of_usergroup` WRITE;
/*!40000 ALTER TABLE `P_of_usergroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `P_of_usergroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ParentDeal`
--

DROP TABLE IF EXISTS `ParentDeal`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ParentDeal` (
  `parentdeal_id` int(8) NOT NULL auto_increment,
  `parentdeal_domain_id` int(8) NOT NULL,
  `parentdeal_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `parentdeal_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `parentdeal_userupdate` int(8) default NULL,
  `parentdeal_usercreate` int(8) default NULL,
  `parentdeal_label` varchar(128) NOT NULL,
  `parentdeal_marketingmanager_id` int(8) default NULL,
  `parentdeal_technicalmanager_id` int(8) default NULL,
  `parentdeal_archive` char(1) default '0',
  `parentdeal_comment` text,
  PRIMARY KEY  (`parentdeal_id`),
  KEY `parentdeal_domain_id_domain_id_fkey` (`parentdeal_domain_id`),
  KEY `parentdeal_userupdate_userobm_id_fkey` (`parentdeal_userupdate`),
  KEY `parentdeal_usercreate_userobm_id_fkey` (`parentdeal_usercreate`),
  KEY `parentdeal_marketingmanager_id_userobm_id_fkey` (`parentdeal_marketingmanager_id`),
  KEY `parentdeal_technicalmanager_id_userobm_id_fkey` (`parentdeal_technicalmanager_id`),
  CONSTRAINT `parentdeal_technicalmanager_id_userobm_id_fkey` FOREIGN KEY (`parentdeal_technicalmanager_id`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `parentdeal_domain_id_domain_id_fkey` FOREIGN KEY (`parentdeal_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parentdeal_marketingmanager_id_userobm_id_fkey` FOREIGN KEY (`parentdeal_marketingmanager_id`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `parentdeal_usercreate_userobm_id_fkey` FOREIGN KEY (`parentdeal_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `parentdeal_userupdate_userobm_id_fkey` FOREIGN KEY (`parentdeal_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ParentDeal`
--

LOCK TABLES `ParentDeal` WRITE;
/*!40000 ALTER TABLE `ParentDeal` DISABLE KEYS */;
/*!40000 ALTER TABLE `ParentDeal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ParentdealEntity`
--

DROP TABLE IF EXISTS `ParentdealEntity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ParentdealEntity` (
  `parentdealentity_entity_id` int(8) NOT NULL,
  `parentdealentity_parentdeal_id` int(8) NOT NULL,
  PRIMARY KEY  (`parentdealentity_entity_id`,`parentdealentity_parentdeal_id`),
  KEY `parentdealentity_parentdeal_id_parentdeal_id_fkey` (`parentdealentity_parentdeal_id`),
  CONSTRAINT `parentdealentity_parentdeal_id_parentdeal_id_fkey` FOREIGN KEY (`parentdealentity_parentdeal_id`) REFERENCES `ParentDeal` (`parentdeal_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parentdealentity_entity_id_entity_id_fkey` FOREIGN KEY (`parentdealentity_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ParentdealEntity`
--

LOCK TABLES `ParentdealEntity` WRITE;
/*!40000 ALTER TABLE `ParentdealEntity` DISABLE KEYS */;
/*!40000 ALTER TABLE `ParentdealEntity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Payment`
--

DROP TABLE IF EXISTS `Payment`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `Payment` (
  `payment_id` int(8) NOT NULL auto_increment,
  `payment_domain_id` int(8) NOT NULL,
  `payment_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `payment_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `payment_userupdate` int(8) default NULL,
  `payment_usercreate` int(8) default NULL,
  `payment_company_id` int(8) default NULL,
  `payment_account_id` int(8) default NULL,
  `payment_paymentkind_id` int(8) default NULL,
  `payment_amount` double(10,2) NOT NULL default '0.00',
  `payment_date` date default NULL,
  `payment_inout` char(1) NOT NULL default '+',
  `payment_number` varchar(24) default '',
  `payment_checked` char(1) NOT NULL default '0',
  `payment_gap` double(10,2) NOT NULL default '0.00',
  `payment_comment` text,
  PRIMARY KEY  (`payment_id`),
  KEY `payment_domain_id_domain_id_fkey` (`payment_domain_id`),
  KEY `payment_account_id_account_id_fkey` (`payment_account_id`),
  KEY `payment_userupdate_userobm_id_fkey` (`payment_userupdate`),
  KEY `payment_usercreate_userobm_id_fkey` (`payment_usercreate`),
  KEY `payment_company_id_company_id_fkey` (`payment_company_id`),
  KEY `payment_paymentkind_id_paymentkind_id_fkey` (`payment_paymentkind_id`),
  CONSTRAINT `payment_paymentkind_id_paymentkind_id_fkey` FOREIGN KEY (`payment_paymentkind_id`) REFERENCES `PaymentKind` (`paymentkind_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `payment_account_id_account_id_fkey` FOREIGN KEY (`payment_account_id`) REFERENCES `Account` (`account_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `payment_company_id_company_id_fkey` FOREIGN KEY (`payment_company_id`) REFERENCES `Company` (`company_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `payment_domain_id_domain_id_fkey` FOREIGN KEY (`payment_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `payment_usercreate_userobm_id_fkey` FOREIGN KEY (`payment_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `payment_userupdate_userobm_id_fkey` FOREIGN KEY (`payment_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `Payment`
--

LOCK TABLES `Payment` WRITE;
/*!40000 ALTER TABLE `Payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `Payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PaymentEntity`
--

DROP TABLE IF EXISTS `PaymentEntity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `PaymentEntity` (
  `paymententity_entity_id` int(8) NOT NULL,
  `paymententity_payment_id` int(8) NOT NULL,
  PRIMARY KEY  (`paymententity_entity_id`,`paymententity_payment_id`),
  KEY `paymententity_payment_id_payment_id_fkey` (`paymententity_payment_id`),
  CONSTRAINT `paymententity_payment_id_payment_id_fkey` FOREIGN KEY (`paymententity_payment_id`) REFERENCES `Payment` (`payment_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `paymententity_entity_id_entity_id_fkey` FOREIGN KEY (`paymententity_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `PaymentEntity`
--

LOCK TABLES `PaymentEntity` WRITE;
/*!40000 ALTER TABLE `PaymentEntity` DISABLE KEYS */;
/*!40000 ALTER TABLE `PaymentEntity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PaymentInvoice`
--

DROP TABLE IF EXISTS `PaymentInvoice`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `PaymentInvoice` (
  `paymentinvoice_invoice_id` int(8) NOT NULL,
  `paymentinvoice_payment_id` int(8) NOT NULL,
  `paymentinvoice_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `paymentinvoice_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `paymentinvoice_userupdate` int(8) default NULL,
  `paymentinvoice_usercreate` int(8) default NULL,
  `paymentinvoice_amount` double(10,2) NOT NULL default '0.00',
  PRIMARY KEY  (`paymentinvoice_invoice_id`,`paymentinvoice_payment_id`),
  KEY `paymentinvoice_payment_id_payment_id_fkey` (`paymentinvoice_payment_id`),
  KEY `paymentinvoice_usercreate_userobm_id_fkey` (`paymentinvoice_usercreate`),
  KEY `paymentinvoice_userupdate_userobm_id_fkey` (`paymentinvoice_userupdate`),
  CONSTRAINT `paymentinvoice_userupdate_userobm_id_fkey` FOREIGN KEY (`paymentinvoice_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `paymentinvoice_invoice_id_invoice_id_fkey` FOREIGN KEY (`paymentinvoice_invoice_id`) REFERENCES `Invoice` (`invoice_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `paymentinvoice_payment_id_payment_id_fkey` FOREIGN KEY (`paymentinvoice_payment_id`) REFERENCES `Payment` (`payment_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `paymentinvoice_usercreate_userobm_id_fkey` FOREIGN KEY (`paymentinvoice_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `PaymentInvoice`
--

LOCK TABLES `PaymentInvoice` WRITE;
/*!40000 ALTER TABLE `PaymentInvoice` DISABLE KEYS */;
/*!40000 ALTER TABLE `PaymentInvoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PaymentKind`
--

DROP TABLE IF EXISTS `PaymentKind`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `PaymentKind` (
  `paymentkind_id` int(8) NOT NULL auto_increment,
  `paymentkind_domain_id` int(8) NOT NULL,
  `paymentkind_shortlabel` varchar(3) NOT NULL default '',
  `paymentkind_label` varchar(40) NOT NULL default '',
  PRIMARY KEY  (`paymentkind_id`),
  KEY `paymentkind_domain_id_domain_id_fkey` (`paymentkind_domain_id`),
  CONSTRAINT `paymentkind_domain_id_domain_id_fkey` FOREIGN KEY (`paymentkind_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `PaymentKind`
--

LOCK TABLES `PaymentKind` WRITE;
/*!40000 ALTER TABLE `PaymentKind` DISABLE KEYS */;
INSERT INTO `PaymentKind` VALUES (1,1,'Ch','Chèque'),(2,1,'Vir','Virement'),(3,1,'TIP','Titre Interbancaire de Paiement'),(4,1,'PA','Prélèvement Automatique'),(5,1,'FrB','Frais bancaires'),(6,1,'BAO','Billet à ordre'),(7,1,'LC','Lettre de change'),(8,1,'CB','Carte de crédit');
/*!40000 ALTER TABLE `PaymentKind` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Phone`
--

DROP TABLE IF EXISTS `Phone`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `Phone` (
  `phone_id` int(8) NOT NULL auto_increment,
  `phone_entity_id` int(8) NOT NULL,
  `phone_label` varchar(255) NOT NULL,
  `phone_number` varchar(32) default NULL,
  PRIMARY KEY  (`phone_id`),
  KEY `phone_entity_id_entity_id_fkey` (`phone_entity_id`),
  CONSTRAINT `phone_entity_id_entity_id_fkey` FOREIGN KEY (`phone_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `Phone`
--

LOCK TABLES `Phone` WRITE;
/*!40000 ALTER TABLE `Phone` DISABLE KEYS */;
/*!40000 ALTER TABLE `Phone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Profile`
--

DROP TABLE IF EXISTS `Profile`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `Profile` (
  `profile_id` int(8) NOT NULL auto_increment,
  `profile_domain_id` int(8) NOT NULL,
  `profile_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `profile_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `profile_userupdate` int(8) default NULL,
  `profile_usercreate` int(8) default NULL,
  `profile_name` varchar(64) default NULL,
  PRIMARY KEY  (`profile_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `Profile`
--

LOCK TABLES `Profile` WRITE;
/*!40000 ALTER TABLE `Profile` DISABLE KEYS */;
INSERT INTO `Profile` VALUES (1,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',1,1,'admin'),(2,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',1,1,'admin_delegue'),(3,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',1,1,'editor'),(4,1,'2008-12-17 14:00:31','2008-12-17 14:00:31',1,1,'user');
/*!40000 ALTER TABLE `Profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProfileEntity`
--

DROP TABLE IF EXISTS `ProfileEntity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ProfileEntity` (
  `profileentity_entity_id` int(8) NOT NULL,
  `profileentity_profile_id` int(8) NOT NULL,
  PRIMARY KEY  (`profileentity_entity_id`,`profileentity_profile_id`),
  KEY `profileentity_profile_id_profile_id_fkey` (`profileentity_profile_id`),
  CONSTRAINT `profileentity_profile_id_profile_id_fkey` FOREIGN KEY (`profileentity_profile_id`) REFERENCES `Profile` (`profile_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `profileentity_entity_id_entity_id_fkey` FOREIGN KEY (`profileentity_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ProfileEntity`
--

LOCK TABLES `ProfileEntity` WRITE;
/*!40000 ALTER TABLE `ProfileEntity` DISABLE KEYS */;
/*!40000 ALTER TABLE `ProfileEntity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProfileModule`
--

DROP TABLE IF EXISTS `ProfileModule`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ProfileModule` (
  `profilemodule_id` int(8) NOT NULL auto_increment,
  `profilemodule_domain_id` int(8) NOT NULL,
  `profilemodule_profile_id` int(8) default NULL,
  `profilemodule_module_name` varchar(64) NOT NULL default '',
  `profilemodule_right` int(2) default NULL,
  PRIMARY KEY  (`profilemodule_id`),
  KEY `profilemodule_profile_id_profile_id_fkey` (`profilemodule_profile_id`),
  CONSTRAINT `profilemodule_profile_id_profile_id_fkey` FOREIGN KEY (`profilemodule_profile_id`) REFERENCES `Profile` (`profile_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ProfileModule`
--

LOCK TABLES `ProfileModule` WRITE;
/*!40000 ALTER TABLE `ProfileModule` DISABLE KEYS */;
INSERT INTO `ProfileModule` VALUES (1,1,1,'default',29),(2,1,1,'domain',0),(3,1,2,'default',29),(4,1,2,'domain',0),(5,1,3,'default',5),(6,1,4,'default',0),(7,1,4,'calendar',5),(8,1,4,'mailbox',5);
/*!40000 ALTER TABLE `ProfileModule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProfileProperty`
--

DROP TABLE IF EXISTS `ProfileProperty`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ProfileProperty` (
  `profileproperty_id` int(8) NOT NULL auto_increment,
  `profileproperty_type` varchar(32) default NULL,
  `profileproperty_default` text,
  `profileproperty_readonly` int(1) default '0',
  `profileproperty_name` varchar(32) NOT NULL default '',
  PRIMARY KEY  (`profileproperty_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ProfileProperty`
--

LOCK TABLES `ProfileProperty` WRITE;
/*!40000 ALTER TABLE `ProfileProperty` DISABLE KEYS */;
INSERT INTO `ProfileProperty` VALUES (1,'integer','1',1,'update_state'),(2,'integer','3',0,'level'),(3,'integer','0',0,'level_managepeers'),(4,'text','ALLOW_ALL',0,'access_restriction'),(5,'text','',0,'admin_realm'),(6,'timestamp','0',1,'last_public_contact_export');
/*!40000 ALTER TABLE `ProfileProperty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProfilePropertyValue`
--

DROP TABLE IF EXISTS `ProfilePropertyValue`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ProfilePropertyValue` (
  `profilepropertyvalue_id` int(8) NOT NULL auto_increment,
  `profilepropertyvalue_profile_id` int(8) default NULL,
  `profilepropertyvalue_property_id` int(8) default NULL,
  `profilepropertyvalue_property_value` text NOT NULL,
  PRIMARY KEY  (`profilepropertyvalue_id`),
  KEY `profilepropertyvalue_profile_id_profile_id_fkey` (`profilepropertyvalue_profile_id`),
  KEY `profilepropertyvalue_profileproperty_id_profileproperty_id_fkey` (`profilepropertyvalue_property_id`),
  CONSTRAINT `profilepropertyvalue_profile_id_profile_id_fkey` FOREIGN KEY (`profilepropertyvalue_profile_id`) REFERENCES `Profile` (`profile_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `profilepropertyvalue_profileproperty_id_profileproperty_id_fkey` FOREIGN KEY (`profilepropertyvalue_property_id`) REFERENCES `ProfileProperty` (`profileproperty_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ProfilePropertyValue`
--

LOCK TABLES `ProfilePropertyValue` WRITE;
/*!40000 ALTER TABLE `ProfilePropertyValue` DISABLE KEYS */;
INSERT INTO `ProfilePropertyValue` VALUES (1,1,2,'1'),(2,1,3,'1'),(3,1,4,'ALLOW_ALL'),(4,1,5,'user delegation domain'),(5,2,2,'2'),(6,2,3,'1'),(7,2,4,'ALLOW_ALL'),(8,2,5,'user delegation'),(9,3,2,'3'),(10,3,3,'0'),(11,3,4,'ALLOW_ALL'),(12,3,5,''),(13,4,2,'4'),(14,4,3,'0'),(15,4,4,'ALLOW_ALL'),(16,4,5,'');
/*!40000 ALTER TABLE `ProfilePropertyValue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProfileSection`
--

DROP TABLE IF EXISTS `ProfileSection`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ProfileSection` (
  `profilesection_id` int(8) NOT NULL auto_increment,
  `profilesection_domain_id` int(8) NOT NULL,
  `profilesection_profile_id` int(8) default NULL,
  `profilesection_section_name` varchar(64) NOT NULL default '',
  `profilesection_show` tinyint(1) default NULL,
  PRIMARY KEY  (`profilesection_id`),
  KEY `profilesection_profile_id_profile_id_fkey` (`profilesection_profile_id`),
  CONSTRAINT `profilesection_profile_id_profile_id_fkey` FOREIGN KEY (`profilesection_profile_id`) REFERENCES `Profile` (`profile_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ProfileSection`
--

LOCK TABLES `ProfileSection` WRITE;
/*!40000 ALTER TABLE `ProfileSection` DISABLE KEYS */;
INSERT INTO `ProfileSection` VALUES (1,1,1,'default',1),(2,1,2,'default',1),(3,1,3,'default',0),(4,1,3,'com',1),(5,1,3,'prod',1),(6,1,3,'user',1),(7,1,3,'my',1),(8,1,4,'default',0),(9,1,4,'com',1),(10,1,4,'prod',1),(11,1,4,'user',1),(12,1,4,'my',1);
/*!40000 ALTER TABLE `ProfileSection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Project`
--

DROP TABLE IF EXISTS `Project`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `Project` (
  `project_id` int(8) NOT NULL auto_increment,
  `project_domain_id` int(8) NOT NULL,
  `project_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `project_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `project_userupdate` int(8) default NULL,
  `project_usercreate` int(8) default NULL,
  `project_name` varchar(128) default NULL,
  `project_shortname` varchar(10) default NULL,
  `project_type_id` int(8) default NULL,
  `project_tasktype_id` int(8) default NULL,
  `project_company_id` int(8) default NULL,
  `project_deal_id` int(8) default NULL,
  `project_soldtime` int(8) default NULL,
  `project_estimatedtime` int(8) default NULL,
  `project_datebegin` date default NULL,
  `project_dateend` date default NULL,
  `project_archive` char(1) default '0',
  `project_comment` text,
  `project_reference_date` varchar(32) default NULL,
  `project_reference_duration` varchar(16) default NULL,
  `project_reference_desc` text,
  `project_reference_tech` text,
  PRIMARY KEY  (`project_id`),
  KEY `project_idx_comp` (`project_company_id`),
  KEY `project_idx_deal` (`project_deal_id`),
  KEY `project_domain_id_domain_id_fkey` (`project_domain_id`),
  KEY `project_userupdate_userobm_id_fkey` (`project_userupdate`),
  KEY `project_usercreate_userobm_id_fkey` (`project_usercreate`),
  KEY `project_tasktype_id_tasktype_id_fkey` (`project_tasktype_id`),
  KEY `project_type_id_dealtype_id_fkey` (`project_type_id`),
  CONSTRAINT `project_type_id_dealtype_id_fkey` FOREIGN KEY (`project_type_id`) REFERENCES `DealType` (`dealtype_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `project_company_id_company_id_fkey` FOREIGN KEY (`project_company_id`) REFERENCES `Company` (`company_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `project_deal_id_deal_id_fkey` FOREIGN KEY (`project_deal_id`) REFERENCES `Deal` (`deal_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `project_domain_id_domain_id_fkey` FOREIGN KEY (`project_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `project_tasktype_id_tasktype_id_fkey` FOREIGN KEY (`project_tasktype_id`) REFERENCES `TaskType` (`tasktype_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `project_usercreate_userobm_id_fkey` FOREIGN KEY (`project_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `project_userupdate_userobm_id_fkey` FOREIGN KEY (`project_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `Project`
--

LOCK TABLES `Project` WRITE;
/*!40000 ALTER TABLE `Project` DISABLE KEYS */;
/*!40000 ALTER TABLE `Project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProjectCV`
--

DROP TABLE IF EXISTS `ProjectCV`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ProjectCV` (
  `projectcv_project_id` int(8) NOT NULL,
  `projectcv_cv_id` int(8) NOT NULL,
  `projectcv_role` varchar(128) default '',
  PRIMARY KEY  (`projectcv_project_id`,`projectcv_cv_id`),
  KEY `projectcv_cv_id_cv_id_fkey` (`projectcv_cv_id`),
  CONSTRAINT `projectcv_cv_id_cv_id_fkey` FOREIGN KEY (`projectcv_cv_id`) REFERENCES `CV` (`cv_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `projectcv_project_id_project_id_fkey` FOREIGN KEY (`projectcv_project_id`) REFERENCES `Project` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ProjectCV`
--

LOCK TABLES `ProjectCV` WRITE;
/*!40000 ALTER TABLE `ProjectCV` DISABLE KEYS */;
/*!40000 ALTER TABLE `ProjectCV` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProjectClosing`
--

DROP TABLE IF EXISTS `ProjectClosing`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ProjectClosing` (
  `projectclosing_id` int(8) NOT NULL auto_increment,
  `projectclosing_project_id` int(8) NOT NULL,
  `projectclosing_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `projectclosing_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `projectclosing_userupdate` int(8) default NULL,
  `projectclosing_usercreate` int(8) default NULL,
  `projectclosing_date` timestamp NOT NULL default '0000-00-00 00:00:00',
  `projectclosing_used` int(8) NOT NULL,
  `projectclosing_remaining` int(8) NOT NULL,
  `projectclosing_type` int(8) default NULL,
  `projectclosing_comment` text,
  PRIMARY KEY  (`projectclosing_id`),
  KEY `projectclosing_project_id_project_id_fkey` (`projectclosing_project_id`),
  KEY `projectclosing_userupdate_userobm_id_fkey` (`projectclosing_userupdate`),
  KEY `projectclosing_usercreate_userobm_id_fkey` (`projectclosing_usercreate`),
  CONSTRAINT `projectclosing_usercreate_userobm_id_fkey` FOREIGN KEY (`projectclosing_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `projectclosing_project_id_project_id_fkey` FOREIGN KEY (`projectclosing_project_id`) REFERENCES `Project` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `projectclosing_userupdate_userobm_id_fkey` FOREIGN KEY (`projectclosing_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ProjectClosing`
--

LOCK TABLES `ProjectClosing` WRITE;
/*!40000 ALTER TABLE `ProjectClosing` DISABLE KEYS */;
/*!40000 ALTER TABLE `ProjectClosing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProjectEntity`
--

DROP TABLE IF EXISTS `ProjectEntity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ProjectEntity` (
  `projectentity_entity_id` int(8) NOT NULL,
  `projectentity_project_id` int(8) NOT NULL,
  PRIMARY KEY  (`projectentity_entity_id`,`projectentity_project_id`),
  KEY `projectentity_project_id_project_id_fkey` (`projectentity_project_id`),
  CONSTRAINT `projectentity_project_id_project_id_fkey` FOREIGN KEY (`projectentity_project_id`) REFERENCES `Project` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `projectentity_entity_id_entity_id_fkey` FOREIGN KEY (`projectentity_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ProjectEntity`
--

LOCK TABLES `ProjectEntity` WRITE;
/*!40000 ALTER TABLE `ProjectEntity` DISABLE KEYS */;
/*!40000 ALTER TABLE `ProjectEntity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProjectRefTask`
--

DROP TABLE IF EXISTS `ProjectRefTask`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ProjectRefTask` (
  `projectreftask_id` int(8) NOT NULL auto_increment,
  `projectreftask_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `projectreftask_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `projectreftask_userupdate` int(8) default NULL,
  `projectreftask_usercreate` int(8) default NULL,
  `projectreftask_tasktype_id` int(8) default NULL,
  `projectreftask_label` varchar(128) default NULL,
  PRIMARY KEY  (`projectreftask_id`),
  KEY `projectreftask_tasktype_id_tasktype_id_fkey` (`projectreftask_tasktype_id`),
  KEY `projectreftask_userupdate_userobm_id_fkey` (`projectreftask_userupdate`),
  KEY `projectreftask_usercreate_userobm_id_fkey` (`projectreftask_usercreate`),
  CONSTRAINT `projectreftask_usercreate_userobm_id_fkey` FOREIGN KEY (`projectreftask_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `projectreftask_tasktype_id_tasktype_id_fkey` FOREIGN KEY (`projectreftask_tasktype_id`) REFERENCES `TaskType` (`tasktype_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `projectreftask_userupdate_userobm_id_fkey` FOREIGN KEY (`projectreftask_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ProjectRefTask`
--

LOCK TABLES `ProjectRefTask` WRITE;
/*!40000 ALTER TABLE `ProjectRefTask` DISABLE KEYS */;
/*!40000 ALTER TABLE `ProjectRefTask` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProjectTask`
--

DROP TABLE IF EXISTS `ProjectTask`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ProjectTask` (
  `projecttask_id` int(8) NOT NULL auto_increment,
  `projecttask_project_id` int(8) NOT NULL,
  `projecttask_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `projecttask_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `projecttask_userupdate` int(8) default NULL,
  `projecttask_usercreate` int(8) default NULL,
  `projecttask_label` varchar(128) default NULL,
  `projecttask_parenttask_id` int(8) default NULL,
  `projecttask_rank` int(8) default NULL,
  `projecttask_datebegin` date default NULL,
  `projecttask_dateend` date default NULL,
  PRIMARY KEY  (`projecttask_id`),
  KEY `pt_idx_pro` (`projecttask_project_id`),
  KEY `projecttask_parenttask_id_projecttask_id_fkey` (`projecttask_parenttask_id`),
  KEY `projecttask_userupdate_userobm_id_fkey` (`projecttask_userupdate`),
  KEY `projecttask_usercreate_userobm_id_fkey` (`projecttask_usercreate`),
  CONSTRAINT `projecttask_usercreate_userobm_id_fkey` FOREIGN KEY (`projecttask_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `projecttask_parenttask_id_projecttask_id_fkey` FOREIGN KEY (`projecttask_parenttask_id`) REFERENCES `ProjectTask` (`projecttask_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `projecttask_project_id_project_id_fkey` FOREIGN KEY (`projecttask_project_id`) REFERENCES `Project` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `projecttask_userupdate_userobm_id_fkey` FOREIGN KEY (`projecttask_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ProjectTask`
--

LOCK TABLES `ProjectTask` WRITE;
/*!40000 ALTER TABLE `ProjectTask` DISABLE KEYS */;
/*!40000 ALTER TABLE `ProjectTask` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProjectUser`
--

DROP TABLE IF EXISTS `ProjectUser`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ProjectUser` (
  `projectuser_id` int(8) NOT NULL auto_increment,
  `projectuser_project_id` int(8) NOT NULL,
  `projectuser_user_id` int(8) NOT NULL,
  `projectuser_projecttask_id` int(8) default NULL,
  `projectuser_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `projectuser_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `projectuser_userupdate` int(8) default NULL,
  `projectuser_usercreate` int(8) default NULL,
  `projectuser_projectedtime` float default NULL,
  `projectuser_missingtime` float default NULL,
  `projectuser_validity` timestamp NOT NULL default '0000-00-00 00:00:00',
  `projectuser_soldprice` int(8) default NULL,
  `projectuser_manager` int(1) default NULL,
  PRIMARY KEY  (`projectuser_id`),
  KEY `pu_idx_pro` (`projectuser_project_id`),
  KEY `pu_idx_user` (`projectuser_user_id`),
  KEY `pu_idx_pt` (`projectuser_projecttask_id`),
  KEY `projectuser_userupdate_userobm_id_fkey` (`projectuser_userupdate`),
  KEY `projectuser_usercreate_userobm_id_fkey` (`projectuser_usercreate`),
  CONSTRAINT `projectuser_usercreate_userobm_id_fkey` FOREIGN KEY (`projectuser_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `projectuser_project_id_project_id_fkey` FOREIGN KEY (`projectuser_project_id`) REFERENCES `Project` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `projectuser_userupdate_userobm_id_fkey` FOREIGN KEY (`projectuser_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `projectuser_user_id_userobm_id_fkey` FOREIGN KEY (`projectuser_user_id`) REFERENCES `UserObm` (`userobm_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ProjectUser`
--

LOCK TABLES `ProjectUser` WRITE;
/*!40000 ALTER TABLE `ProjectUser` DISABLE KEYS */;
/*!40000 ALTER TABLE `ProjectUser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Publication`
--

DROP TABLE IF EXISTS `Publication`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `Publication` (
  `publication_id` int(8) NOT NULL auto_increment,
  `publication_domain_id` int(8) NOT NULL,
  `publication_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `publication_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `publication_userupdate` int(8) default NULL,
  `publication_usercreate` int(8) default NULL,
  `publication_title` varchar(64) NOT NULL,
  `publication_type_id` int(8) default NULL,
  `publication_year` int(4) default NULL,
  `publication_lang` varchar(30) default NULL,
  `publication_desc` text,
  PRIMARY KEY  (`publication_id`),
  KEY `publication_domain_id_domain_id_fkey` (`publication_domain_id`),
  KEY `publication_userupdate_userobm_id_fkey` (`publication_userupdate`),
  KEY `publication_usercreate_userobm_id_fkey` (`publication_usercreate`),
  KEY `publication_type_id_publicationtype_id_fkey` (`publication_type_id`),
  CONSTRAINT `publication_type_id_publicationtype_id_fkey` FOREIGN KEY (`publication_type_id`) REFERENCES `PublicationType` (`publicationtype_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `publication_domain_id_domain_id_fkey` FOREIGN KEY (`publication_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `publication_usercreate_userobm_id_fkey` FOREIGN KEY (`publication_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `publication_userupdate_userobm_id_fkey` FOREIGN KEY (`publication_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `Publication`
--

LOCK TABLES `Publication` WRITE;
/*!40000 ALTER TABLE `Publication` DISABLE KEYS */;
/*!40000 ALTER TABLE `Publication` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PublicationEntity`
--

DROP TABLE IF EXISTS `PublicationEntity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `PublicationEntity` (
  `publicationentity_entity_id` int(8) NOT NULL,
  `publicationentity_publication_id` int(8) NOT NULL,
  PRIMARY KEY  (`publicationentity_entity_id`,`publicationentity_publication_id`),
  KEY `publicationentity_publication_id_publication_id_fkey` (`publicationentity_publication_id`),
  CONSTRAINT `publicationentity_publication_id_publication_id_fkey` FOREIGN KEY (`publicationentity_publication_id`) REFERENCES `Publication` (`publication_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `publicationentity_entity_id_entity_id_fkey` FOREIGN KEY (`publicationentity_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `PublicationEntity`
--

LOCK TABLES `PublicationEntity` WRITE;
/*!40000 ALTER TABLE `PublicationEntity` DISABLE KEYS */;
/*!40000 ALTER TABLE `PublicationEntity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PublicationType`
--

DROP TABLE IF EXISTS `PublicationType`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `PublicationType` (
  `publicationtype_id` int(8) NOT NULL auto_increment,
  `publicationtype_domain_id` int(8) NOT NULL,
  `publicationtype_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `publicationtype_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `publicationtype_userupdate` int(8) default NULL,
  `publicationtype_usercreate` int(8) default NULL,
  `publicationtype_code` varchar(10) default '',
  `publicationtype_label` varchar(64) default NULL,
  PRIMARY KEY  (`publicationtype_id`),
  KEY `publicationtype_domain_id_domain_id_fkey` (`publicationtype_domain_id`),
  KEY `publicationtype_userupdate_userobm_id_fkey` (`publicationtype_userupdate`),
  KEY `publicationtype_usercreate_userobm_id_fkey` (`publicationtype_usercreate`),
  CONSTRAINT `publicationtype_usercreate_userobm_id_fkey` FOREIGN KEY (`publicationtype_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `publicationtype_domain_id_domain_id_fkey` FOREIGN KEY (`publicationtype_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `publicationtype_userupdate_userobm_id_fkey` FOREIGN KEY (`publicationtype_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `PublicationType`
--

LOCK TABLES `PublicationType` WRITE;
/*!40000 ALTER TABLE `PublicationType` DISABLE KEYS */;
/*!40000 ALTER TABLE `PublicationType` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RGroup`
--

DROP TABLE IF EXISTS `RGroup`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `RGroup` (
  `rgroup_id` int(8) NOT NULL auto_increment,
  `rgroup_domain_id` int(8) NOT NULL,
  `rgroup_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `rgroup_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `rgroup_userupdate` int(8) default NULL,
  `rgroup_usercreate` int(8) default NULL,
  `rgroup_privacy` int(2) default '0',
  `rgroup_name` varchar(32) NOT NULL,
  `rgroup_desc` varchar(128) default NULL,
  PRIMARY KEY  (`rgroup_id`),
  KEY `rgroup_domain_id_domain_id_fkey` (`rgroup_domain_id`),
  KEY `rgroup_userupdate_userobm_id_fkey` (`rgroup_userupdate`),
  KEY `rgroup_usercreate_userobm_id_fkey` (`rgroup_usercreate`),
  CONSTRAINT `rgroup_usercreate_userobm_id_fkey` FOREIGN KEY (`rgroup_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `rgroup_domain_id_domain_id_fkey` FOREIGN KEY (`rgroup_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rgroup_userupdate_userobm_id_fkey` FOREIGN KEY (`rgroup_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `RGroup`
--

LOCK TABLES `RGroup` WRITE;
/*!40000 ALTER TABLE `RGroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `RGroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Region`
--

DROP TABLE IF EXISTS `Region`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `Region` (
  `region_id` int(8) NOT NULL auto_increment,
  `region_domain_id` int(8) NOT NULL,
  `region_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `region_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `region_userupdate` int(8) default NULL,
  `region_usercreate` int(8) default NULL,
  `region_code` varchar(10) default '',
  `region_label` varchar(64) default NULL,
  PRIMARY KEY  (`region_id`),
  KEY `region_domain_id_domain_id_fkey` (`region_domain_id`),
  KEY `region_userupdate_userobm_id_fkey` (`region_userupdate`),
  KEY `region_usercreate_userobm_id_fkey` (`region_usercreate`),
  CONSTRAINT `region_usercreate_userobm_id_fkey` FOREIGN KEY (`region_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `region_domain_id_domain_id_fkey` FOREIGN KEY (`region_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `region_userupdate_userobm_id_fkey` FOREIGN KEY (`region_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `Region`
--

LOCK TABLES `Region` WRITE;
/*!40000 ALTER TABLE `Region` DISABLE KEYS */;
/*!40000 ALTER TABLE `Region` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Resource`
--

DROP TABLE IF EXISTS `Resource`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `Resource` (
  `resource_id` int(8) NOT NULL auto_increment,
  `resource_domain_id` int(8) NOT NULL,
  `resource_rtype_id` int(8) default NULL,
  `resource_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `resource_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `resource_userupdate` int(8) default NULL,
  `resource_usercreate` int(8) default NULL,
  `resource_name` varchar(32) NOT NULL default '',
  `resource_delegation` varchar(64) default '',
  `resource_description` varchar(255) default NULL,
  `resource_qty` int(8) default '0',
  PRIMARY KEY  (`resource_id`),
  UNIQUE KEY `k_label_resource` (`resource_name`),
  KEY `resource_domain_id_domain_id_fkey` (`resource_domain_id`),
  KEY `resource_userupdate_userobm_id_fkey` (`resource_userupdate`),
  KEY `resource_usercreate_userobm_id_fkey` (`resource_usercreate`),
  KEY `resource_rtype_id_resourcetype_id_fkey` (`resource_rtype_id`),
  CONSTRAINT `resource_domain_id_domain_id_fkey` FOREIGN KEY (`resource_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `resource_userupdate_userobm_id_fkey` FOREIGN KEY (`resource_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `resource_usercreate_userobm_id_fkey` FOREIGN KEY (`resource_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `resource_rtype_id_resourcetype_id_fkey` FOREIGN KEY (`resource_rtype_id`) REFERENCES `ResourceType` (`resourcetype_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `Resource`
--

LOCK TABLES `Resource` WRITE;
/*!40000 ALTER TABLE `Resource` DISABLE KEYS */;
/*!40000 ALTER TABLE `Resource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ResourceEntity`
--

DROP TABLE IF EXISTS `ResourceEntity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ResourceEntity` (
  `resourceentity_entity_id` int(8) NOT NULL,
  `resourceentity_resource_id` int(8) NOT NULL,
  PRIMARY KEY  (`resourceentity_entity_id`,`resourceentity_resource_id`),
  KEY `resourceentity_resource_id_resource_id_fkey` (`resourceentity_resource_id`),
  CONSTRAINT `resourceentity_resource_id_resource_id_fkey` FOREIGN KEY (`resourceentity_resource_id`) REFERENCES `Resource` (`resource_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `resourceentity_entity_id_entity_id_fkey` FOREIGN KEY (`resourceentity_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ResourceEntity`
--

LOCK TABLES `ResourceEntity` WRITE;
/*!40000 ALTER TABLE `ResourceEntity` DISABLE KEYS */;
/*!40000 ALTER TABLE `ResourceEntity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ResourceGroup`
--

DROP TABLE IF EXISTS `ResourceGroup`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ResourceGroup` (
  `resourcegroup_rgroup_id` int(8) NOT NULL,
  `resourcegroup_resource_id` int(8) NOT NULL,
  KEY `resourcegroup_rgroup_id_rgroup_id_fkey` (`resourcegroup_rgroup_id`),
  KEY `resourcegroup_resource_id_resource_id_fkey` (`resourcegroup_resource_id`),
  CONSTRAINT `resourcegroup_resource_id_resource_id_fkey` FOREIGN KEY (`resourcegroup_resource_id`) REFERENCES `Resource` (`resource_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `resourcegroup_rgroup_id_rgroup_id_fkey` FOREIGN KEY (`resourcegroup_rgroup_id`) REFERENCES `RGroup` (`rgroup_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ResourceGroup`
--

LOCK TABLES `ResourceGroup` WRITE;
/*!40000 ALTER TABLE `ResourceGroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `ResourceGroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ResourceItem`
--

DROP TABLE IF EXISTS `ResourceItem`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ResourceItem` (
  `resourceitem_id` int(8) NOT NULL auto_increment,
  `resourceitem_domain_id` int(8) NOT NULL,
  `resourceitem_label` varchar(32) NOT NULL,
  `resourceitem_resourcetype_id` int(8) NOT NULL,
  `resourceitem_description` text,
  PRIMARY KEY  (`resourceitem_id`),
  KEY `resourceitem_domain_id_domain_id_fkey` (`resourceitem_domain_id`),
  KEY `resourceitem_resourcetype_id_resourcetype_id_fkey` (`resourceitem_resourcetype_id`),
  CONSTRAINT `resourceitem_resourcetype_id_resourcetype_id_fkey` FOREIGN KEY (`resourceitem_resourcetype_id`) REFERENCES `ResourceType` (`resourcetype_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `resourceitem_domain_id_domain_id_fkey` FOREIGN KEY (`resourceitem_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ResourceItem`
--

LOCK TABLES `ResourceItem` WRITE;
/*!40000 ALTER TABLE `ResourceItem` DISABLE KEYS */;
/*!40000 ALTER TABLE `ResourceItem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ResourceType`
--

DROP TABLE IF EXISTS `ResourceType`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ResourceType` (
  `resourcetype_id` int(8) NOT NULL auto_increment,
  `resourcetype_domain_id` int(8) NOT NULL,
  `resourcetype_label` varchar(32) NOT NULL,
  `resourcetype_property` varchar(32) default NULL,
  `resourcetype_pkind` int(1) NOT NULL default '0',
  PRIMARY KEY  (`resourcetype_id`),
  KEY `resourcetype_domain_id_domain_id_fkey` (`resourcetype_domain_id`),
  CONSTRAINT `resourcetype_domain_id_domain_id_fkey` FOREIGN KEY (`resourcetype_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ResourceType`
--

LOCK TABLES `ResourceType` WRITE;
/*!40000 ALTER TABLE `ResourceType` DISABLE KEYS */;
/*!40000 ALTER TABLE `ResourceType` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ResourcegroupEntity`
--

DROP TABLE IF EXISTS `ResourcegroupEntity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ResourcegroupEntity` (
  `resourcegroupentity_entity_id` int(8) NOT NULL,
  `resourcegroupentity_resourcegroup_id` int(8) NOT NULL,
  PRIMARY KEY  (`resourcegroupentity_entity_id`,`resourcegroupentity_resourcegroup_id`),
  KEY `resourcegroupentity_resourcegroup_id_resourcegroup_id_fkey` (`resourcegroupentity_resourcegroup_id`),
  CONSTRAINT `resourcegroupentity_resourcegroup_id_resourcegroup_id_fkey` FOREIGN KEY (`resourcegroupentity_resourcegroup_id`) REFERENCES `RGroup` (`rgroup_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `resourcegroupentity_entity_id_entity_id_fkey` FOREIGN KEY (`resourcegroupentity_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ResourcegroupEntity`
--

LOCK TABLES `ResourcegroupEntity` WRITE;
/*!40000 ALTER TABLE `ResourcegroupEntity` DISABLE KEYS */;
/*!40000 ALTER TABLE `ResourcegroupEntity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SSOTicket`
--

DROP TABLE IF EXISTS `SSOTicket`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `SSOTicket` (
  `ssoticket_ticket` varchar(255) NOT NULL,
  `ssoticket_user_id` int(8) default NULL,
  `ssoticket_timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`ssoticket_ticket`),
  KEY `ssoticket_user_id_userobm_id_fkey` (`ssoticket_user_id`),
  CONSTRAINT `ssoticket_user_id_userobm_id_fkey` FOREIGN KEY (`ssoticket_user_id`) REFERENCES `UserObm` (`userobm_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `SSOTicket`
--

LOCK TABLES `SSOTicket` WRITE;
/*!40000 ALTER TABLE `SSOTicket` DISABLE KEYS */;
/*!40000 ALTER TABLE `SSOTicket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Service`
--

DROP TABLE IF EXISTS `Service`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `Service` (
  `service_id` int(8) NOT NULL auto_increment,
  `service_service` varchar(255) NOT NULL,
  `service_entity_id` int(8) NOT NULL,
  PRIMARY KEY  (`service_id`),
  KEY `service_service_key` (`service_service`),
  KEY `service_entity_id_entity_id_fkey` (`service_entity_id`),
  CONSTRAINT `service_entity_id_entity_id_fkey` FOREIGN KEY (`service_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `Service`
--

LOCK TABLES `Service` WRITE;
/*!40000 ALTER TABLE `Service` DISABLE KEYS */;
/*!40000 ALTER TABLE `Service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ServiceProperty`
--

DROP TABLE IF EXISTS `ServiceProperty`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ServiceProperty` (
  `serviceproperty_id` int(8) NOT NULL auto_increment,
  `serviceproperty_service` varchar(255) NOT NULL,
  `serviceproperty_property` varchar(255) NOT NULL,
  `serviceproperty_entity_id` int(8) NOT NULL,
  `serviceproperty_value` text,
  PRIMARY KEY  (`serviceproperty_id`),
  KEY `serviceproperty_service_key` (`serviceproperty_service`),
  KEY `serviceproperty_property_key` (`serviceproperty_property`),
  KEY `serviceproperty_entity_id_entity_id_fkey` (`serviceproperty_entity_id`),
  CONSTRAINT `serviceproperty_entity_id_entity_id_fkey` FOREIGN KEY (`serviceproperty_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ServiceProperty`
--

LOCK TABLES `ServiceProperty` WRITE;
/*!40000 ALTER TABLE `ServiceProperty` DISABLE KEYS */;
/*!40000 ALTER TABLE `ServiceProperty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Stats`
--

DROP TABLE IF EXISTS `Stats`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `Stats` (
  `stats_name` varchar(32) NOT NULL default '',
  `stats_value` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`stats_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `Stats`
--

LOCK TABLES `Stats` WRITE;
/*!40000 ALTER TABLE `Stats` DISABLE KEYS */;
/*!40000 ALTER TABLE `Stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Subscription`
--

DROP TABLE IF EXISTS `Subscription`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `Subscription` (
  `subscription_id` int(8) NOT NULL auto_increment,
  `subscription_domain_id` int(8) NOT NULL,
  `subscription_publication_id` int(8) NOT NULL,
  `subscription_contact_id` int(8) NOT NULL,
  `subscription_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `subscription_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `subscription_userupdate` int(8) default NULL,
  `subscription_usercreate` int(8) default NULL,
  `subscription_quantity` int(8) default NULL,
  `subscription_renewal` int(1) NOT NULL default '0',
  `subscription_reception_id` int(8) default NULL,
  `subscription_date_begin` timestamp NOT NULL default '0000-00-00 00:00:00',
  `subscription_date_end` timestamp NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`subscription_id`),
  KEY `subscription_domain_id_domain_id_fkey` (`subscription_domain_id`),
  KEY `subscription_publication_id_publication_id_fkey` (`subscription_publication_id`),
  KEY `subscription_contact_id_contact_id_fkey` (`subscription_contact_id`),
  KEY `subscription_userupdate_userobm_id_fkey` (`subscription_userupdate`),
  KEY `subscription_usercreate_userobm_id_fkey` (`subscription_usercreate`),
  KEY `subscription_reception_id_subscriptionreception_id_fkey` (`subscription_reception_id`),
  CONSTRAINT `subscription_reception_id_subscriptionreception_id_fkey` FOREIGN KEY (`subscription_reception_id`) REFERENCES `SubscriptionReception` (`subscriptionreception_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `subscription_contact_id_contact_id_fkey` FOREIGN KEY (`subscription_contact_id`) REFERENCES `Contact` (`contact_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `subscription_domain_id_domain_id_fkey` FOREIGN KEY (`subscription_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `subscription_publication_id_publication_id_fkey` FOREIGN KEY (`subscription_publication_id`) REFERENCES `Publication` (`publication_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `subscription_usercreate_userobm_id_fkey` FOREIGN KEY (`subscription_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `subscription_userupdate_userobm_id_fkey` FOREIGN KEY (`subscription_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `Subscription`
--

LOCK TABLES `Subscription` WRITE;
/*!40000 ALTER TABLE `Subscription` DISABLE KEYS */;
/*!40000 ALTER TABLE `Subscription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SubscriptionEntity`
--

DROP TABLE IF EXISTS `SubscriptionEntity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `SubscriptionEntity` (
  `subscriptionentity_entity_id` int(8) NOT NULL,
  `subscriptionentity_subscription_id` int(8) NOT NULL,
  PRIMARY KEY  (`subscriptionentity_entity_id`,`subscriptionentity_subscription_id`),
  KEY `subscriptionentity_subscription_id_subscription_id_fkey` (`subscriptionentity_subscription_id`),
  CONSTRAINT `subscriptionentity_subscription_id_subscription_id_fkey` FOREIGN KEY (`subscriptionentity_subscription_id`) REFERENCES `Subscription` (`subscription_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `subscriptionentity_entity_id_entity_id_fkey` FOREIGN KEY (`subscriptionentity_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `SubscriptionEntity`
--

LOCK TABLES `SubscriptionEntity` WRITE;
/*!40000 ALTER TABLE `SubscriptionEntity` DISABLE KEYS */;
/*!40000 ALTER TABLE `SubscriptionEntity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SubscriptionReception`
--

DROP TABLE IF EXISTS `SubscriptionReception`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `SubscriptionReception` (
  `subscriptionreception_id` int(8) NOT NULL auto_increment,
  `subscriptionreception_domain_id` int(8) NOT NULL,
  `subscriptionreception_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `subscriptionreception_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `subscriptionreception_userupdate` int(8) default NULL,
  `subscriptionreception_usercreate` int(8) default NULL,
  `subscriptionreception_code` varchar(10) default '',
  `subscriptionreception_label` char(12) default NULL,
  PRIMARY KEY  (`subscriptionreception_id`),
  KEY `subscriptionreception_domain_id_domain_id_fkey` (`subscriptionreception_domain_id`),
  KEY `subscriptionreception_userupdate_userobm_id_fkey` (`subscriptionreception_userupdate`),
  KEY `subscriptionreception_usercreate_userobm_id_fkey` (`subscriptionreception_usercreate`),
  CONSTRAINT `subscriptionreception_usercreate_userobm_id_fkey` FOREIGN KEY (`subscriptionreception_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `subscriptionreception_domain_id_domain_id_fkey` FOREIGN KEY (`subscriptionreception_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `subscriptionreception_userupdate_userobm_id_fkey` FOREIGN KEY (`subscriptionreception_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `SubscriptionReception`
--

LOCK TABLES `SubscriptionReception` WRITE;
/*!40000 ALTER TABLE `SubscriptionReception` DISABLE KEYS */;
/*!40000 ALTER TABLE `SubscriptionReception` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TaskEvent`
--

DROP TABLE IF EXISTS `TaskEvent`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `TaskEvent` (
  `taskevent_task_id` int(8) NOT NULL,
  `taskevent_event_id` int(8) NOT NULL,
  PRIMARY KEY  (`taskevent_event_id`,`taskevent_task_id`),
  KEY `taskevent_task_id_projecttask_id_fkey` (`taskevent_task_id`),
  CONSTRAINT `taskevent_task_id_projecttask_id_fkey` FOREIGN KEY (`taskevent_task_id`) REFERENCES `ProjectTask` (`projecttask_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `taskevent_event_id_event_id_fkey` FOREIGN KEY (`taskevent_event_id`) REFERENCES `Event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `TaskEvent`
--

LOCK TABLES `TaskEvent` WRITE;
/*!40000 ALTER TABLE `TaskEvent` DISABLE KEYS */;
/*!40000 ALTER TABLE `TaskEvent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TaskType`
--

DROP TABLE IF EXISTS `TaskType`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `TaskType` (
  `tasktype_id` int(8) NOT NULL auto_increment,
  `tasktype_domain_id` int(8) NOT NULL,
  `tasktype_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `tasktype_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `tasktype_userupdate` int(8) default NULL,
  `tasktype_usercreate` int(8) default NULL,
  `tasktype_internal` int(1) NOT NULL,
  `tasktype_code` varchar(10) default NULL,
  `tasktype_label` varchar(32) default NULL,
  PRIMARY KEY  (`tasktype_id`),
  KEY `tasktype_domain_id_domain_id_fkey` (`tasktype_domain_id`),
  KEY `tasktype_userupdate_userobm_id_fkey` (`tasktype_userupdate`),
  KEY `tasktype_usercreate_userobm_id_fkey` (`tasktype_usercreate`),
  CONSTRAINT `tasktype_usercreate_userobm_id_fkey` FOREIGN KEY (`tasktype_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `tasktype_domain_id_domain_id_fkey` FOREIGN KEY (`tasktype_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tasktype_userupdate_userobm_id_fkey` FOREIGN KEY (`tasktype_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `TaskType`
--

LOCK TABLES `TaskType` WRITE;
/*!40000 ALTER TABLE `TaskType` DISABLE KEYS */;
INSERT INTO `TaskType` VALUES (1,1,'2008-12-17 14:00:31','0000-00-00 00:00:00',NULL,NULL,0,NULL,'Développement'),(2,1,'2008-12-17 14:00:31','0000-00-00 00:00:00',NULL,NULL,0,NULL,'Sav / Maintenance'),(3,1,'2008-12-17 14:00:31','0000-00-00 00:00:00',NULL,NULL,0,NULL,'Formation'),(4,1,'2008-12-17 14:00:31','0000-00-00 00:00:00',NULL,NULL,0,NULL,'Etudes / Conseil'),(5,1,'2008-12-17 14:00:31','0000-00-00 00:00:00',NULL,NULL,0,NULL,'Réseau / Intégration'),(6,1,'2008-12-17 14:00:31','0000-00-00 00:00:00',NULL,NULL,0,NULL,'Infographie'),(7,1,'2008-12-17 14:00:31','0000-00-00 00:00:00',NULL,NULL,0,NULL,'Hébergement'),(8,1,'2008-12-17 14:00:31','0000-00-00 00:00:00',NULL,NULL,0,NULL,'Matériel'),(9,1,'2008-12-17 14:00:31','0000-00-00 00:00:00',NULL,NULL,0,NULL,'Autres'),(10,1,'2008-12-17 14:00:31','0000-00-00 00:00:00',NULL,NULL,2,NULL,'Avant vente'),(11,1,'2008-12-17 14:00:31','0000-00-00 00:00:00',NULL,NULL,2,NULL,'Préparation formation'),(12,1,'2008-12-17 14:00:31','0000-00-00 00:00:00',NULL,NULL,1,NULL,'Développements internes'),(13,1,'2008-12-17 14:00:31','0000-00-00 00:00:00',NULL,NULL,1,NULL,'Projets internes'),(14,1,'2008-12-17 14:00:31','0000-00-00 00:00:00',NULL,NULL,2,NULL,'Auto-Formations,Veille'),(15,1,'2008-12-17 14:00:31','0000-00-00 00:00:00',NULL,NULL,2,NULL,'Garantie contractuelle projets'),(16,1,'2008-12-17 14:00:31','0000-00-00 00:00:00',NULL,NULL,2,NULL,'Divers(direction,autres)'),(17,1,'2008-12-17 14:00:31','0000-00-00 00:00:00',NULL,NULL,2,NULL,'Congés , absences , maladie'),(18,1,'2008-12-17 14:00:31','0000-00-00 00:00:00',NULL,NULL,2,NULL,'Déplacements'),(19,1,'2008-12-17 14:00:31','0000-00-00 00:00:00',NULL,NULL,2,NULL,'Infographie/Communication'),(20,1,'2008-12-17 14:00:31','0000-00-00 00:00:00',NULL,NULL,2,NULL,'Administratif'),(21,1,'2008-12-17 14:00:31','0000-00-00 00:00:00',NULL,NULL,2,NULL,'Réunions');
/*!40000 ALTER TABLE `TaskType` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TimeTask`
--

DROP TABLE IF EXISTS `TimeTask`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `TimeTask` (
  `timetask_id` int(8) NOT NULL auto_increment,
  `timetask_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `timetask_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `timetask_userupdate` int(8) default NULL,
  `timetask_usercreate` int(8) default NULL,
  `timetask_user_id` int(8) default NULL,
  `timetask_date` timestamp NOT NULL default '0000-00-00 00:00:00',
  `timetask_projecttask_id` int(8) default NULL,
  `timetask_length` float default NULL,
  `timetask_tasktype_id` int(8) default NULL,
  `timetask_label` varchar(255) default NULL,
  `timetask_status` int(1) default NULL,
  PRIMARY KEY  (`timetask_id`),
  KEY `tt_idx_pt` (`timetask_projecttask_id`),
  KEY `timetask_user_id_userobm_id_fkey` (`timetask_user_id`),
  KEY `timetask_tasktype_id_tasktype_id_fkey` (`timetask_tasktype_id`),
  KEY `timetask_userupdate_userobm_id_fkey` (`timetask_userupdate`),
  KEY `timetask_usercreate_userobm_id_fkey` (`timetask_usercreate`),
  CONSTRAINT `timetask_usercreate_userobm_id_fkey` FOREIGN KEY (`timetask_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `timetask_projecttask_id_projecttask_id_fkey` FOREIGN KEY (`timetask_projecttask_id`) REFERENCES `ProjectTask` (`projecttask_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `timetask_tasktype_id_tasktype_id_fkey` FOREIGN KEY (`timetask_tasktype_id`) REFERENCES `TaskType` (`tasktype_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `timetask_userupdate_userobm_id_fkey` FOREIGN KEY (`timetask_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `timetask_user_id_userobm_id_fkey` FOREIGN KEY (`timetask_user_id`) REFERENCES `UserObm` (`userobm_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `TimeTask`
--

LOCK TABLES `TimeTask` WRITE;
/*!40000 ALTER TABLE `TimeTask` DISABLE KEYS */;
/*!40000 ALTER TABLE `TimeTask` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UGroup`
--

DROP TABLE IF EXISTS `UGroup`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `UGroup` (
  `group_id` int(8) NOT NULL auto_increment,
  `group_domain_id` int(8) NOT NULL,
  `group_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `group_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `group_userupdate` int(8) default NULL,
  `group_usercreate` int(8) default NULL,
  `group_system` int(1) default '0',
  `group_archive` int(1) NOT NULL default '0',
  `group_privacy` int(2) default '0',
  `group_local` int(1) default '1',
  `group_ext_id` varchar(24) default NULL,
  `group_samba` int(1) default '0',
  `group_gid` int(8) default NULL,
  `group_mailing` int(1) default '0',
  `group_delegation` varchar(64) default '',
  `group_manager_id` int(8) default NULL,
  `group_name` varchar(255) NOT NULL,
  `group_desc` varchar(128) default NULL,
  `group_email` varchar(128) default NULL,
  `group_contacts` text,
  PRIMARY KEY  (`group_id`),
  UNIQUE KEY `group_gid` (`group_gid`),
  KEY `group_domain_id_domain_id_fkey` (`group_domain_id`),
  KEY `group_userupdate_userobm_id_fkey` (`group_userupdate`),
  KEY `group_usercreate_userobm_id_fkey` (`group_usercreate`),
  KEY `group_manager_id_userobm_id_fkey` (`group_manager_id`),
  CONSTRAINT `group_manager_id_userobm_id_fkey` FOREIGN KEY (`group_manager_id`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `group_domain_id_domain_id_fkey` FOREIGN KEY (`group_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `group_usercreate_userobm_id_fkey` FOREIGN KEY (`group_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `group_userupdate_userobm_id_fkey` FOREIGN KEY (`group_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `UGroup`
--

LOCK TABLES `UGroup` WRITE;
/*!40000 ALTER TABLE `UGroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `UGroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Updated`
--

DROP TABLE IF EXISTS `Updated`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `Updated` (
  `updated_id` int(8) NOT NULL auto_increment,
  `updated_domain_id` int(8) default NULL,
  `updated_user_id` int(8) default NULL,
  `updated_delegation` varchar(64) default '',
  `updated_table` varchar(32) default NULL,
  `updated_entity_id` int(8) default NULL,
  `updated_type` char(1) default NULL,
  PRIMARY KEY  (`updated_id`),
  KEY `updated_domain_id_domain_id_fkey` (`updated_domain_id`),
  KEY `updated_user_id_userobm_id_fkey` (`updated_user_id`),
  CONSTRAINT `updated_user_id_userobm_id_fkey` FOREIGN KEY (`updated_user_id`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `updated_domain_id_domain_id_fkey` FOREIGN KEY (`updated_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `Updated`
--

LOCK TABLES `Updated` WRITE;
/*!40000 ALTER TABLE `Updated` DISABLE KEYS */;
/*!40000 ALTER TABLE `Updated` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Updatedlinks`
--

DROP TABLE IF EXISTS `Updatedlinks`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `Updatedlinks` (
  `updatedlinks_id` int(8) NOT NULL auto_increment,
  `updatedlinks_domain_id` int(8) default NULL,
  `updatedlinks_user_id` int(8) default NULL,
  `updatedlinks_delegation` varchar(64) default NULL,
  `updatedlinks_table` varchar(32) default NULL,
  `updatedlinks_entity` varchar(32) default NULL,
  `updatedlinks_entity_id` int(8) default NULL,
  PRIMARY KEY  (`updatedlinks_id`),
  KEY `updatedlinks_domain_id_domain_id_fkey` (`updatedlinks_domain_id`),
  KEY `updatedlinks_user_id_userobm_id_fkey` (`updatedlinks_user_id`),
  CONSTRAINT `updatedlinks_user_id_userobm_id_fkey` FOREIGN KEY (`updatedlinks_user_id`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `updatedlinks_domain_id_domain_id_fkey` FOREIGN KEY (`updatedlinks_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `Updatedlinks`
--

LOCK TABLES `Updatedlinks` WRITE;
/*!40000 ALTER TABLE `Updatedlinks` DISABLE KEYS */;
/*!40000 ALTER TABLE `Updatedlinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserEntity`
--

DROP TABLE IF EXISTS `UserEntity`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `UserEntity` (
  `userentity_entity_id` int(8) NOT NULL,
  `userentity_user_id` int(8) NOT NULL,
  PRIMARY KEY  (`userentity_entity_id`,`userentity_user_id`),
  KEY `userentity_user_id_user_id_fkey` (`userentity_user_id`),
  CONSTRAINT `userentity_user_id_user_id_fkey` FOREIGN KEY (`userentity_user_id`) REFERENCES `UserObm` (`userobm_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `userentity_entity_id_entity_id_fkey` FOREIGN KEY (`userentity_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `UserEntity`
--

LOCK TABLES `UserEntity` WRITE;
/*!40000 ALTER TABLE `UserEntity` DISABLE KEYS */;
INSERT INTO `UserEntity` VALUES (2,1);
/*!40000 ALTER TABLE `UserEntity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserObm`
--

DROP TABLE IF EXISTS `UserObm`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `UserObm` (
  `userobm_id` int(8) NOT NULL auto_increment,
  `userobm_domain_id` int(8) default NULL,
  `userobm_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `userobm_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `userobm_userupdate` int(8) default NULL,
  `userobm_usercreate` int(8) default NULL,
  `userobm_local` int(1) default '1',
  `userobm_ext_id` varchar(16) default NULL,
  `userobm_system` int(1) default '0',
  `userobm_archive` int(1) NOT NULL default '0',
  `userobm_timelastaccess` timestamp NOT NULL default '0000-00-00 00:00:00',
  `userobm_login` varchar(32) NOT NULL default '',
  `userobm_nb_login_failed` int(2) default '0',
  `userobm_password_type` char(6) NOT NULL default 'PLAIN',
  `userobm_password` varchar(64) NOT NULL default '',
  `userobm_password_dateexp` date default NULL,
  `userobm_account_dateexp` date default NULL,
  `userobm_perms` varchar(254) default NULL,
  `userobm_delegation_target` varchar(64) default '',
  `userobm_delegation` varchar(64) default '',
  `userobm_calendar_version` timestamp NOT NULL default '0000-00-00 00:00:00',
  `userobm_uid` int(8) default NULL,
  `userobm_gid` int(8) default NULL,
  `userobm_datebegin` date default NULL,
  `userobm_hidden` int(1) default '0',
  `userobm_kind` varchar(12) default NULL,
  `userobm_lastname` varchar(64) default '',
  `userobm_firstname` varchar(64) default '',
  `userobm_title` varchar(64) default '',
  `userobm_sound` varchar(64) default NULL,
  `userobm_company` varchar(64) default NULL,
  `userobm_direction` varchar(64) default NULL,
  `userobm_service` varchar(64) default NULL,
  `userobm_address1` varchar(64) default NULL,
  `userobm_address2` varchar(64) default NULL,
  `userobm_address3` varchar(64) default NULL,
  `userobm_zipcode` varchar(14) default NULL,
  `userobm_town` varchar(64) default NULL,
  `userobm_expresspostal` varchar(16) default NULL,
  `userobm_country_iso3166` char(2) default '0',
  `userobm_phone` varchar(32) default '',
  `userobm_phone2` varchar(32) default '',
  `userobm_mobile` varchar(32) default '',
  `userobm_fax` varchar(32) default '',
  `userobm_fax2` varchar(32) default '',
  `userobm_web_perms` int(1) default '0',
  `userobm_web_list` text,
  `userobm_web_all` int(1) default '0',
  `userobm_mail_perms` int(1) default '0',
  `userobm_mail_ext_perms` int(1) default '0',
  `userobm_email` text,
  `userobm_mail_server_id` int(8) default NULL,
  `userobm_mail_quota` int(8) default '0',
  `userobm_mail_quota_use` int(8) default '0',
  `userobm_mail_login_date` timestamp NOT NULL default '0000-00-00 00:00:00',
  `userobm_nomade_perms` int(1) default '0',
  `userobm_nomade_enable` int(1) default '0',
  `userobm_nomade_local_copy` int(1) default '0',
  `userobm_nomade_datebegin` timestamp NOT NULL default '0000-00-00 00:00:00',
  `userobm_nomade_dateend` timestamp NOT NULL default '0000-00-00 00:00:00',
  `userobm_email_nomade` text,
  `userobm_vacation_enable` int(1) default '0',
  `userobm_vacation_datebegin` timestamp NOT NULL default '0000-00-00 00:00:00',
  `userobm_vacation_dateend` timestamp NOT NULL default '0000-00-00 00:00:00',
  `userobm_vacation_message` text,
  `userobm_samba_perms` int(1) default '0',
  `userobm_samba_home` varchar(255) default '',
  `userobm_samba_home_drive` char(2) default '',
  `userobm_samba_logon_script` varchar(128) default '',
  `userobm_host_id` int(8) default NULL,
  `userobm_description` varchar(255) default NULL,
  `userobm_location` varchar(255) default NULL,
  `userobm_education` varchar(255) default NULL,
  `userobm_photo_id` int(8) default NULL,
  PRIMARY KEY  (`userobm_id`),
  KEY `k_login_user` (`userobm_login`),
  KEY `k_uid_user` (`userobm_uid`),
  KEY `userobm_domain_id_domain_id_fkey` (`userobm_domain_id`),
  KEY `userobm_userupdate_userobm_id_fkey` (`userobm_userupdate`),
  KEY `userobm_usercreate_userobm_id_fkey` (`userobm_usercreate`),
  KEY `userobm_mail_server_id_mailserver_id_fkey` (`userobm_mail_server_id`),
  KEY `userobm_host_id_host_id_fkey` (`userobm_host_id`),
  KEY `userobm_photo_id_document_id_fkey` (`userobm_photo_id`),
  CONSTRAINT `userobm_photo_id_document_id_fkey` FOREIGN KEY (`userobm_photo_id`) REFERENCES `Document` (`document_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `userobm_domain_id_domain_id_fkey` FOREIGN KEY (`userobm_domain_id`) REFERENCES `Domain` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `userobm_host_id_host_id_fkey` FOREIGN KEY (`userobm_host_id`) REFERENCES `Host` (`host_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `userobm_mail_server_id_mailserver_id_fkey` FOREIGN KEY (`userobm_mail_server_id`) REFERENCES `Host` (`host_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `userobm_usercreate_userobm_id_fkey` FOREIGN KEY (`userobm_usercreate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `userobm_userupdate_userobm_id_fkey` FOREIGN KEY (`userobm_userupdate`) REFERENCES `UserObm` (`userobm_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `UserObm`
--

LOCK TABLES `UserObm` WRITE;
/*!40000 ALTER TABLE `UserObm` DISABLE KEYS */;
INSERT INTO `UserObm` VALUES (1,1,'2008-12-17 14:00:31','0000-00-00 00:00:00',NULL,NULL,1,NULL,0,0,'0000-00-00 00:00:00','admin0',0,'PLAIN','admin',NULL,NULL,'admin','','','0000-00-00 00:00:00',1000,512,NULL,0,NULL,'Admin Lastname','Firstname','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','','','','','',0,NULL,0,0,0,NULL,NULL,0,0,'0000-00-00 00:00:00',0,0,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',NULL,0,'','','',NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `UserObm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserObmGroup`
--

DROP TABLE IF EXISTS `UserObmGroup`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `UserObmGroup` (
  `userobmgroup_group_id` int(8) NOT NULL,
  `userobmgroup_userobm_id` int(8) NOT NULL,
  PRIMARY KEY  (`userobmgroup_group_id`,`userobmgroup_userobm_id`),
  KEY `userobmgroup_userobm_id_userobm_id_fkey` (`userobmgroup_userobm_id`),
  CONSTRAINT `userobmgroup_userobm_id_userobm_id_fkey` FOREIGN KEY (`userobmgroup_userobm_id`) REFERENCES `UserObm` (`userobm_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `userobmgroup_group_id_group_id_fkey` FOREIGN KEY (`userobmgroup_group_id`) REFERENCES `UGroup` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `UserObmGroup`
--

LOCK TABLES `UserObmGroup` WRITE;
/*!40000 ALTER TABLE `UserObmGroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `UserObmGroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserObmPref`
--

DROP TABLE IF EXISTS `UserObmPref`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `UserObmPref` (
  `userobmpref_id` int(8) NOT NULL auto_increment,
  `userobmpref_user_id` int(8) default NULL,
  `userobmpref_option` varchar(50) NOT NULL,
  `userobmpref_value` varchar(50) NOT NULL,
  PRIMARY KEY  (`userobmpref_id`),
  UNIQUE KEY `userobmpref_key` (`userobmpref_user_id`,`userobmpref_option`),
  KEY `userobmpref_user_id_userobm_id_fkey` (`userobmpref_user_id`),
  CONSTRAINT `userobmpref_user_id_userobm_id_fkey` FOREIGN KEY (`userobmpref_user_id`) REFERENCES `UserObm` (`userobm_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `UserObmPref`
--

LOCK TABLES `UserObmPref` WRITE;
/*!40000 ALTER TABLE `UserObmPref` DISABLE KEYS */;
INSERT INTO `UserObmPref` VALUES (1,NULL,'set_lang','fr'),(2,NULL,'set_theme','default'),(3,NULL,'set_menu','both'),(4,NULL,'set_display','no'),(5,NULL,'set_rows','20'),(6,NULL,'set_dsrc','0'),(7,NULL,'set_date_upd','m/d/Y'),(8,NULL,'set_date','Y-m-d'),(9,NULL,'set_timezone','Europe/Paris'),(10,NULL,'set_commentorder','0'),(11,NULL,'set_cal_interval','2'),(12,NULL,'set_csv_sep',';'),(13,NULL,'set_debug','0'),(14,NULL,'set_mail','yes'),(15,NULL,'set_day_weekstart','monday'),(16,NULL,'set_cal_first_hour','8'),(17,NULL,'set_cal_last_hour','20'),(18,NULL,'set_todo','event_priority');
/*!40000 ALTER TABLE `UserObmPref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserObm_SessionLog`
--

DROP TABLE IF EXISTS `UserObm_SessionLog`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `UserObm_SessionLog` (
  `userobm_sessionlog_sid` varchar(32) NOT NULL default '',
  `userobm_sessionlog_session_name` varchar(32) NOT NULL default '',
  `userobm_sessionlog_userobm_id` int(11) default NULL,
  `userobm_sessionlog_timeupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `userobm_sessionlog_timecreate` timestamp NOT NULL default '0000-00-00 00:00:00',
  `userobm_sessionlog_nb_connexions` int(11) NOT NULL default '0',
  `userobm_sessionlog_lastpage` varchar(32) NOT NULL default '0',
  `userobm_sessionlog_ip` varchar(32) NOT NULL default '0',
  PRIMARY KEY  (`userobm_sessionlog_sid`),
  KEY `userobm_sessionlog_userobm_id_userobm_id_fkey` (`userobm_sessionlog_userobm_id`),
  CONSTRAINT `userobm_sessionlog_userobm_id_userobm_id_fkey` FOREIGN KEY (`userobm_sessionlog_userobm_id`) REFERENCES `UserObm` (`userobm_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `UserObm_SessionLog`
--

LOCK TABLES `UserObm_SessionLog` WRITE;
/*!40000 ALTER TABLE `UserObm_SessionLog` DISABLE KEYS */;
/*!40000 ALTER TABLE `UserObm_SessionLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserSystem`
--

DROP TABLE IF EXISTS `UserSystem`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `UserSystem` (
  `usersystem_id` int(8) NOT NULL auto_increment,
  `usersystem_login` varchar(32) NOT NULL default '',
  `usersystem_password` varchar(32) NOT NULL default '',
  `usersystem_uid` varchar(6) default NULL,
  `usersystem_gid` varchar(6) default NULL,
  `usersystem_homedir` varchar(32) NOT NULL default '/tmp',
  `usersystem_lastname` varchar(32) default NULL,
  `usersystem_firstname` varchar(32) default NULL,
  `usersystem_shell` varchar(32) default NULL,
  PRIMARY KEY  (`usersystem_id`),
  UNIQUE KEY `k_login_user` (`usersystem_login`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `UserSystem`
--

LOCK TABLES `UserSystem` WRITE;
/*!40000 ALTER TABLE `UserSystem` DISABLE KEYS */;
INSERT INTO `UserSystem` VALUES (1,'cyrus','cyrus','103','8','/var/spool/cyrus','Cyrus','Administrator','/bin/false'),(2,'ldapadmin','mdp3PaAL','150','65534','/var/lib/ldap','LDAP','Administrator','/bin/false'),(3,'samba','m#Pa!NtA','106','65534','/','SAMBA','LDAP writer','/bin/false'),(4,'obmsatellite','mG4_Zdnh','200','65534','/','OBM Satellite','LDAP Reader','/bin/false');
/*!40000 ALTER TABLE `UserSystem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Website`
--

DROP TABLE IF EXISTS `Website`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `Website` (
  `website_id` int(8) NOT NULL auto_increment,
  `website_entity_id` int(8) NOT NULL,
  `website_label` varchar(255) NOT NULL,
  `website_url` text,
  PRIMARY KEY  (`website_id`),
  KEY `website_entity_id_entity_id_fkey` (`website_entity_id`),
  CONSTRAINT `website_entity_id_entity_id_fkey` FOREIGN KEY (`website_entity_id`) REFERENCES `Entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `Website`
--

LOCK TABLES `Website` WRITE;
/*!40000 ALTER TABLE `Website` DISABLE KEYS */;
/*!40000 ALTER TABLE `Website` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `of_usergroup`
--

DROP TABLE IF EXISTS `of_usergroup`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `of_usergroup` (
  `of_usergroup_group_id` int(8) NOT NULL,
  `of_usergroup_user_id` int(8) NOT NULL,
  PRIMARY KEY  (`of_usergroup_group_id`,`of_usergroup_user_id`),
  KEY `of_usergroup_user_id_userobm_id_fkey` (`of_usergroup_user_id`),
  CONSTRAINT `of_usergroup_user_id_userobm_id_fkey` FOREIGN KEY (`of_usergroup_user_id`) REFERENCES `UserObm` (`userobm_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `of_usergroup_group_id_group_id_fkey` FOREIGN KEY (`of_usergroup_group_id`) REFERENCES `UGroup` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `of_usergroup`
--

LOCK TABLES `of_usergroup` WRITE;
/*!40000 ALTER TABLE `of_usergroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `of_usergroup` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2008-12-17 14:00:51
