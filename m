From: broonie@kernel.org (Mark Brown)
Date: Sun, 31 Aug 2014 13:03:10 +0100
Subject: [PATCH] ARM: configs: Remove REGULATOR_VIRTUAL_CONSUMER from
 defconfigs
Message-ID: <1409486590-23645-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The virtual consumer is a test device intended to be used while developing
regulator drivers, it should never be used in production. Remove it from
all defconfigs to avoid confusion among users.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm/configs/bcm_defconfig      | 1 -
 arch/arm/configs/ezx_defconfig      | 1 -
 arch/arm/configs/imote2_defconfig   | 1 -
 arch/arm/configs/multi_v7_defconfig | 1 -
 arch/arm/configs/pxa3xx_defconfig   | 1 -
 arch/arm/configs/sunxi_defconfig    | 1 -
 arch/arm/configs/tegra_defconfig    | 1 -
 7 files changed, 7 deletions(-)

diff --git a/arch/arm/configs/bcm_defconfig b/arch/arm/configs/bcm_defconfig
index fbebcbce1e8c..bc614f44b33d 100644
--- a/arch/arm/configs/bcm_defconfig
+++ b/arch/arm/configs/bcm_defconfig
@@ -83,7 +83,6 @@ CONFIG_I2C_CHARDEV=y
 CONFIG_MFD_BCM590XX=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
-CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
 CONFIG_REGULATOR_USERSPACE_CONSUMER=y
 CONFIG_REGULATOR_BCM590XX=y
 
diff --git a/arch/arm/configs/ezx_defconfig b/arch/arm/configs/ezx_defconfig
index d95763d5f0d8..eb440aae4283 100644
--- a/arch/arm/configs/ezx_defconfig
+++ b/arch/arm/configs/ezx_defconfig
@@ -230,7 +230,6 @@ CONFIG_POWER_SUPPLY=y
 CONFIG_EZX_PCAP=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_DEBUG=y
-CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
 CONFIG_REGULATOR_USERSPACE_CONSUMER=y
 CONFIG_REGULATOR_PCAP=y
 CONFIG_MEDIA_SUPPORT=y
diff --git a/arch/arm/configs/imote2_defconfig b/arch/arm/configs/imote2_defconfig
index fd996bb13022..182e54692664 100644
--- a/arch/arm/configs/imote2_defconfig
+++ b/arch/arm/configs/imote2_defconfig
@@ -208,7 +208,6 @@ CONFIG_POWER_SUPPLY=y
 CONFIG_PMIC_DA903X=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_DEBUG=y
-CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
 CONFIG_REGULATOR_USERSPACE_CONSUMER=y
 CONFIG_REGULATOR_DA903X=y
 CONFIG_MEDIA_SUPPORT=y
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 7cfa5fa5f7ac..05c0e7c789df 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -259,7 +259,6 @@ CONFIG_MFD_PALMAS=y
 CONFIG_MFD_TPS65090=y
 CONFIG_MFD_TPS6586X=y
 CONFIG_MFD_TPS65910=y
-CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
 CONFIG_REGULATOR_AB8500=y
 CONFIG_REGULATOR_AS3722=y
 CONFIG_REGULATOR_BCM590XX=y
diff --git a/arch/arm/configs/pxa3xx_defconfig b/arch/arm/configs/pxa3xx_defconfig
index 60e313834b3f..5f337d7ceb5b 100644
--- a/arch/arm/configs/pxa3xx_defconfig
+++ b/arch/arm/configs/pxa3xx_defconfig
@@ -77,7 +77,6 @@ CONFIG_BATTERY_DA9030=y
 CONFIG_PMIC_DA903X=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_DEBUG=y
-CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
 CONFIG_REGULATOR_DA903X=y
 CONFIG_FB=y
 CONFIG_FB_PXA=y
diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 6c037f956e36..c1a4ca4f6e6d 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -75,7 +75,6 @@ CONFIG_POWER_RESET_SUN6I=y
 CONFIG_WATCHDOG=y
 CONFIG_SUNXI_WATCHDOG=y
 CONFIG_MFD_AXP20X=y
-CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
 CONFIG_REGULATOR_GPIO=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 2b8be4850347..b448f58f621a 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -168,7 +168,6 @@ CONFIG_MFD_TPS6586X=y
 CONFIG_MFD_TPS65910=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
-CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
 CONFIG_REGULATOR_AS3722=y
 CONFIG_REGULATOR_GPIO=y
 CONFIG_REGULATOR_MAX8907=y
-- 
2.1.0
