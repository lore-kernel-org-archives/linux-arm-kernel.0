From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Fri, 23 Jul 2010 14:56:38 +0200
Subject: [PATCH 1/3] mbimxsd baseboards : remove unecessary include
Message-ID: <1279889800-12426-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c |    1 -
 arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c  |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c
index f07b1f9..91931dc 100644
--- a/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c
+++ b/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c
@@ -26,7 +26,6 @@
 #include <linux/input.h>
 #include <video/platform_lcd.h>
 
-#include <mach/board-eukrea_cpuimx25.h>
 #include <mach/hardware.h>
 #include <mach/iomux-mx25.h>
 #include <mach/common.h>
diff --git a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
index 368a603..1dc5004 100644
--- a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
+++ b/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
@@ -36,7 +36,6 @@
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
 
-#include <mach/board-eukrea_cpuimx35.h>
 #include <mach/hardware.h>
 #include <mach/common.h>
 #include <mach/imx-uart.h>
-- 
1.6.3.3
