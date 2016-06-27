From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 27 Jun 2016 17:02:45 +0800
Subject: [PATCH 07/10] arm64: defconfig: Enable Tegra186 SoC
In-Reply-To: <20160627090248.23621-1-josephl@nvidia.com>
References: <20160627090248.23621-1-josephl@nvidia.com>
Message-ID: <20160627090248.23621-8-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable Tegra186 SoC.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f267eea101a7..033d9cb1e983 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -312,6 +312,7 @@ CONFIG_QCOM_SMEM=y
 CONFIG_QCOM_SMD=y
 CONFIG_QCOM_SMD_RPM=y
 CONFIG_ARCH_TEGRA_132_SOC=y
+CONFIG_ARCH_TEGRA_186_SOC=y
 CONFIG_ARCH_TEGRA_210_SOC=y
 CONFIG_EXTCON_USB_GPIO=y
 CONFIG_PWM=y
-- 
2.9.0
