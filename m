From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 30 Mar 2010 01:56:38 -0600
Subject: [PATCH 0/4] OMAP clock/hwmod fixes for 2.6.34-rc
Message-ID: <20100330074801.11629.61888.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

here are some OMAP clock and hwmod fix patches that we're planning to
send upstream soon; comments welcome.


- Paul


---

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
