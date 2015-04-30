From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 30 Apr 2015 15:06:29 +0300
Subject: [PATCH] ARM: sti: fix documentation reference
Message-ID: <d0f22751247391d5f7f1b8ebec507a8e0c4b4943.1430395589.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/mach-sti/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-sti/Kconfig b/arch/arm/mach-sti/Kconfig
index 3b1ac463a494..f7d42ddf95f6 100644
--- a/arch/arm/mach-sti/Kconfig
+++ b/arch/arm/mach-sti/Kconfig
@@ -17,7 +17,7 @@ menuconfig ARCH_STI
 	help
 	  Include support for STiH41x SOCs like STiH415/416 using the device tree
 	  for discovery
-	  More information at Documentation/arm/STiH41x and
+	  More information at Documentation/arm/sti and
 	  at Documentation/devicetree
 
 
-- 
2.1.4
