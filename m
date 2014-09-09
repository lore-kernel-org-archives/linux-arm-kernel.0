From: yamada.m@jp.panasonic.com (Masahiro Yamada)
Date: Tue,  9 Sep 2014 19:26:18 +0900
Subject: [PATCH 0/3] kbuild: Clean up makefiles and then drop obj-n an obj-n
Message-ID: <1410258381-7088-1-git-send-email-yamada.m@jp.panasonic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org




Masahiro Yamada (3):
  kbuild: remove unnecessary "obj- := dummy.o" trick
  kbuild: remove unnecessary variable initializaions
  kbuild: remove obj-n and lib-n handling

 arch/arm/mach-at91/Makefile       | 3 ---
 arch/arm/mach-ebsa110/Makefile    | 3 ---
 arch/arm/mach-ep93xx/Makefile     | 3 ---
 arch/arm/mach-exynos/Makefile     | 5 -----
 arch/arm/mach-footbridge/Makefile | 3 ---
 arch/arm/mach-iop13xx/Makefile    | 5 -----
 arch/arm/mach-iop32x/Makefile     | 3 ---
 arch/arm/mach-iop33x/Makefile     | 3 ---
 arch/arm/mach-ks8695/Makefile     | 3 ---
 arch/arm/mach-rpc/Makefile        | 4 ----
 arch/arm/mach-s3c24xx/Makefile    | 5 -----
 arch/arm/mach-s3c64xx/Makefile    | 5 -----
 arch/arm/mach-s5pv210/Makefile    | 5 -----
 arch/arm/mach-sa1100/Makefile     | 3 ---
 arch/arm/mach-u300/Makefile       | 3 ---
 arch/arm/plat-iop/Makefile        | 6 ------
 arch/arm/plat-omap/Makefile       | 3 ---
 arch/arm/plat-samsung/Makefile    | 5 -----
 drivers/clk/shmobile/Makefile     | 2 --
 drivers/net/wimax/Makefile        | 4 ----
 firmware/Makefile                 | 2 +-
 scripts/Makefile.build            | 4 ++--
 scripts/Makefile.clean            | 4 +---
 scripts/Makefile.fwinst           | 2 +-
 24 files changed, 5 insertions(+), 83 deletions(-)

-- 
1.9.1
