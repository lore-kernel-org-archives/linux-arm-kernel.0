From: markus.mayer@linaro.org (Markus Mayer)
Date: Tue, 25 Feb 2014 14:17:42 -0800
Subject: [PATCH 0/4] ARM: bcm281xx: Consolidate code
Message-ID: <1393366666-28625-1-git-send-email-markus.mayer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series contains some code consolidation for the Broadcom BCM281xx
family of SoCs.

- Move kona_l2_cache_init() so other platforms can reuse it
- Consolidate reboot code and move it to the board specific file
- Sort header files in board file alphabetically
- Rename the board_init() function to be board specific

Markus Mayer (4):
  ARM: bcm281xx: Move kona_l2_cache_init() so it can be shared
  ARM: bcm281xx: Consolidate reboot code
  ARM: bcm281xx: Re-order hearder files
  ARM: bcm281xx: Rename board_init() function

 arch/arm/mach-bcm/board_bcm281xx.c |   74 ++++++++++++++++++------------------
 arch/arm/mach-bcm/kona.c           |   64 ++++++++++---------------------
 arch/arm/mach-bcm/kona.h           |    7 +---
 3 files changed, 59 insertions(+), 86 deletions(-)

-- 
1.7.9.5
