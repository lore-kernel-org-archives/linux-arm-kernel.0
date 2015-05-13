From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 13 May 2015 12:29:22 +0200
Subject: [PATCH 1/2] ARM: ux500: add PERF_EVENTS to defconfig
Message-ID: <1431512962-24943-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Ux500 has a perfectly working PMU so let's put the perf
events into the defconfig. This will activate HW_PERF_EVENTS
by default.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC people: please apply this directly to the ARM SoC
tree in an appropriate place.
---
 arch/arm/configs/u8500_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index 6a1c9898fd03..b4c6d34ef946 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -4,6 +4,7 @@ CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_KALLSYMS_ALL=y
+CONFIG_PERF_EVENTS=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-- 
1.9.3
