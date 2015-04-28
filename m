From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Tue, 28 Apr 2015 17:48:45 +0800
Subject: [PATCH 7/7] ARM: multi_v7_defconfig: Enable Mediatek MMC support
 multi-v7
In-Reply-To: <1430214525-19198-1-git-send-email-chaotian.jing@mediatek.com>
References: <1430214525-19198-1-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <1430214525-19198-8-git-send-email-chaotian.jing@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yingjoe Chen <yingjoe.chen@mediatek.com>

Add CONFIG_MMC_MTK=y in defconfig

Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index bc673e7..35447b2 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -451,6 +451,7 @@ CONFIG_MMC_DW_EXYNOS=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SH_MMCIF=y
 CONFIG_MMC_SUNXI=y
+CONFIG_MMC_MTK=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
-- 
1.8.1.1.dirty
