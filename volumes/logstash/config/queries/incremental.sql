SELECT
	me.m_company_id, me.m_usre_id, mf.m_company_id, mf.m_usre_id, mh.m_company_id, mh.m_usre_id, mt.m_company_id, mt.m_usre_id
	j.journal_id, j.action_type, j.facility_id,
	v.lat, v.lng, v.geo, v.facility_name, v.chain_store_name, v.chain_store_branch, v.zipcode, v.address, v.apartment_name, v.pref_name, v.city_name, v.oaza_name, v.phone_number, v.fax_number, v.judge_open_date, v.health_center_name, v.company_name, v.company_address, v.company_apartment_name, v.company_zipcode, v.applicant_phone_number, v.genre_name_newest, v.application_class_name_newest, v.genre_id_newest, v.genre_id_bit, v.application_class_id_newest, v.industrial_major_id, v.industrial_medium_id, v.industrial_sub_id, v.industrial_detail_id, v.company_id, v.health_center_id, v.corporate_Number, v.pref_id, v.city_id, v.oaza_id, v.ng_flag, v.gcp_update_flag, v.publish
FROM copy_macci.macci_journal j
	LEFT JOIN copy_macci.v_map_facility v ON v. facility_id= j.facility_id
	LEFT JOIN (
		SELECT facility_id, deleted
		FROM m_export_history
		WHERE deleted = 0
	) AS me
	ON v_map_facility.facility_id = me.facility_id
	LEFT JOIN (
		SELECT point_id, deleted
		FROM m_favorite_list
		WHERE deleted = 0
	) AS mf
	ON v_map_facility.facility_id = mf.point_id
	LEFT JOIN (
		SELECT point_id, deleted
		FROM m_hashtag_list
		WHERE deleted = 0
	) AS mh
	ON v_map_facility.facility_id = mh.point_id
	LEFT JOIN (
		SELECT facility_id, deleted
		FROM m_task_list
		WHERE deleted = 0
	) AS mt
	ON v_map_facility.facility_id = mt.facility_id
WHERE v_map_facility.ng_flag = 0
	AND v_map_facility.publish = 1
	AND j.journal_id > :sql_last_value
	AND j.action_time < NOW()
ORDER BY j.journal_id