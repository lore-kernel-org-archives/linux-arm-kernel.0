From: leo.yan@linaro.org (Leo Yan)
Date: Mon, 28 Mar 2016 23:28:48 +0800
Subject: [PATCH] arm64: defconfig: remove redundant CONFIG_MMC_BLOCK_MINORS
Message-ID: <1459178928-26973-1-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There have two patches to add CONFIG_MMC_BLOCK_MINORS twice:
22b0898e8 ("arm64: add defconfig options for Allwinner SoCs"),
2f85bb09d ("arm64: defconfig: Increase MMC_BLOCK_MINORS to 16");

So remove redundant CONFIG_MMC_BLOCK_MINORS to only enable once.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/configs/defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f705051..3ad26ff 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -215,7 +215,6 @@ CONFIG_MMC_SPI=y
 CONFIG_MMC_SUNXI=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_EXYNOS=y
-CONFIG_MMC_BLOCK_MINORS=16
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_SYSCON=y
-- 
1.9.1
