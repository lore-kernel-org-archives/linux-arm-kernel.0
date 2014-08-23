From: horms+renesas@verge.net.au (Simon Horman)
Date: Sat, 23 Aug 2014 10:44:10 +0900
Subject: [PATCH 5/8] ARM: shmobile: kzm9g_defconfig: Enable missing hardware
 support
In-Reply-To: <cover.1408670623.git.horms+renesas@verge.net.au>
References: <cover.1408670623.git.horms+renesas@verge.net.au>
Message-ID: <489610f3324dc1f94c816f4053215d7540871875.1408670623.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Based on the DTS

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/kzm9g_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/kzm9g_defconfig b/arch/arm/configs/kzm9g_defconfig
index bd097d4..8cb115d 100644
--- a/arch/arm/configs/kzm9g_defconfig
+++ b/arch/arm/configs/kzm9g_defconfig
@@ -119,6 +119,7 @@ CONFIG_MMC_SDHI=y
 CONFIG_MMC_SH_MMCIF=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_RS5C372=y
 CONFIG_DMADEVICES=y
-- 
2.0.1
