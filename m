From: david@lechnology.com (David Lechner)
Date: Mon, 15 May 2017 16:53:26 -0500
Subject: [PATCH] ARM: davinci_all_defconfig: enable LEGO MINDSTORMS EV3
 battery module
Message-ID: <1494885206-22805-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the power supply module for the LEGO MINDSTORMS EV3 battery.

Signed-off-by: David Lechner <david@lechnology.com>
---

Goes along with https://patchwork.kernel.org/patch/9676087/ (which I don't see
in linux-davinci yet).

 arch/arm/configs/davinci_all_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 67db829..8857586 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -122,6 +122,7 @@ CONFIG_GPIO_PCA953X=y
 CONFIG_GPIO_PCA953X_IRQ=y
 CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_GPIO=y
+CONFIG_BATTERY_LEGO_EV3=m
 CONFIG_WATCHDOG=y
 CONFIG_DAVINCI_WATCHDOG=m
 CONFIG_MFD_DM355EVM_MSP=y
-- 
2.7.4
