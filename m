From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Wed, 17 May 2017 23:50:17 +0800
Subject: [PATCH 4/4] ARM: imx_v6_v7_defconfig: add imx7ulp support
In-Reply-To: <1495036217-20049-1-git-send-email-aisheng.dong@nxp.com>
References: <1495036217-20049-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1495036217-20049-5-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select CONFIG_SOC_IMX7ULP by default.
Patch generated via make ARCH=arm savedefconfig

Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

---
The patch involves below config changes with savedefconfig.
CONFIG_TOUCHSCREEN_MAX11801=y
CONFIG_HID_MULTITOUCH=y
---
 arch/arm/configs/imx_v6_v7_defconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index bb6fa56..8f55e4f 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -41,6 +41,7 @@ CONFIG_SOC_IMX6SL=y
 CONFIG_SOC_IMX6SX=y
 CONFIG_SOC_IMX6UL=y
 CONFIG_SOC_IMX7D=y
+CONFIG_SOC_IMX7ULP=y
 CONFIG_SOC_VF610=y
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
@@ -163,9 +164,9 @@ CONFIG_MOUSE_PS2_ELANTECH=y
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ADS7846=y
 CONFIG_TOUCHSCREEN_EGALAX=y
+CONFIG_TOUCHSCREEN_MAX11801=y
 CONFIG_TOUCHSCREEN_IMX6UL_TSC=y
 CONFIG_TOUCHSCREEN_EDT_FT5X06=y
-CONFIG_TOUCHSCREEN_MAX11801=y
 CONFIG_TOUCHSCREEN_MC13783=y
 CONFIG_TOUCHSCREEN_TSC2004=y
 CONFIG_TOUCHSCREEN_TSC2007=y
@@ -174,7 +175,6 @@ CONFIG_TOUCHSCREEN_SX8654=y
 CONFIG_TOUCHSCREEN_COLIBRI_VF50=y
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_MMA8450=y
-CONFIG_HID_MULTITOUCH=y
 CONFIG_SERIO_SERPORT=m
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_IMX=y
@@ -268,6 +268,7 @@ CONFIG_SND_SOC_CS42XX8_I2C=y
 CONFIG_SND_SOC_TLV320AIC3X=y
 CONFIG_SND_SOC_WM8960=y
 CONFIG_SND_SIMPLE_CARD=y
+CONFIG_HID_MULTITOUCH=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_MXC=y
-- 
2.7.4
