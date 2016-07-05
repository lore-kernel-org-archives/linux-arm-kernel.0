From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 5 Jul 2016 17:04:28 +0800
Subject: [PATCH V2 07/10] arm64: defconfig: Enable Tegra186 SoC
In-Reply-To: <20160705090431.5852-1-josephl@nvidia.com>
References: <20160705090431.5852-1-josephl@nvidia.com>
Message-ID: <20160705090431.5852-8-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable Tegra186 SoC.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
Changes in V2:
- None
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e69051098435..64d767ec142c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -326,6 +326,7 @@ CONFIG_QCOM_SMEM=y
 CONFIG_QCOM_SMD=y
 CONFIG_QCOM_SMD_RPM=y
 CONFIG_ARCH_TEGRA_132_SOC=y
+CONFIG_ARCH_TEGRA_186_SOC=y
 CONFIG_ARCH_TEGRA_210_SOC=y
 CONFIG_EXTCON_USB_GPIO=y
 CONFIG_PWM=y
-- 
2.9.0
