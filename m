From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 29 May 2015 09:54:08 +0900
Subject: [PATCH] ARM: multi_v7_defconfig: Enable shmobile r8a7778/bockw
 platform
In-Reply-To: <cover.1432860785.git.horms+renesas@verge.net.au>
References: <cover.1432860785.git.horms+renesas@verge.net.au>
Message-ID: <f2a5cefbbb2c69253a8a8aa7f7f77b22f0595811.1432860785.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index ab86655c1f4b..06e7e887fea5 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -69,6 +69,7 @@ CONFIG_ARCH_EMEV2=y
 CONFIG_ARCH_R7S72100=y
 CONFIG_ARCH_R8A73A4=y
 CONFIG_ARCH_R8A7740=y
+CONFIG_ARCH_R8A7778=y
 CONFIG_ARCH_R8A7779=y
 CONFIG_ARCH_R8A7790=y
 CONFIG_ARCH_R8A7791=y
@@ -387,6 +388,7 @@ CONFIG_V4L_MEM2MEM_DRIVERS=y
 CONFIG_VIDEO_RENESAS_VSP1=m
 # CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
 CONFIG_VIDEO_ADV7180=m
+CONFIG_VIDEO_ML86V7667=m
 CONFIG_DRM=y
 CONFIG_DRM_RCAR_DU=m
 CONFIG_DRM_TEGRA=y
@@ -503,6 +505,7 @@ CONFIG_RTC_DRV_TWL4030=y
 CONFIG_RTC_DRV_TPS6586X=y
 CONFIG_RTC_DRV_TPS65910=y
 CONFIG_RTC_DRV_S35390A=m
+CONFIG_RTC_DRV_RX8581=m
 CONFIG_RTC_DRV_EM3027=y
 CONFIG_RTC_DRV_PL031=y
 CONFIG_RTC_DRV_VT8500=y
-- 
2.1.4
