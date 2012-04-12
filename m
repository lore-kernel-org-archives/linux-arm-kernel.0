From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 12 Apr 2012 16:59:45 +0530
Subject: [PATCH 0/2] ARM: mm: Add v7_flush_dcache_by_level() API
Message-ID: <1334230187-21553-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Couple of patches on the ARMv7 cache code. First patch adds
v7_flush_dcache_by_level() API and second patch updates the setup
function to use the same.

R Sricharan (1):
  ARM: mm: Add v7_flush_dcache_by_level() API.

Santosh Shilimkar (1):
  ARM: mm: Flush only CPU local cache instead of all cache levels.

 arch/arm/mm/cache-v7.S |   56 ++++++++++++++++++++++++++++++++++++++---------
 arch/arm/mm/proc-v7.S  |    3 +-
 2 files changed, 47 insertions(+), 12 deletions(-)

-- 
1.7.5.4
