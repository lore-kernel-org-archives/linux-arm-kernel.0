From: xuejiancheng@hisilicon.com (Jiancheng Xue)
Date: Fri, 19 May 2017 19:29:37 +0800
Subject: [PATCH] arm64: defconfig: enable several drivers for HiSilicon
 Hi3798CV200 SoC
Message-ID: <1495193377-22143-1-git-send-email-xuejiancheng@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the following drivers for HiSilicon Hi3798CV200 SoC:
ethernet, i2c and ir.

Signed-off-by: Jiancheng Xue <xuejiancheng@hisilicon.com>
---
 arch/arm64/configs/defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ce07285..40251bd 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -181,6 +181,7 @@ CONFIG_VIRTIO_NET=y
 CONFIG_AMD_XGBE=y
 CONFIG_NET_XGENE=y
 CONFIG_MACB=y
+CONFIG_HIX5HD2_GMAC=y
 CONFIG_HNS_DSAF=y
 CONFIG_HNS_ENET=y
 CONFIG_E1000E=y
@@ -260,6 +261,7 @@ CONFIG_I2C_TEGRA=y
 CONFIG_I2C_UNIPHIER_F=y
 CONFIG_I2C_RCAR=y
 CONFIG_I2C_CROS_EC_TUNNEL=y
+CONFIG_I2C_HIX5HD2=y
 CONFIG_SPI=y
 CONFIG_SPI_MESON_SPIFC=m
 CONFIG_SPI_BCM2835=m
@@ -360,6 +362,11 @@ CONFIG_BACKLIGHT_GENERIC=m
 CONFIG_BACKLIGHT_LP855X=m
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_LOGO=y
+CONFIG_MEDIA_SUPPORT=y
+CONFIG_MEDIA_RC_SUPPORT=y
+CONFIG_RC_DEVICES=y
+CONFIG_IR_HIX5HD2=y
+CONFIG_LIRC=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
 CONFIG_SOUND=y
@@ -485,6 +492,7 @@ CONFIG_PWM_ROCKCHIP=y
 CONFIG_PWM_TEGRA=m
 CONFIG_PWM_MESON=m
 CONFIG_COMMON_RESET_HI6220=y
+CONFIG_TI_SYSCON_RESET=y
 CONFIG_PHY_RCAR_GEN3_USB2=y
 CONFIG_PHY_HI6220_USB=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
-- 
1.9.1
