From: nm@ti.com (Nishanth Menon)
Date: Wed,  5 Jan 2011 14:49:34 -0600
Subject: [PATCH 0/2] OMAP3: Beagle: enable 800MHz for xm
Message-ID: <1294260576-20237-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Source: git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
branch: omap-for-linus (dc69d1a omap2: Make OMAP2PLUS select OMAP_DM_TIMER)

Nishanth Menon (2):
  omap3|4: opp: make omapx_opp_init non-static
  OMAP3: beagle xm: enable upto 800MHz OPP

 arch/arm/mach-omap2/board-omap3beagle.c |   52 +++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/opp3xxx_data.c      |    3 +-
 arch/arm/mach-omap2/opp4xxx_data.c      |    3 +-
 3 files changed, 56 insertions(+), 2 deletions(-)

Tested: Beagle XM with Angstrom
Tested-by: Koen Kooi <koen@beagleboard.org>

Regards,
Nishanth Menon
