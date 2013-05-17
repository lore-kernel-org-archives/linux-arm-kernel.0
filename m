From: linux@prisktech.co.nz (Tony Prisk)
Date: Sat, 18 May 2013 09:18:52 +1200
Subject: [PATCH 4/4] MAINTAINERS: vt8500: Add clk-vt8500.c to MAINTAINERS file
In-Reply-To: <1368825532-30917-1-git-send-email-linux@prisktech.co.nz>
References: <1368825532-30917-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <1368825532-30917-5-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This file has missed being added under ARM/VT8500 ARM ARCHITECTURE,
and is maintained along with the rest of the vt8500 arch code.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 MAINTAINERS |    1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3d7782b..5ab8ccb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1283,6 +1283,7 @@ M:	Tony Prisk <linux@prisktech.co.nz>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-vt8500/
+F:	drivers/clk/vt8500-vt8500.c
 F:	drivers/clocksource/vt8500_timer.c
 F:	drivers/gpio/gpio-vt8500.c
 F:	drivers/mmc/host/wmt-sdmmc.c
-- 
1.7.9.5
