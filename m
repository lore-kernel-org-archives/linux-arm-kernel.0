From: nm@ti.com (Nishanth Menon)
Date: Mon, 27 Aug 2018 19:46:50 -0500
Subject: [PATCH] arm64: defconfig: Enable TI's AM6 SoC platform
Message-ID: <20180828004650.2184-1-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable K3 SoC platform for TI's AM6 SoC.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Ref: https://www.spinics.net/lists/arm-kernel/msg667805.html

Unfortunately, Kconfig changes did'nt hit v4.19-rc1 window.
So, as promised, patch based off v4.19-rc1 tag.

 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f67e8d5e93ad..db8d364f8476 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -38,6 +38,7 @@ CONFIG_ARCH_BCM_IPROC=y
 CONFIG_ARCH_BERLIN=y
 CONFIG_ARCH_BRCMSTB=y
 CONFIG_ARCH_EXYNOS=y
+CONFIG_ARCH_K3=y
 CONFIG_ARCH_LAYERSCAPE=y
 CONFIG_ARCH_LG1K=y
 CONFIG_ARCH_HISI=y
@@ -605,6 +606,8 @@ CONFIG_ARCH_TEGRA_132_SOC=y
 CONFIG_ARCH_TEGRA_210_SOC=y
 CONFIG_ARCH_TEGRA_186_SOC=y
 CONFIG_ARCH_TEGRA_194_SOC=y
+CONFIG_ARCH_K3_AM6_SOC=y
+CONFIG_SOC_TI=y
 CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
 CONFIG_EXTCON_USB_GPIO=y
 CONFIG_EXTCON_USBC_CROS_EC=y
-- 
2.15.1
