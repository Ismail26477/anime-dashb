-- Add season column to episodes table
ALTER TABLE episodes
ADD COLUMN season INTEGER DEFAULT 1;

-- Create index for efficient querying by season
CREATE INDEX IF NOT EXISTS idx_episodes_season ON episodes(anime_id, season, episode_number);

-- Add check constraint to ensure season is positive
ALTER TABLE episodes
ADD CONSTRAINT check_episode_season_positive CHECK (season > 0);

-- Update the check constraint on platform to include Terabox if not already there
ALTER TABLE episode_links
DROP CONSTRAINT IF EXISTS episode_links_platform_check;

ALTER TABLE episode_links
ADD CONSTRAINT episode_links_platform_check CHECK (platform IN ('WatchDT', 'Mega', 'Mediafire', 'Google Drive', 'Terabox', 'Direct Download'));
