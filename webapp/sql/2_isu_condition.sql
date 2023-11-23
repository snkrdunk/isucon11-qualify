ALTER TABLE isu_condition ADD COLUMN `condition_summary` VARCHAR(255);

CREATE INDEX idx_isu_condition_jia_isu_uuid_condition_summary_timestamp ON isu_condition (jia_isu_uuid, condition_summary, timestamp DESC);

UPDATE isu_condition SET `condition_summary` = 'info' WHERE `condition` = 'is_dirty=false,is_overweight=false,is_broken=false';
UPDATE isu_condition SET `condition_summary` = 'critical' WHERE `condition` = 'is_dirty=true,is_overweight=true,is_broken=true';
UPDATE isu_condition SET `condition_summary` = 'warning' WHERE `condition` IN (
    "is_dirty=true,is_overweight=false,is_broken=false",
    "is_dirty=false,is_overweight=true,is_broken=false",
    "is_dirty=false,is_overweight=false,is_broken=true",
    "is_dirty=true,is_overweight=true,is_broken=false",
    "is_dirty=true,is_overweight=false,is_broken=true",
    "is_dirty=false,is_overweight=true,is_broken=true"
);
