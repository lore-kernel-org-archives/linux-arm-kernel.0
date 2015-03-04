From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed,  4 Mar 2015 13:14:20 +0100
Subject: [PATCH 1/2] ARM: shmobile: Enable bockw board in multiplatform
 defconfig
In-Reply-To: <1425471261-25110-1-git-send-email-geert+renesas@glider.be>
References: <1425471261-25110-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1425471261-25110-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
  - Derived from r8a7778-bockw.dtb using
    https://github.com/geertu/linux-scripts/blob/master/linux-config-from-dt
  - Not tested on bockw due to lack of hardware
---
 arch/arm/configs/shmobile_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 11554158fa96ca9c..b58618e2d13c51c8 100644
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
1.9.1
