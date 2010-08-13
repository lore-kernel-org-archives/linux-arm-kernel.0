From: tony@atomide.com (Tony Lindgren)
Date: Fri, 13 Aug 2010 11:01:38 +0300
Subject: [PATCH 0/6] omap fixes for upcoming 2.6.36-rc1
Message-ID: <20100813080034.18750.15410.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here are some omap fixes for review.

Regards,

Tony

---

Kevin Hilman (1):
      OMAP3: PM: ensure IO wakeups are properly disabled

Nishanth Menon (1):
      omap3: id: fix 3630 rev detection

Tony Lindgren (3):
      omap: Fix sev instruction usage for multi-omap
      omap: Use CONFIG_SMP for test_for_ipi and test_for_ltirq
      omap: Fix omap_4430sdp_defconfig for make oldconfig

stanley.miao (1):
      OMAP3: Fix a cpu type check problem


 arch/arm/configs/omap_4430sdp_defconfig        |    3 +++
 arch/arm/mach-omap2/Makefile                   |    1 +
 arch/arm/mach-omap2/clock3xxx_data.c           |   14 +++++++-------
 arch/arm/mach-omap2/id.c                       |    2 +-
 arch/arm/mach-omap2/include/mach/entry-macro.S |    6 ++++--
 arch/arm/mach-omap2/omap-smp.c                 |    3 +--
 arch/arm/mach-omap2/pm34xx.c                   |    4 +++-
 arch/arm/plat-omap/include/plat/smp.h          |    7 -------
 8 files changed, 20 insertions(+), 20 deletions(-)

-- 
Signature
