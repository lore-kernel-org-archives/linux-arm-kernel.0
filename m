From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 28 Aug 2014 14:40:22 +0200
Subject: [PATCH] ARM: shmobile: Enable Armadillo 800 EVA board in
 multiplatform defconfig
Message-ID: <1409229622-11566-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/configs/shmobile_defconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index fa94612d72cc..d3bced4555aa 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -13,6 +13,7 @@ CONFIG_SLAB=y
 CONFIG_ARCH_SHMOBILE_MULTI=y
 CONFIG_ARCH_EMEV2=y
 CONFIG_ARCH_R7S72100=y
+CONFIG_ARCH_R8A7740=y
 CONFIG_ARCH_R8A7779=y
 CONFIG_ARCH_R8A7790=y
 CONFIG_ARCH_R8A7791=y
@@ -75,6 +76,8 @@ CONFIG_SMSC_PHY=y
 # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 CONFIG_KEYBOARD_GPIO=y
 # CONFIG_INPUT_MOUSE is not set
+CONFIG_INPUT_TOUCHSCREEN=y
+CONFIG_TOUCHSCREEN_ST1232=y
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
@@ -113,10 +116,16 @@ CONFIG_VIDEO_RENESAS_VSP1=y
 CONFIG_VIDEO_ADV7180=y
 CONFIG_DRM=y
 CONFIG_DRM_RCAR_DU=y
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
+# CONFIG_LCD_CLASS_DEVICE is not set
+# CONFIG_BACKLIGHT_GENERIC is not set
+CONFIG_BACKLIGHT_PWM=y
 CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_SOC=y
+CONFIG_SND_SOC_SH4_FSI=y
 CONFIG_SND_SOC_RCAR=y
+CONFIG_SND_SOC_WM8978=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_OHCI_HCD=y
@@ -133,9 +142,12 @@ CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
 CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_S35390A=y
 CONFIG_DMADEVICES=y
 CONFIG_SH_DMAE=y
 # CONFIG_IOMMU_SUPPORT is not set
+CONFIG_PWM=y
+CONFIG_PWM_RENESAS_TPU=y
 # CONFIG_DNOTIFY is not set
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
-- 
1.9.1
