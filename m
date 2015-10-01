From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu,  1 Oct 2015 13:57:38 +0100
Subject: [PATCH] ARM: multi_v7_defconfig: Add missing QCOM APQ8064 configs
Message-ID: <1443704258-3180-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds few missing essential configs in the multi_v7_defconf,
absense of some configs like PINCTRL_APQ8064 would prevent the board from
getting access to serial.

cc: Kevin Hilman <khilman@kernel.org>
cc: Tyler Baker <tyler.baker@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 03deb7f..ed76cd9 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -332,6 +332,7 @@ CONFIG_SPI_XILINX=y
 CONFIG_SPI_SPIDEV=y
 CONFIG_PINCTRL_AS3722=y
 CONFIG_PINCTRL_PALMAS=y
+CONFIG_PINCTRL_APQ8064=y
 CONFIG_PINCTRL_APQ8084=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_GENERIC_PLATFORM=y
@@ -391,6 +392,8 @@ CONFIG_MFD_MAX14577=y
 CONFIG_MFD_MAX77686=y
 CONFIG_MFD_MAX77693=y
 CONFIG_MFD_MAX8907=y
+CONFIG_MFD_PM8921_CORE=y
+CONFIG_MFD_QCOM_RPM=y
 CONFIG_MFD_SEC_CORE=y
 CONFIG_MFD_STMPE=y
 CONFIG_MFD_PALMAS=y
@@ -415,6 +418,7 @@ CONFIG_REGULATOR_MAX77802=m
 CONFIG_REGULATOR_PALMAS=y
 CONFIG_REGULATOR_PBIAS=y
 CONFIG_REGULATOR_PWM=m
+CONFIG_REGULATOR_QCOM_RPM=y
 CONFIG_REGULATOR_S2MPS11=y
 CONFIG_REGULATOR_S5M8767=y
 CONFIG_REGULATOR_TPS51632=y
@@ -494,6 +498,7 @@ CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_MVEBU=y
 CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_MSM=y
 CONFIG_USB_EHCI_EXYNOS=y
 CONFIG_USB_EHCI_TEGRA=y
 CONFIG_USB_EHCI_HCD_STI=y
@@ -514,6 +519,7 @@ CONFIG_KEYSTONE_USB_PHY=y
 CONFIG_OMAP_USB3=y
 CONFIG_USB_GPIO_VBUS=y
 CONFIG_USB_ISP1301=y
+CONFIG_USB_MSM_OTG=y
 CONFIG_USB_MXS_PHY=y
 CONFIG_USB_RCAR_PHY=m
 CONFIG_USB_GADGET=y
@@ -605,6 +611,7 @@ CONFIG_IMX_SDMA=y
 CONFIG_IMX_DMA=y
 CONFIG_MXS_DMA=y
 CONFIG_DMA_OMAP=y
+CONFIG_QCOM_BAM_DMA=y
 CONFIG_XILINX_VDMA=y
 CONFIG_DMA_SUN6I=y
 CONFIG_STAGING=y
@@ -651,6 +658,7 @@ CONFIG_PHY_HIX5HD2_SATA=y
 CONFIG_PWM_STI=m
 CONFIG_OMAP_USB2=y
 CONFIG_TI_PIPE3=y
+CONFIG_PHY_QCOM_APQ8064_SATA=y
 CONFIG_PHY_MIPHY28LP=y
 CONFIG_PHY_MIPHY365X=y
 CONFIG_PHY_RCAR_GEN2=m
-- 
1.9.1
