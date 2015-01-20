From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 20 Jan 2015 20:57:50 +0900
Subject: [PATCH 00/03] ARM: shmobile: Minor header cleanup
Message-ID: <20150120115750.11479.95109.sendpatchset@little-apple>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: Minor header cleanup

[PATCH 01/03] ARM: shmobile: Remove mach/system.h
[PATCH 02/03] ARM: shmobile: Remove mach/clkdev.h
[PATCH 03/03] ARM: shmobile: Remove mach/uncompress.h

Rework the mach-shmobile code a bit more to allow
removing the files system.h, clkdev.h and uncompress.h
from arch/arm/mach-shmobile/include/mach/

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Built on top of renesas-devel-20150119-v3.19-rc5

 arch/arm/Kconfig                                 |    1 -
 arch/arm/Kconfig.debug                           |    3 ++-
 arch/arm/mach-shmobile/clock.c                   |   11 -----------
 arch/arm/mach-shmobile/include/mach/clkdev.h     |    7 -------
 arch/arm/mach-shmobile/include/mach/system.h     |   11 -----------
 arch/arm/mach-shmobile/include/mach/uncompress.h |   19 -------------------
 6 files changed, 2 insertions(+), 50 deletions(-)
