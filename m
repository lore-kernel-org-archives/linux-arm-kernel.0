From: tranmanphong@gmail.com (Phong Tran)
Date: Wed, 23 Mar 2016 21:09:24 +0700
Subject: [PATCH] arm64: defconfig: Fix warning override MMC_BLOCK_MINORS
Message-ID: <1458742164-9883-1-git-send-email-tranmanphong@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the duplicate of defination of CONFIG_MMC_BLOCK_MINORS.
Fixes 22b0898 ("arm64: add defconfig options for Allwinner SoCs")

Signed-off-by: Phong Tran <tranmanphong@gmail.com>
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
