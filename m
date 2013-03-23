From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 23 Mar 2013 13:58:22 +0100
Subject: [PATCH] ARM: kirkwood: add MACH_GURUPLUG_DT to defconfig
Message-ID: <1364043502-17716-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch just adds the missing MACH_GURUPLUG_DT to kirkwood_defconfig.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Reported-by: Soeren Moch <smoch@web.de>
---
Cc: Soeren Moch <smoch@web.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Stefan Peter <s.peter@mpl.ch>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/configs/kirkwood_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
index 13482ea..5e40f96 100644
--- a/arch/arm/configs/kirkwood_defconfig
+++ b/arch/arm/configs/kirkwood_defconfig
@@ -24,6 +24,7 @@ CONFIG_MACH_IB62X0_DT=y
 CONFIG_MACH_TS219_DT=y
 CONFIG_MACH_DOCKSTAR_DT=y
 CONFIG_MACH_GOFLEXNET_DT=y
+CONFIG_MACH_GURUPLUG_DT=y
 CONFIG_MACH_LSXL_DT=y
 CONFIG_MACH_IOMEGA_IX2_200_DT=y
 CONFIG_MACH_KM_KIRKWOOD_DT=y
-- 
1.7.10.4
