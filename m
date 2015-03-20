From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Mar 2015 10:07:29 +0900
Subject: [PATCH 4/4] ARM: shmobile: Enable bockw board in multiplatform
 defconfig
In-Reply-To: <cover.1426813316.git.horms+renesas@verge.net.au>
References: <cover.1426813316.git.horms+renesas@verge.net.au>
Message-ID: <bb3ab878a29a3879669bb922bebce87b9a9af755.1426813316.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 1155415..b58618e 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -14,6 +14,7 @@ CONFIG_ARCH_EMEV2=y
 CONFIG_ARCH_R7S72100=y
 CONFIG_ARCH_R8A73A4=y
 CONFIG_ARCH_R8A7740=y
+CONFIG_ARCH_R8A7778=y
 CONFIG_ARCH_R8A7779=y
 CONFIG_ARCH_R8A7790=y
 CONFIG_ARCH_R8A7791=y
@@ -137,6 +138,7 @@ CONFIG_V4L_MEM2MEM_DRIVERS=y
 CONFIG_VIDEO_RENESAS_VSP1=y
 # CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
 CONFIG_VIDEO_ADV7180=y
+CONFIG_VIDEO_ML86V7667=y
 CONFIG_DRM=y
 CONFIG_DRM_RCAR_DU=y
 CONFIG_FB_SH_MOBILE_LCDC=y
@@ -171,6 +173,7 @@ CONFIG_LEDS_GPIO=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_RS5C372=y
 CONFIG_RTC_DRV_S35390A=y
+CONFIG_RTC_DRV_RX8581=y
 CONFIG_DMADEVICES=y
 CONFIG_SH_DMAE=y
 CONFIG_RCAR_DMAC=y
-- 
2.1.4
