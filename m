From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 22 Dec 2016 16:24:18 +0100
Subject: [PATCH] arm64: defconfig: enable XORv2 for Marvell Armada 7K/8K
Message-ID: <1482420258-13888-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit enables the XORv2 DMA driver, which is used on the ARM64
Marvell Armada 7K and 8K platforms.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index dab2cb0..f8b6435 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -371,6 +371,7 @@ CONFIG_RTC_DRV_TEGRA=y
 CONFIG_RTC_DRV_XGENE=y
 CONFIG_RTC_DRV_S3C=y
 CONFIG_DMADEVICES=y
+CONFIG_MV_XOR_V2=y
 CONFIG_PL330_DMA=y
 CONFIG_TEGRA20_APB_DMA=y
 CONFIG_QCOM_BAM_DMA=y
-- 
2.7.4
