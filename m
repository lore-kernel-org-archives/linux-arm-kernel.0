From: arete74@gmail.com (Gerardo Di Iorio)
Date: Thu, 9 Jan 2014 16:34:04 +0100
Subject: [PATCH] ARM: sunxi: change the AllWinner A1X to sunxi
Message-ID: <20140109153404.GA21055@kvmhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the AllWinner A1X SOCs to Allwinner Sunxi SOCs

Signed-off-by: Gerardo Di Iorio <arete74@gmail.com>
---
 arch/arm/mach-sunxi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 547004c..adb2574 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -1,5 +1,5 @@
 config ARCH_SUNXI
-       bool "Allwinner A1X SOCs" if ARCH_MULTI_V7
+       bool "Allwinner Sunxi SOCs" if ARCH_MULTI_V7
        select ARCH_HAS_RESET_CONTROLLER
        select ARCH_REQUIRE_GPIOLIB
        select ARM_GIC
--
1.8.4.2
