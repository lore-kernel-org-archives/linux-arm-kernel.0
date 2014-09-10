From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 10 Sep 2014 12:19:51 +0200
Subject: [PATCH v3 7/7] ARM: exynos_defconfig: Enable MAX77802
In-Reply-To: <1410344391-5675-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1410344391-5675-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1410344391-5675-8-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vivek Gautam <gautam.vivek@samsung.com>

Enabled MAX77802 pmic for exynos systems.
One config USB_ANNOUNCE_NEW_DEVICES to display device
information on connect.
Another config for I2C_CHARDEV to see i2c device nodes.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/configs/exynos_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 676c744..fbbac06 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -68,6 +68,7 @@ CONFIG_HW_RANDOM=y
 CONFIG_TCG_TPM=y
 CONFIG_TCG_TIS_I2C_INFINEON=y
 CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MUX=y
 CONFIG_I2C_ARB_GPIO_CHALLENGE=y
 CONFIG_I2C_EXYNOS5=y
@@ -97,6 +98,7 @@ CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_GPIO=y
 CONFIG_REGULATOR_MAX8997=y
 CONFIG_REGULATOR_MAX77686=y
+CONFIG_REGULATOR_MAX77802=y
 CONFIG_REGULATOR_S2MPA01=y
 CONFIG_REGULATOR_S2MPS11=y
 CONFIG_REGULATOR_S5M8767=y
@@ -116,6 +118,7 @@ CONFIG_SND_SOC=y
 CONFIG_SND_SOC_SAMSUNG=y
 CONFIG_SND_SOC_SNOW=y
 CONFIG_USB=y
+CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_EXYNOS=y
-- 
2.1.0
