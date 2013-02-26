From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 26 Feb 2013 17:58:59 +0800
Subject: [PATCH 2/2] ARM: dts: tegra: fix the PMC compatible string
Message-ID: <1361872739-4467-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PMC HW does not 100% compatible across all Tegra series. We need to
specify them in DT.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/boot/dts/tegra114.dtsi | 2 +-
 arch/arm/boot/dts/tegra30.dtsi  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 1dfaf28..e4ddedd 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -99,7 +99,7 @@
 	};
 
 	pmc {
-		compatible = "nvidia,tegra114-pmc", "nvidia,tegra30-pmc";
+		compatible = "nvidia,tegra114-pmc";
 		reg = <0x7000e400 0x400>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 767803e..6ae82e7 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -422,7 +422,7 @@
 	};
 
 	pmc {
-		compatible = "nvidia,tegra20-pmc", "nvidia,tegra30-pmc";
+		compatible = "nvidia,tegra30-pmc";
 		reg = <0x7000e400 0x400>;
 	};
 
-- 
1.8.1.1
