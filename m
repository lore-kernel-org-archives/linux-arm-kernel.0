From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 18 Dec 2015 14:19:54 +0100
Subject: [PATCH] ARM: realview: select apropriate targets in defconfig
Message-ID: <1450444794-18478-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After adding multiplatform support for the RealView, we need
to add the apropriate targets to the defconfig so we get the
full range of supported devices. This amends both the defconfig
files for this.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/realview-smp_defconfig | 6 ++++++
 arch/arm/configs/realview_defconfig     | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/configs/realview-smp_defconfig b/arch/arm/configs/realview-smp_defconfig
index 1da5d9e48224..b10949545e76 100644
--- a/arch/arm/configs/realview-smp_defconfig
+++ b/arch/arm/configs/realview-smp_defconfig
@@ -9,9 +9,15 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_CFQ is not set
 CONFIG_ARCH_REALVIEW=y
+CONFIG_REALVIEW_DT=y
 CONFIG_MACH_REALVIEW_EB=y
+CONFIG_REALVIEW_EB_A9MP=y
 CONFIG_REALVIEW_EB_ARM11MP=y
+CONFIG_REALVIEW_EB_ARM11MP_REVB=y
 CONFIG_MACH_REALVIEW_PB11MP=y
+CONFIG_MACH_REALVIEW_PB1176=y
+CONFIG_MACH_REALVIEW_PBA8=y
+CONFIG_MACH_REALVIEW_PBX=y
 CONFIG_SMP=y
 CONFIG_HOTPLUG_CPU=y
 CONFIG_AEABI=y
diff --git a/arch/arm/configs/realview_defconfig b/arch/arm/configs/realview_defconfig
index d02e9d911bb7..8ba19ea592cf 100644
--- a/arch/arm/configs/realview_defconfig
+++ b/arch/arm/configs/realview_defconfig
@@ -9,10 +9,15 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_CFQ is not set
 CONFIG_ARCH_REALVIEW=y
+CONFIG_REALVIEW_DT=y
 CONFIG_MACH_REALVIEW_EB=y
+CONFIG_REALVIEW_EB_A9MP=y
 CONFIG_REALVIEW_EB_ARM11MP=y
+CONFIG_REALVIEW_EB_ARM11MP_REVB=y
 CONFIG_MACH_REALVIEW_PB11MP=y
 CONFIG_MACH_REALVIEW_PB1176=y
+CONFIG_MACH_REALVIEW_PBA8=y
+CONFIG_MACH_REALVIEW_PBX=y
 CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-- 
2.4.3
