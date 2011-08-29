From: khilman@ti.com (Kevin Hilman)
Date: Mon, 29 Aug 2011 11:15:16 -0700
Subject: [PATCH 0/5] OMAP: voltage cleanup part E: TWL6030 PMIC fixes
Message-ID: <1314641721-5172-1-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series focuses on cleanups and fixes in support of the TWL6030 PMIC.

Available in the pm-wip/voltdm_e branch of my linux-omap-pm tree
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git

Applies on v3.1-rc3 + the part A, B, C & D series.

Kevin



Nishanth Menon (3):
  OMAP4: PM: TWL6030: fix uv to voltage for >0x39
  OMAP4: PM: TWL6030: address 0V conversions
  OMAP4: PM: TWL6030: add cmd register

Patrick Titiano (2):
  OMAP4: PM: TWL6030: fix voltage conversion formula
  OMAP4: PM: TWL6030: fix ON/RET/OFF voltages

 arch/arm/mach-omap2/omap_twl.c |   55 +++++++++++++++++++++++++--------------
 1 files changed, 35 insertions(+), 20 deletions(-)

-- 
1.7.6
