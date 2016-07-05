From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 5 Jul 2016 17:04:31 +0800
Subject: [PATCH V2 10/10] arm64: dts: tegra: Add NVIDIA P2771 board support
In-Reply-To: <20160705090431.5852-1-josephl@nvidia.com>
References: <20160705090431.5852-1-josephl@nvidia.com>
Message-ID: <20160705090431.5852-11-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add NVIDIA Tegra186 P2771 board support, which is a reference
development board with P2597 I/O board and P3310 chip module on it.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
Changes in V2:
- None
---
 arch/arm64/boot/dts/nvidia/Makefile                | 1 +
 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts | 8 ++++++++
 2 files changed, 9 insertions(+)
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts

diff --git a/arch/arm64/boot/dts/nvidia/Makefile b/arch/arm64/boot/dts/nvidia/Makefile
index 0f7cdf3e05c1..67234f3dc795 100644
--- a/arch/arm64/boot/dts/nvidia/Makefile
+++ b/arch/arm64/boot/dts/nvidia/Makefile
@@ -1,4 +1,5 @@
 dtb-$(CONFIG_ARCH_TEGRA_132_SOC) += tegra132-norrin.dtb
+dtb-$(CONFIG_ARCH_TEGRA_186_SOC) += tegra186-p2771-0000.dtb
 dtb-$(CONFIG_ARCH_TEGRA_210_SOC) += tegra210-p2371-0000.dtb
 dtb-$(CONFIG_ARCH_TEGRA_210_SOC) += tegra210-p2371-2180.dtb
 dtb-$(CONFIG_ARCH_TEGRA_210_SOC) += tegra210-p2571.dtb
diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
new file mode 100644
index 000000000000..66b936389fa7
--- /dev/null
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
@@ -0,0 +1,8 @@
+/dts-v1/;
+
+#include "tegra186-p3310.dtsi"
+
+/ {
+	model = "NVIDIA Tegra186 P2771-0000 Board";
+	compatible = "nvidia,p2771-0000", "nvidia,tegra186";
+};
-- 
2.9.0
