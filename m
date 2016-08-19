From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 19 Aug 2016 19:32:28 +0200
Subject: [PATCH v3 07/12] arm64: defconfig: Enable Tegra186 SoC
In-Reply-To: <20160819173233.13260-1-thierry.reding@gmail.com>
References: <20160819173233.13260-1-thierry.reding@gmail.com>
Message-ID: <20160819173233.13260-8-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joseph Lo <josephl@nvidia.com>

Enable Tegra186 SoC.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 76bfaa7eee57..ba67b4e67608 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -375,6 +375,7 @@ CONFIG_QCOM_SMEM=y
 CONFIG_QCOM_SMD=y
 CONFIG_QCOM_SMD_RPM=y
 CONFIG_ARCH_TEGRA_132_SOC=y
+CONFIG_ARCH_TEGRA_186_SOC=y
 CONFIG_ARCH_TEGRA_210_SOC=y
 CONFIG_EXTCON_USB_GPIO=y
 CONFIG_PWM=y
-- 
2.9.0
