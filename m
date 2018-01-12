From: david@lechnology.com (David Lechner)
Date: Thu, 11 Jan 2018 20:29:51 -0600
Subject: [PATCH v2 2/2] ARM: davinci_all_defconfig: enable SYSCON_REBOOT_MODE
In-Reply-To: <1515724191-30499-1-git-send-email-david@lechnology.com>
References: <1515724191-30499-1-git-send-email-david@lechnology.com>
Message-ID: <1515724191-30499-3-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables SYSCON_REBOOT_MODE as a module. This is used by LEGO
MINDSTORMS EV3 to reboot into a special firmware update mode.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/configs/davinci_all_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 026154c..bcb70c2 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -126,6 +126,7 @@ CONFIG_GPIO_PCA953X=y
 CONFIG_GPIO_PCA953X_IRQ=y
 CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_GPIO=y
+CONFIG_SYSCON_REBOOT_MODE=m
 CONFIG_BATTERY_LEGO_EV3=m
 CONFIG_WATCHDOG=y
 CONFIG_DAVINCI_WATCHDOG=m
-- 
2.7.4
