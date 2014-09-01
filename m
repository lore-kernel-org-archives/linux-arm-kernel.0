From: Li.Xiubo@freescale.com (Xiubo Li)
Date: Mon, 1 Sep 2014 12:42:21 +0800
Subject: [PATCH] ARM: Kconfig: Open force maximum zone order for all SoCs
Message-ID: <1409546541-4129-1-git-send-email-Li.Xiubo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c49a775..bf8445c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1687,7 +1687,7 @@ config ARCH_WANT_GENERAL_HUGETLB
 source "mm/Kconfig"
 
 config FORCE_MAX_ZONEORDER
-	int "Maximum zone order" if ARCH_SHMOBILE_LEGACY
+	int "Maximum zone order"
 	range 11 64 if ARCH_SHMOBILE_LEGACY
 	default "12" if SOC_AM33XX
 	default "9" if SA1111 || ARCH_EFM32
-- 
1.8.4
