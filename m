From: tony@atomide.com (Tony Lindgren)
Date: Thu, 18 Apr 2013 10:54:25 -0700
Subject: [PATCH 0/3] few omap randconfig fixes for v3.10
Message-ID: <20130418175303.7436.75241.stgit@muffinssi.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Few trivial fixes for randconfig found issues.

Regards,

Tony

---

Tony Lindgren (3):
      ARM: OMAP2+: Fix unmet direct dependencies for SERIAL_OMAP
      ARM: OMAP2+: Fix unused variable warning for am3517 crane
      ARM: OMAP2+: Fix is_gpmc_muxed warning for H4


 arch/arm/configs/omap2plus_defconfig    |    2 ++
 arch/arm/mach-omap2/Kconfig             |    2 --
 arch/arm/mach-omap2/board-am3517crane.c |    2 --
 arch/arm/mach-omap2/board-h4.c          |    4 ++--
 4 files changed, 4 insertions(+), 6 deletions(-)

-- 
Signature
