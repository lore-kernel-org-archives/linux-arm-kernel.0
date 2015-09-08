From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Tue,  8 Sep 2015 22:38:06 +0200
Subject: [PATCH v2 3/3] ARM: configs: Set FORCE_MAX_ZONEORDER to 9 in
 efm32_defconfig
In-Reply-To: <1441744686-20521-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1441744686-20521-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <1441744686-20521-4-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

FORCE_MAX_ZONEORDER has now to be configured in defconfig for ARMV7
platforms.

Cc: Uwe Kleine-K?nig <kernel@pengutronix.de>
Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 arch/arm/configs/efm32_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/efm32_defconfig b/arch/arm/configs/efm32_defconfig
index c0dac0f0f..884f16e 100644
--- a/arch/arm/configs/efm32_defconfig
+++ b/arch/arm/configs/efm32_defconfig
@@ -24,6 +24,7 @@ CONFIG_DRAM_SIZE=0x00400000
 CONFIG_FLASH_MEM_BASE=0x8c000000
 CONFIG_FLASH_SIZE=0x01000000
 CONFIG_PREEMPT=y
+CONFIG_FORCE_MAX_ZONEORDER=9
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_XIP_KERNEL=y
-- 
1.9.1
