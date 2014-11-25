From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Tue, 25 Nov 2014 15:37:26 +0800
Subject: [PATCH v1] ARM: multi_v7_defconfig: add driver support for hix5hd2
Message-ID: <1416901046-21091-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tested on hix5hd2 platform with mmc, usb, network, reboot etc.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index a72780a2afd2..930bfcbcd68e 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -10,6 +10,7 @@ CONFIG_PERF_EVENTS=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_PARTITION_ADVANCED=y
+CONFIG_CMDLINE_PARTITION=y
 CONFIG_ARCH_VIRT=y
 CONFIG_ARCH_MVEBU=y
 CONFIG_MACH_ARMADA_370=y
@@ -153,6 +154,7 @@ CONFIG_AHCI_TEGRA=y
 CONFIG_SATA_HIGHBANK=y
 CONFIG_SATA_MV=y
 CONFIG_NETDEVICES=y
+CONFIG_HIX5HD2_GMAC=y
 CONFIG_SUN4I_EMAC=y
 CONFIG_MACB=y
 CONFIG_NET_CALXEDA_XGMAC=y
@@ -289,6 +291,8 @@ CONFIG_REGULATOR_AB8500=y
 CONFIG_REGULATOR_AS3722=y
 CONFIG_REGULATOR_BCM590XX=y
 CONFIG_REGULATOR_GPIO=y
+CONFIG_MFD_SYSCON=y
+CONFIG_POWER_RESET_SYSCON=y
 CONFIG_REGULATOR_MAX8907=y
 CONFIG_REGULATOR_PALMAS=y
 CONFIG_REGULATOR_S2MPS11=y
@@ -369,6 +373,8 @@ CONFIG_MMC_OMAP_HS=y
 CONFIG_MMC_MVSDIO=y
 CONFIG_MMC_SUNXI=y
 CONFIG_MMC_DW=y
+CONFIG_MMC_DW_IDMAC=y
+CONFIG_MMC_DW_PLTFM=y
 CONFIG_MMC_DW_EXYNOS=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_NEW_LEDS=y
@@ -440,6 +446,7 @@ CONFIG_AK8975=y
 CONFIG_PWM=y
 CONFIG_PWM_TEGRA=y
 CONFIG_PWM_VT8500=y
+CONFIG_PHY_HIX5HD2_SATA=y
 CONFIG_OMAP_USB2=y
 CONFIG_TI_PIPE3=y
 CONFIG_PHY_MIPHY365X=y
-- 
1.7.9.5
