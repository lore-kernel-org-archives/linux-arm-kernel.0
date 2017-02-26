From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 26 Feb 2017 12:07:01 +0900
Subject: [PATCH] ARM: oxnas: remove redundant select CPU_V6K
Message-ID: <1488078421-3751-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MACH_OX820 depends on ARCH_MULTI_V6, which already selects CPU_V6K.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-oxnas/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-oxnas/Kconfig b/arch/arm/mach-oxnas/Kconfig
index 8fa4557..e3610c5 100644
--- a/arch/arm/mach-oxnas/Kconfig
+++ b/arch/arm/mach-oxnas/Kconfig
@@ -28,7 +28,6 @@ config MACH_OX820
 	depends on ARCH_MULTI_V6
 	select ARM_GIC
 	select DMA_CACHE_RWFO if SMP
-	select CPU_V6K
 	select HAVE_SMP
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
-- 
2.7.4
