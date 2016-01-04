From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Mon,  4 Jan 2016 11:17:14 +0800
Subject: [PATCH] ARM: multi_v7_defconfig: remove CONFIG_MMC_DW_IDMAC
Message-ID: <1451877434-21516-1-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dw_mmc driver never use this macro, so remove it from
multi_v7_defconfig

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 arch/arm/configs/multi_v7_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 69a22fd..c362199 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -571,7 +571,6 @@ CONFIG_MMC_ATMELMCI=y
 CONFIG_MMC_MVSDIO=y
 CONFIG_MMC_SDHI=y
 CONFIG_MMC_DW=y
-CONFIG_MMC_DW_IDMAC=y
 CONFIG_MMC_DW_PLTFM=y
 CONFIG_MMC_DW_EXYNOS=y
 CONFIG_MMC_DW_ROCKCHIP=y
-- 
2.3.7
