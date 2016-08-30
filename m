From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 30 Aug 2016 12:00:35 +0100
Subject: [PATCH 3/8] ARM: sa1100/cerf: remove redundant definitions
In-Reply-To: <20160830105950.GA15580@n2100.armlinux.org.uk>
References: <20160830105950.GA15580@n2100.armlinux.org.uk>
Message-ID: <E1begmR-0007IA-UE@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove redundant CF GPIO definitions from mach/cerf.h

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/include/mach/cerf.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/mach-sa1100/include/mach/cerf.h b/arch/arm/mach-sa1100/include/mach/cerf.h
index 88fd9c006ce0..f9f2222f013b 100644
--- a/arch/arm/mach-sa1100/include/mach/cerf.h
+++ b/arch/arm/mach-sa1100/include/mach/cerf.h
@@ -10,14 +10,7 @@
 #ifndef _INCLUDE_CERF_H_
 #define _INCLUDE_CERF_H_
 
-
 #define CERF_ETH_IO			0xf0000000
 #define CERF_ETH_IRQ IRQ_GPIO26
 
-#define CERF_GPIO_CF_BVD2		19
-#define CERF_GPIO_CF_BVD1		20
-#define CERF_GPIO_CF_RESET		21
-#define CERF_GPIO_CF_IRQ		22
-#define CERF_GPIO_CF_CD			23
-
 #endif // _INCLUDE_CERF_H_
-- 
2.1.0
