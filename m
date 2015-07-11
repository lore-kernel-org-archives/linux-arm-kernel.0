From: nsekhar@ti.com (Sekhar Nori)
Date: Sat, 11 Jul 2015 20:29:14 +0530
Subject: [PATCH 0/2] ARM: OMAP2+: sparse fixes
Message-ID: <cover.1436622578.git.nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

Here are some sparse fixes for mach-omap2.
After this series mach-omap2 is sparse clean.

Thanks,
Sekhar

Sekhar Nori (2):
  ARM: OMAP2+: sparse: add missing static declaration
  ARM: OMAP2+: sparse: add missing function declarations

 arch/arm/mach-omap2/omap-mpuss-lowpower.c          |  2 +-
 arch/arm/mach-omap2/omap3-restart.c                |  1 +
 arch/arm/mach-omap2/omap4-restart.c                |  1 +
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |  2 +-
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |  2 +-
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c         | 34 +++++++++++-----------
 arch/arm/mach-omap2/pdata-quirks.c                 |  6 ++--
 7 files changed, 25 insertions(+), 23 deletions(-)

-- 
2.4.4.408.g16da57c
