From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Tue, 27 Jan 2015 14:15:28 +0800
Subject: [PATCH 3/7] ARM: mediatek: Add Mediatek MMC support in
 multi_v7_defconfig
In-Reply-To: <1422339332-27498-1-git-send-email-chaotian.jing@mediatek.com>
References: <1422339332-27498-1-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <1422339332-27498-4-git-send-email-chaotian.jing@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add CONFIG_MMC_MTK=y in multi_v7_defconfig

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 19e58aa..7eea580 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -362,6 +362,7 @@ CONFIG_MMC_DW_IDMAC=y
 CONFIG_MMC_DW_EXYNOS=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SUNXI=y
+CONFIG_MMC_MTK=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
-- 
1.8.1.1.dirty
