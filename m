From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 23 May 2016 15:42:21 +0800
Subject: [PATCH] arm64: tegra: Fix CPU compatible string for Tegra132
Message-ID: <20160523074221.7135-1-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As per commit f634da375fc96 ("Documentation: DT bindings: add nvidia,
tegra132-denver compatible string"), fixing the CPU compatible string for
Tegra132 to match the binding document currently.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra132.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra132.dtsi b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
index 2013f8916084..7b1cdc029de3 100644
--- a/arch/arm64/boot/dts/nvidia/tegra132.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
@@ -964,13 +964,13 @@
 
 		cpu at 0 {
 			device_type = "cpu";
-			compatible = "nvidia,denver", "arm,armv8";
+			compatible = "nvidia,tegra132-denver", "arm,armv8";
 			reg = <0>;
 		};
 
 		cpu at 1 {
 			device_type = "cpu";
-			compatible = "nvidia,denver", "arm,armv8";
+			compatible = "nvidia,tegra132-denver", "arm,armv8";
 			reg = <1>;
 		};
 	};
-- 
2.8.3
