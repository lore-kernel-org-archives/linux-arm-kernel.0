From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 25 Jan 2012 14:24:08 -0700 (MST)
Subject: [GIT PULL] ARM: OMAP: hwmod/PRCM/OMAP2xxx fixes for 3.3
Message-ID: <alpine.DEB.2.00.1201251420490.5324@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony

The following changes since commit dcd6c92267155e70a94b3927bce681ce74b80d1f:

  Linux 3.3-rc1 (2012-01-19 15:04:48 -0800)

are available in the git repository at:
  git://git.pwsan.com/linux-2.6 omap_fixes_a_3.3rc

Ilya Yanok (1):
      ARM: OMAP3: hwmod data: register dss hwmods after dss_core

Paul Walmsley (2):
      ARM: OMAP2+: io: fix compilation breakage on 2420-only configs
      ARM: OMAP2/3: PRM: fix missing plat/irqs.h build breakage

Peter Ujfalusi (1):
      ARM: OMAP4: hwmod data: Add names for DMIC memory address space

Tomi Valkeinen (2):
      ARM: OMAP2+: hwmod data: split omap2/3 dispc hwmod class
      ARM: OMAP3: hwmod data: add SYSC_HAS_ENAWAKEUP for dispc

 arch/arm/mach-omap2/io.c                           |    4 +-
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |   21 --------
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   22 ++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   54 +++++++++++++++++---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    2 +
 arch/arm/mach-omap2/prm2xxx_3xxx.c                 |    1 +
 6 files changed, 75 insertions(+), 29 deletions(-)
