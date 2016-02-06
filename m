From: wens@csie.org (Chen-Yu Tsai)
Date: Sat,  6 Feb 2016 23:53:48 +0800
Subject: [PATCH 5/6] ARM: multi_v7_defconfig: Enable A10 audio codec driver as
 module
In-Reply-To: <1454774029-10469-1-git-send-email-wens@csie.org>
References: <1454774029-10469-1-git-send-email-wens@csie.org>
Message-ID: <1454774029-10469-6-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A10 audio codec driver supports the on-chip audio codec found on
Allwinner A10, A10s, A13, A20 SoCs.

Build it as a module, since it is not critical.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 314f6be2dca2..03703b7ea530 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -559,6 +559,7 @@ CONFIG_SND_SOC_ROCKCHIP_RT5645=m
 CONFIG_SND_SOC_SH4_FSI=m
 CONFIG_SND_SOC_RCAR=m
 CONFIG_SND_SOC_RSRC_CARD=m
+CONFIG_SND_SUN4I_CODEC=m
 CONFIG_SND_SOC_SAMSUNG=m
 CONFIG_SND_SOC_SNOW=m
 CONFIG_SND_SOC_ODROIDX2=m
-- 
2.7.0
