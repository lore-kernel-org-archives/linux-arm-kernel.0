From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 23 Jan 2013 10:48:55 +0100
Subject: [PATCH 8/9] ARM: at91/at91_dt_defconfig: add at91sam9n12 SoC to DT
 defconfig
In-Reply-To: <cover.1358934163.git.nicolas.ferre@atmel.com>
References: <cover.1358934163.git.nicolas.ferre@atmel.com>
Message-ID: <581d6299746ed264bcddc48a611343cedd10ba77.1358934163.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reported-by: Josh Wu <josh.wu@atmel.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/configs/at91_dt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index a353ff6..1ea9590 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -19,6 +19,7 @@ CONFIG_SOC_AT91SAM9260=y
 CONFIG_SOC_AT91SAM9263=y
 CONFIG_SOC_AT91SAM9G45=y
 CONFIG_SOC_AT91SAM9X5=y
+CONFIG_SOC_AT91SAM9N12=y
 CONFIG_MACH_AT91SAM_DT=y
 CONFIG_AT91_PROGRAMMABLE_CLOCKS=y
 CONFIG_AT91_TIMER_HZ=128
-- 
1.8.0
