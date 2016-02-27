From: carlo@caione.org (Carlo Caione)
Date: Sat, 27 Feb 2016 19:01:48 +0100
Subject: [PATCH v5 4/4] ARM: multi_v7_defconfig: Add Amlogic Meson MMC support
In-Reply-To: <1456596108-1406-1-git-send-email-carlo@caione.org>
References: <1456596108-1406-1-git-send-email-carlo@caione.org>
Message-ID: <1456596108-1406-5-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 314f6be..113b234 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -633,6 +633,7 @@ CONFIG_MMC_DW_IDMAC=y
 CONFIG_MMC_DW_PLTFM=y
 CONFIG_MMC_DW_EXYNOS=y
 CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_MESON=y
 CONFIG_MMC_SH_MMCIF=y
 CONFIG_MMC_SUNXI=y
 CONFIG_NEW_LEDS=y
-- 
1.9.1
