From: peter.chen@nxp.com (Peter Chen)
Date: Tue, 2 Aug 2016 16:22:06 +0800
Subject: [PATCH 1/1] ARM: imx_v6_v7_defconfig: enable more USB configurations
Message-ID: <1470126126-19011-1-git-send-email-peter.chen@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- USB test module
- USB gadget functions using configfs which are just ready within
  several release cycles.
- USB audio gadget

Signed-off-by: Peter Chen <peter.chen@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 4eaf023..f5b2e31 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -276,6 +276,7 @@ CONFIG_USB_SERIAL=m
 CONFIG_USB_SERIAL_GENERIC=y
 CONFIG_USB_SERIAL_FTDI_SIO=m
 CONFIG_USB_SERIAL_OPTION=m
+CONFIG_USB_TEST=m
 CONFIG_USB_EHSET_TEST_FIXTURE=m
 CONFIG_NOP_USB_XCEIV=y
 CONFIG_USB_MXS_PHY=y
@@ -293,7 +294,14 @@ CONFIG_USB_CONFIGFS_EEM=y
 CONFIG_USB_CONFIGFS_MASS_STORAGE=y
 CONFIG_USB_CONFIGFS_F_LB_SS=y
 CONFIG_USB_CONFIGFS_F_FS=y
+CONFIG_USB_CONFIGFS_F_UAC1=y
+CONFIG_USB_CONFIGFS_F_UAC2=y
+CONFIG_USB_CONFIGFS_F_MIDI=y
+CONFIG_USB_CONFIGFS_F_HID=y
+CONFIG_USB_CONFIGFS_F_UVC=y
+CONFIG_USB_CONFIGFS_F_PRINTER=y
 CONFIG_USB_ZERO=m
+CONFIG_USB_AUDIO=m
 CONFIG_USB_ETH=m
 CONFIG_USB_G_NCM=m
 CONFIG_USB_GADGETFS=m
-- 
1.9.1
