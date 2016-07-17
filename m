From: baruch@tkos.co.il (Baruch Siach)
Date: Sun, 17 Jul 2016 11:35:29 +0300
Subject: [PATCH] ARM: mps2: fix typo
Message-ID: <f607bbd274fe705955116ba590d31ac788f402bf.1468744529.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 90542db1220d..8ebe5d86b707 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -901,7 +901,7 @@ config MACH_STM32F429
 	default y
 
 config ARCH_MPS2
-	bool "ARM MPS2 paltform"
+	bool "ARM MPS2 platform"
 	depends on ARM_SINGLE_ARMV7M
 	select ARM_AMBA
 	select CLKSRC_MPS2
-- 
2.8.1
