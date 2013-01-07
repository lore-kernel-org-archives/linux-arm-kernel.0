From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Mon, 07 Jan 2013 06:19:45 -0500
Subject: [PATCH] ARM: dts: correct the dw-mshc timing properties as per binding
Message-ID: <1357557585-30257-1-git-send-email-alim.akhtar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As per the current exynos-dw-mshc bindings, dw-mshc-sdr-timing and
dw-mshc-ddr-timing properties are having only two cells, these properties
are wrongly set for exynos5250 based cros5250 and smdk5250 platfroms. This patch
corrects above timing propreties for above platfroms

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 arch/arm/boot/dts/cros5250-common.dtsi    | 12 ++++++------
 arch/arm/boot/dts/exynos5250-smdk5250.dts |  8 ++++----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/cros5250-common.dtsi b/arch/arm/boot/dts/cros5250-common.dtsi
index fddd174..46c0980 100644
--- a/arch/arm/boot/dts/cros5250-common.dtsi
+++ b/arch/arm/boot/dts/cros5250-common.dtsi
@@ -96,8 +96,8 @@
 		fifo-depth = <0x80>;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
-		samsung,dw-mshc-sdr-timing = <2 3 3>;
-		samsung,dw-mshc-ddr-timing = <1 2 3>;
+		samsung,dw-mshc-sdr-timing = <2 3>;
+		samsung,dw-mshc-ddr-timing = <1 2>;
 
 		slot at 0 {
 			reg = <0>;
@@ -120,8 +120,8 @@
 		fifo-depth = <0x80>;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
-		samsung,dw-mshc-sdr-timing = <2 3 3>;
-		samsung,dw-mshc-ddr-timing = <1 2 3>;
+		samsung,dw-mshc-sdr-timing = <2 3>;
+		samsung,dw-mshc-ddr-timing = <1 2>;
 
 		slot at 0 {
 			reg = <0>;
@@ -141,8 +141,8 @@
 		fifo-depth = <0x80>;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
-		samsung,dw-mshc-sdr-timing = <2 3 3>;
-		samsung,dw-mshc-ddr-timing = <1 2 3>;
+		samsung,dw-mshc-sdr-timing = <2 3>;
+		samsung,dw-mshc-ddr-timing = <1 2>;
 
 		slot at 0 {
 			reg = <0>;
diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index 942d576..e05b18f 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -115,8 +115,8 @@
 		fifo-depth = <0x80>;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
-		samsung,dw-mshc-sdr-timing = <2 3 3>;
-		samsung,dw-mshc-ddr-timing = <1 2 3>;
+		samsung,dw-mshc-sdr-timing = <2 3>;
+		samsung,dw-mshc-ddr-timing = <1 2>;
 
 		slot at 0 {
 			reg = <0>;
@@ -139,8 +139,8 @@
 		fifo-depth = <0x80>;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
-		samsung,dw-mshc-sdr-timing = <2 3 3>;
-		samsung,dw-mshc-ddr-timing = <1 2 3>;
+		samsung,dw-mshc-sdr-timing = <2 3>;
+		samsung,dw-mshc-ddr-timing = <1 2>;
 
 		slot at 0 {
 			reg = <0>;
-- 
1.8.0
