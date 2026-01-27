-- SQL to add CE Score column to your PATH Tracker database
-- Run this in Supabase SQL Editor before using the enhanced tracker

-- Add the ce_score column to myevolv_entries table
ALTER TABLE myevolv_entries 
ADD COLUMN IF NOT EXISTS ce_score INTEGER;

-- Add a check constraint to ensure scores are 0-20
ALTER TABLE myevolv_entries 
ADD CONSTRAINT ce_score_range CHECK (ce_score >= 0 AND ce_score <= 20);

-- Add a comment to document the column
COMMENT ON COLUMN myevolv_entries.ce_score IS 'Coordinated Entry Score (0-20). Required for Stand-alone CE entries. Scores 14+ are high priority.';

-- Verify the column was added
SELECT column_name, data_type, is_nullable 
FROM information_schema.columns 
WHERE table_name = 'myevolv_entries' 
AND column_name = 'ce_score';
