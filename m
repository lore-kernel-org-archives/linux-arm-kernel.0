From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 31 Mar 2010 07:32:47 -0600 (MDT)
Subject: [GIT PULL] OMAP clock/hwmod fixes for 2.6.34-rc
Message-ID: <alpine.DEB.2.00.1003310731500.14436@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Tony,

The following changes since commit 2eaa9cfdf33b8d7fb7aff27792192e0019ae8fc6:
  Linus Torvalds (1):
        Linux 2.6.34-rc3

are available in the git repository at:

  git://git.pwsan.com/linux-2.6 for_2.6.34rc_a

Rajendra Nayak (1):
      OMAP4: prcm: Use logical OR instead of bitwise OR

Ranjith Lohithakshan (1):
      OMAP3: clock: fix enable bit used for dpll4_m4x2 clock

Thara Gopinath (2):
      OMAP: HWMOD: Adding clockdomain check
      OMAP: HWMOD: Bug fixes in hwmod structure definitions

 arch/arm/mach-omap2/clock3xxx_data.c         |    2 +-
 arch/arm/mach-omap2/clockdomain.c            |    6 +++---
 arch/arm/mach-omap2/omap_hwmod.c             |    3 +++
 arch/arm/mach-omap2/powerdomain.c            |    2 +-
 arch/arm/mach-omap2/prcm.c                   |    4 ++--
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 +-
 6 files changed, 11 insertions(+), 8 deletions(-)


- Paul
