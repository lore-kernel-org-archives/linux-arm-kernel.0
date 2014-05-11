From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 12 May 2014 08:25:08 +0900
Subject: [PATCH 00/03] ARM: shmobile: Use shmobile_init_delay() on r8a7791
Message-ID: <20140511232508.20177.11556.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: Use shmobile_init_delay() on r8a7791

[PATCH 01/03] ARM: shmobile: Use r8a7791 DT CPU Frequency in common case	
[PATCH 02/03] ARM: shmobile: Use r8a7791 DT CPU Frequency for Koelsch
[PATCH 03/03] ARM: shmobile: Remove unused r8a7791_init_early()

Convert r8a7791 to rely on shmobile_init_delay() instead of using a per-SoC
delay setup function.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written against renesas-devel-v3.15-rc5-20140511

 arch/arm/mach-shmobile/board-koelsch-reference.c |    2 +-
 arch/arm/mach-shmobile/board-koelsch.c           |    2 +-
 arch/arm/mach-shmobile/include/mach/r8a7791.h    |    1 -
 arch/arm/mach-shmobile/setup-r8a7791.c           |    9 +--------
 4 files changed, 3 insertions(+), 11 deletions(-)
