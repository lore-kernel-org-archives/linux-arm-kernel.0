From: vz@mleia.com (Vladimir Zapolskiy)
Date: Sun,  1 Nov 2015 02:05:40 +0200
Subject: [PATCH] arm: lpc32xx: remove selected HAVE_IDE
Message-ID: <1446336340-20291-1-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NXP LPC32xx platform does not have any controller capable for disk
drives, selection of HAVE_IDE is not needed.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 72ad724..393c394 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -595,7 +595,6 @@ config ARCH_LPC32XX
 	select CLKSRC_MMIO
 	select CPU_ARM926T
 	select GENERIC_CLOCKEVENTS
-	select HAVE_IDE
 	select USE_OF
 	help
 	  Support for the NXP LPC32XX family of processors
-- 
2.1.4
