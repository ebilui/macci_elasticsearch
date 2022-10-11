SELECT v_map_facility.*, me.me_company_id, me.me_user_id, mf.mf_company_id, mf.mf_user_id, mh.mh_company_id, mh.mh_user_id, mt.mt_company_id, mt.mt_user_id
FROM copy_macci.v_map_facility AS v_map_facility
	LEFT JOIN (
		SELECT facility_id, deleted, m_company_id as me_company_id, m_user_id as me_user_id
		FROM copy_macci.m_export_history
		WHERE deleted = 0
	) AS me
	ON v_map_facility.facility_id = me.facility_id
	LEFT JOIN (
		SELECT point_id, deleted, m_company_id as mf_company_id, m_user_id as mf_user_id
		FROM copy_macci.m_favorite_list
		WHERE deleted = 0
	) AS mf
	ON v_map_facility.facility_id = mf.point_id
	LEFT JOIN (
		SELECT point_id, deleted, m_company_id as mh_company_id, m_user_id as mh_user_id
		FROM copy_macci.m_hashtag_list
		WHERE deleted = 0
	) AS mh
	ON v_map_facility.facility_id = mh.point_id
	LEFT JOIN (
		SELECT facility_id, deleted, m_company_id as mt_company_id, m_user_id as mt_user_id
		FROM copy_macci.m_task_list
		WHERE deleted = 0
	) AS mt
	ON v_map_facility.facility_id = mt.facility_id
WHERE v_map_facility.ng_flag = 0
AND v_map_facility.publish = 1