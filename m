From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  7 Jan 2016 17:47:00 +0000
Subject: [PATCH] ARM: Add CONFIG_DEPRECATED_PARAM_STRUCT to netwinder_defconfig
Message-ID: <1452188820-31788-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fed up with all that fancy new 64bit HW? Look no further!
Get your NetWinder out of the closet (or in my case, the tip) and
run -next on it!

All it takes is a small defconfig change to be able to take
the parameters from the bootloader...

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/configs/netwinder_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/netwinder_defconfig b/arch/arm/configs/netwinder_defconfig
index 25ed772..4f3dfb2 100644
--- a/arch/arm/configs/netwinder_defconfig
+++ b/arch/arm/configs/netwinder_defconfig
@@ -5,6 +5,7 @@ CONFIG_ARCH_FOOTBRIDGE=y
 CONFIG_ARCH_NETWINDER=y
 CONFIG_LEDS=y
 CONFIG_LEDS_CPU=y
+CONFIG_DEPRECATED_PARAM_STRUCT=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=0x301"
-- 
2.1.4
