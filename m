From: bhumirks@gmail.com (Bhumika Goyal)
Date: Mon,  6 Nov 2017 14:15:38 +0100
Subject: [PATCH 0/2] ARM: OMAP2+: CM: make some structures,
 function arguments and pointers as const
Message-ID: <1509974140-10860-1-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make some pointers and function arguments as const. After this change,
make the structures of type cm_ll_data as const.

Bhumika Goyal (2):
  ARM: OMAP2+: CM: make some pointers and function arguments as const
  ARM: OMAP2+: CM: make cm_ll_data structures as const

 arch/arm/mach-omap2/cm.h         | 4 ++--
 arch/arm/mach-omap2/cm2xxx.c     | 2 +-
 arch/arm/mach-omap2/cm33xx.c     | 2 +-
 arch/arm/mach-omap2/cm3xxx.c     | 2 +-
 arch/arm/mach-omap2/cm_common.c  | 6 +++---
 arch/arm/mach-omap2/cminst44xx.c | 2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)

-- 
1.9.1
