From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon,  4 Jun 2012 12:32:35 -0600
Subject: [PATCH REPOST 2/2] ARM: dt: tegra: remove legacy support-8bit property
In-Reply-To: <1338834755-6900-1-git-send-email-swarren@wwwdotorg.org>
References: <1338834755-6900-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1338834755-6900-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

The driver supports the new bus-width property, so remove the legacy
support-8bit property.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra-cardhu.dts   |    1 -
 arch/arm/boot/dts/tegra-harmony.dts  |    1 -
 arch/arm/boot/dts/tegra-paz00.dts    |    1 -
 arch/arm/boot/dts/tegra-seaboard.dts |    1 -
 arch/arm/boot/dts/tegra-ventana.dts  |    1 -
 arch/arm/boot/dts/tegra-whistler.dts |    2 --
 6 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/tegra-cardhu.dts b/arch/arm/boot/dts/tegra-cardhu.dts
index 36321bc..c169bce 100644
--- a/arch/arm/boot/dts/tegra-cardhu.dts
+++ b/arch/arm/boot/dts/tegra-cardhu.dts
@@ -144,7 +144,6 @@
 
 	sdhci at 78000600 {
 		status = "okay";
-		support-8bit;
 		bus-width = <8>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra-harmony.dts b/arch/arm/boot/dts/tegra-harmony.dts
index 7de7013..f146dbf 100644
--- a/arch/arm/boot/dts/tegra-harmony.dts
+++ b/arch/arm/boot/dts/tegra-harmony.dts
@@ -307,7 +307,6 @@
 		cd-gpios = <&gpio 58 0>; /* gpio PH2 */
 		wp-gpios = <&gpio 59 0>; /* gpio PH3 */
 		power-gpios = <&gpio 70 0>; /* gpio PI6 */
-		support-8bit;
 		bus-width = <8>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra-paz00.dts b/arch/arm/boot/dts/tegra-paz00.dts
index bfeb117..684a9e1 100644
--- a/arch/arm/boot/dts/tegra-paz00.dts
+++ b/arch/arm/boot/dts/tegra-paz00.dts
@@ -301,7 +301,6 @@
 
 	sdhci at c8000600 {
 		status = "okay";
-		support-8bit;
 		bus-width = <8>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra-seaboard.dts b/arch/arm/boot/dts/tegra-seaboard.dts
index 89cb7f2..2fc0f05 100644
--- a/arch/arm/boot/dts/tegra-seaboard.dts
+++ b/arch/arm/boot/dts/tegra-seaboard.dts
@@ -397,7 +397,6 @@
 
 	sdhci at c8000600 {
 		status = "okay";
-		support-8bit;
 		bus-width = <8>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra-ventana.dts b/arch/arm/boot/dts/tegra-ventana.dts
index 445343b..be90544 100644
--- a/arch/arm/boot/dts/tegra-ventana.dts
+++ b/arch/arm/boot/dts/tegra-ventana.dts
@@ -314,7 +314,6 @@
 
 	sdhci at c8000600 {
 		status = "okay";
-		support-8bit;
 		bus-width = <8>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra-whistler.dts b/arch/arm/boot/dts/tegra-whistler.dts
index 2548648..6916310 100644
--- a/arch/arm/boot/dts/tegra-whistler.dts
+++ b/arch/arm/boot/dts/tegra-whistler.dts
@@ -276,13 +276,11 @@
 	sdhci at c8000400 {
 		status = "okay";
 		wp-gpios = <&gpio 173 0>; /* gpio PV5 */
-		support-8bit;
 		bus-width = <8>;
 	};
 
 	sdhci at c8000600 {
 		status = "okay";
-		support-8bit;
 		bus-width = <8>;
 	};
 
-- 
1.7.0.4
