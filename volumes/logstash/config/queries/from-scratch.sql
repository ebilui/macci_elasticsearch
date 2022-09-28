SELECT v_map_facility.*, me.m_company_id, me.m_usre_id, mf.m_company_id, mf.m_usre_id, mh.m_company_id, mh.m_usre_id, mt.m_company_id, mt.m_usre_id
FROM v_map_facility
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