From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 13 Apr 2014 21:11:14 +0200
Subject: [PATCH] ARM: ux500: update defconfig
Message-ID: <1397416274-4541-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the ux500 defconfig to match the latest output of
savedefconfig.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/u8500_defconfig | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index 65f77885c167..d130a01d9342 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -1,6 +1,6 @@
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
-CONFIG_NO_HZ=y
+CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_KALLSYMS_ALL=y
@@ -10,7 +10,6 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_ARCH_U8500=y
 CONFIG_MACH_HREFV60=y
 CONFIG_MACH_SNOWBALL=y
-CONFIG_MACH_UX500_DT=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
 CONFIG_PREEMPT=y
@@ -85,8 +84,6 @@ CONFIG_AB8500_USB=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_ETH=m
 CONFIG_MMC=y
-CONFIG_MMC_UNSAFE_RESUME=y
-# CONFIG_MMC_BLOCK_BOUNCE is not set
 CONFIG_MMC_ARMMMCI=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
-- 
1.9.0
