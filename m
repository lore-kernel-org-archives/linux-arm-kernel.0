From: tony@atomide.com (Tony Lindgren)
Date: Fri, 14 Dec 2012 11:44:47 -0800
Subject: [PATCH 0/2] few trivial omap patches
Message-ID: <20121214194325.9874.95898.stgit@muffinssi.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here's cleanup patch to remove plat/cpu.h usage
where possible, and to add a .dts file maintainers
entry for omaps.

Regards,

Tony

---

Tony Lindgren (2):
      ARM: OMAP2+: Drop remaining plat/cpu.h usage where possible
      MAINTAINERS: Add an entry for omap related .dts files


 MAINTAINERS                      |    9 +++++++++
 arch/arm/mach-omap2/drm.c        |    1 -
 arch/arm/mach-omap2/dss-common.c |    3 +--
 arch/arm/mach-omap2/prm2xxx.c    |    3 +--
 arch/arm/mach-omap2/prm3xxx.c    |    3 +--
 drivers/power/avs/smartreflex.c  |    2 --
 6 files changed, 12 insertions(+), 9 deletions(-)

-- 
Signature
