From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Aug 2016 14:40:28 +0200
Subject: [PATCH 3/5] ARM: realview: cut board options from defconfig
In-Reply-To: <1470832830-10274-1-git-send-email-linus.walleij@linaro.org>
References: <1470832830-10274-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1470832830-10274-4-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This kills off the now unused board configuration symbols for
the different RealView boards from the RealView defconfig.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/realview_defconfig | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm/configs/realview_defconfig b/arch/arm/configs/realview_defconfig
index 9e77dc7b828f..7824b8bf9894 100644
--- a/arch/arm/configs/realview_defconfig
+++ b/arch/arm/configs/realview_defconfig
@@ -11,17 +11,6 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_IOSCHED_CFQ is not set
 CONFIG_ARCH_MULTI_V6=y
 CONFIG_ARCH_REALVIEW=y
-CONFIG_REALVIEW_DT=y
-CONFIG_MACH_REALVIEW_EB=y
-CONFIG_REALVIEW_EB_ARM1136=y
-CONFIG_REALVIEW_EB_ARM1176=y
-CONFIG_REALVIEW_EB_A9MP=y
-CONFIG_REALVIEW_EB_ARM11MP=y
-CONFIG_REALVIEW_EB_ARM11MP_REVB=y
-CONFIG_MACH_REALVIEW_PB11MP=y
-CONFIG_MACH_REALVIEW_PB1176=y
-CONFIG_MACH_REALVIEW_PBA8=y
-CONFIG_MACH_REALVIEW_PBX=y
 CONFIG_SMP=y
 CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
-- 
2.7.4
