From: hayashibara.keiji@socionext.com (Keiji Hayashibara)
Date: Tue, 18 Jul 2017 14:24:32 +0900
Subject: [PATCH] arm64: defconfig: enable CONFIG_UNIPHIER_WATCHDOG
Message-ID: <1500355472-27521-1-git-send-email-hayashibara.keiji@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the watchdog driver for UniPhier SoC

Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6c7d147..5d204a4 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -310,6 +310,7 @@ CONFIG_WATCHDOG=y
 CONFIG_S3C2410_WATCHDOG=y
 CONFIG_MESON_GXBB_WATCHDOG=m
 CONFIG_MESON_WATCHDOG=m
+CONFIG_UNIPHIER_WATCHDOG=y
 CONFIG_RENESAS_WDT=y
 CONFIG_BCM2835_WDT=y
 CONFIG_MFD_CROS_EC=y
-- 
2.7.4
