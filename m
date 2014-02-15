From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 15 Feb 2014 02:14:19 +0100
Subject: [PATCH 2/3] ARM: at91/defconfig: Add the sam9rl to the list of
 DT-enabled SOCs
In-Reply-To: <1392426860-19589-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1392426860-19589-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1392426860-19589-3-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

at91sam9rl now has a device tree, add it to the at91_dt_defconfig.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/configs/at91_dt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index 690e89273230..c03f5f4c79f6 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -20,6 +20,7 @@ CONFIG_SOC_AT91SAM9263=y
 CONFIG_SOC_AT91SAM9G45=y
 CONFIG_SOC_AT91SAM9X5=y
 CONFIG_SOC_AT91SAM9N12=y
+CONFIG_SOC_AT91SAM9RL=y
 CONFIG_MACH_AT91RM9200_DT=y
 CONFIG_MACH_AT91SAM9_DT=y
 CONFIG_AT91_PROGRAMMABLE_CLOCKS=y
-- 
1.8.3.2
