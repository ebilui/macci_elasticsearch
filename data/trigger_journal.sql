DELIMITER ;;
CREATE DEFINER=`root`@`%` TRIGGER `macci_after_insert` AFTER INSERT ON `v_map_facility` FOR EACH ROW INSERT INTO copy_macci.macci_journal
	SET
		action_type = 'create',
		facility_id = NEW.facility_id,
		action_time = now() ;;
DELIMITER ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` TRIGGER `macci_after_update` AFTER UPDATE ON `v_map_facility` FOR EACH ROW IF NEW.facility_id = OLD.facility_id THEN
		INSERT INTO copy_macci.macci_journal
		SET action_type = 'update',
			facility_id = OLD.facility_id,
			action_time = NOW();
	ELSE
		-- Set old one as deleted
		INSERT INTO copy_macci.macci_journal
		SET action_type = 'delete',
			facility_id = OLD.facility_id,
			action_time = NOW();
		-- AND NEW one created
		INSERT INTO copy_macci.macci_journal
		SET action_type = 'create',
			facility_id = NEW.facility_id,
			action_time = NOW();
	END IF ;;
DELIMITER ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` TRIGGER `macci_after_delete` AFTER DELETE ON `v_map_facility` FOR EACH ROW INSERT INTO copy_macci.macci_journal
	SET action_type = 'delete',
		facility_id = OLD.facility_id,
		action_time = now() ;;
DELIMITER ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` TRIGGER `macci_after_insert_favorite` AFTER INSERT ON `m_favorite_list` FOR EACH ROW INSERT INTO copy_macci.macci_journal
	SET
		action_type = 'update',
		facility_id = NEW.point_id,
		action_time = now() ;;
DELIMITER ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` TRIGGER `macci_after_update_favorite` AFTER UPDATE ON `m_favorite_list` FOR EACH ROW IF NEW.point_id = OLD.point_id THEN
		INSERT INTO copy_macci.macci_journal
		SET action_type = 'update',
			facility_id = OLD.point_id,
			action_time = NOW();
	ELSE
		-- Set old one as deleted
		INSERT INTO copy_macci.macci_journal
		SET action_type = 'delete',
			facility_id = OLD.point_id,
			action_time = NOW();
		-- AND NEW one created
		INSERT INTO copy_macci.macci_journal
		SET action_type = 'update',
			facility_id = NEW.point_id,
			action_time = NOW();
	END IF ;;
DELIMITER ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` TRIGGER `macci_after_delete_favorite` AFTER DELETE ON `m_favorite_list` FOR EACH ROW INSERT INTO copy_macci.macci_journal
	SET action_type = 'delete',
		facility_id = OLD.point_id,
		action_time = now() ;;
DELIMITER ;