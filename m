From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Tue, 19 May 2015 14:36:49 +0800
Subject: [PATCH v4 5/7] arm64: mediatek: Add Mediatek MMC support in defconfig
In-Reply-To: <1432017411-2996-1-git-send-email-chaotian.jing@mediatek.com>
References: <1432017411-2996-1-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <1432017411-2996-6-git-send-email-chaotian.jing@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eddie Huang <eddie.huang@mediatek.com>

Add CONFIG_MMC_MTK=y in defconfig

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5c09974..5a47fce 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -140,6 +140,7 @@ CONFIG_MMC_ARMMMCI=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SPI=y
+CONFIG_MMC_MTK=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_EFI=y
 CONFIG_RTC_DRV_XGENE=y
-- 
1.8.1.1.dirty
