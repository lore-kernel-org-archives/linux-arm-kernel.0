From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Thu, 6 Feb 2014 13:56:26 +0530
Subject: [PATCH 0/3] ARM: OMAP2+: AM43x: Enable in OMAP2PLUS and add ID for
 ES1.1
Message-ID: <1391675189-10608-1-git-send-email-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series enables AM43XX SOC in omap2plus_deconfig along with
updating clocksource and adding support for ES1.1.
With this series using omap2plus_defconfig alone boots on AM43XX.

Tested on: AM4372 EPOS EVM

Afzal Mohammed (1):
  ARM: OMAP2+: AM43x: enable in default config

Lokesh Vutla (1):
  ARM: OMAP2+: AM43x: Add ID for ES1.1

Rajendra Nayak (1):
  ARM: OMAP2+: AM43x: Use gptimer as clocksource

 arch/arm/configs/omap2plus_defconfig |    1 +
 arch/arm/mach-omap2/board-generic.c  |    2 +-
 arch/arm/mach-omap2/id.c             |   14 ++++++++++++--
 arch/arm/mach-omap2/soc.h            |    3 ++-
 arch/arm/mach-omap2/timer.c          |    3 ++-
 5 files changed, 18 insertions(+), 5 deletions(-)

-- 
1.7.9.5
