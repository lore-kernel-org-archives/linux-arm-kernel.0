From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 21 Jul 2017 18:20:03 +0200
Subject: [PATCH 2/4] arm: sunxi: refresh the defconfig
In-Reply-To: <20170721162005.18892-1-maxime.ripard@free-electrons.com>
References: <20170721162005.18892-1-maxime.ripard@free-electrons.com>
Message-ID: <20170721162005.18892-2-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the defconfig with the current state of defaults.

This was done using make sunxi_defconfig; make savedefconfig

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/configs/sunxi_defconfig | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 0ec1d1ec130f..400eb9366a66 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -1,4 +1,3 @@
-CONFIG_FHANDLE=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_CGROUPS=y
@@ -56,7 +55,6 @@ CONFIG_STMMAC_ETH=y
 # CONFIG_NET_VENDOR_VIA is not set
 # CONFIG_NET_VENDOR_WIZNET is not set
 # CONFIG_WLAN is not set
-# CONFIG_INPUT_MOUSEDEV is not set
 CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_SUN4I_LRADC=y
 # CONFIG_INPUT_MOUSE is not set
@@ -71,7 +69,6 @@ CONFIG_SERIAL_8250_RUNTIME_UARTS=8
 CONFIG_SERIAL_8250_DW=y
 CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_HW_RANDOM is not set
-CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MV64XXX=y
 CONFIG_I2C_SUN6I_P2WI=y
@@ -82,12 +79,10 @@ CONFIG_GPIO_SYSFS=y
 CONFIG_POWER_SUPPLY=y
 CONFIG_AXP20X_POWER=y
 CONFIG_THERMAL=y
-CONFIG_THERMAL_OF=y
 CONFIG_CPU_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_SUNXI_WATCHDOG=y
 CONFIG_MFD_AC100=y
-CONFIG_MFD_AXP20X=y
 CONFIG_MFD_AXP20X_I2C=y
 CONFIG_MFD_AXP20X_RSB=y
 CONFIG_REGULATOR=y
@@ -99,12 +94,9 @@ CONFIG_MEDIA_RC_SUPPORT=y
 CONFIG_RC_DEVICES=y
 CONFIG_IR_SUNXI=y
 CONFIG_DRM=y
-CONFIG_DRM_DUMB_VGA_DAC=y
 CONFIG_DRM_SUN4I=y
-CONFIG_FB=y
+CONFIG_DRM_DUMB_VGA_DAC=y
 CONFIG_FB_SIMPLE=y
-CONFIG_FRAMEBUFFER_CONSOLE=y
-CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
 CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_SOC=y
@@ -130,7 +122,6 @@ CONFIG_RTC_CLASS=y
 # CONFIG_RTC_INTF_SYSFS is not set
 # CONFIG_RTC_INTF_PROC is not set
 CONFIG_RTC_DRV_AC100=y
-CONFIG_RTC_DRV_SUN6I=y
 CONFIG_RTC_DRV_SUNXI=y
 CONFIG_DMADEVICES=y
 CONFIG_DMA_SUN6I=y
-- 
2.13.3
