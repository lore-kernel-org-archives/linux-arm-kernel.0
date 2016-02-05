From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat,  6 Feb 2016 02:40:41 +0900
Subject: [PATCH] ARM: keystone: remove redundant depends on ARM_PATCH_PHYS_VIRT
Message-ID: <1454694041-14990-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

KeyStone is Multi-platform.  ARM_PATCH_PHYS_VIRT is already select'ed
by ARCH_MULTIPLATFORM.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-keystone/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-keystone/Kconfig b/arch/arm/mach-keystone/Kconfig
index ea955f6db..75bcb7f 100644
--- a/arch/arm/mach-keystone/Kconfig
+++ b/arch/arm/mach-keystone/Kconfig
@@ -1,7 +1,6 @@
 config ARCH_KEYSTONE
 	bool "Texas Instruments Keystone Devices"
 	depends on ARCH_MULTI_V7
-	depends on ARM_PATCH_PHYS_VIRT
 	select ARM_GIC
 	select HAVE_ARM_ARCH_TIMER
 	select CLKSRC_MMIO
-- 
1.9.1
