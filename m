From: ralph.sennhauser@gmail.com (Ralph Sennhauser)
Date: Sun, 21 May 2017 14:48:53 +0200
Subject: [PATCH 04/13] ARM: dts: armada-385-linksys: drop redundant properties
 in dependants
In-Reply-To: <20170521124903.11050-1-ralph.sennhauser@gmail.com>
References: <20170521124903.11050-1-ralph.sennhauser@gmail.com>
Message-ID: <20170521124903.11050-5-ralph.sennhauser@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drop redundant declaration of #address-cells and #size-cells.

Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
---
 arch/arm/boot/dts/armada-385-linksys-caiman.dts | 3 ---
 arch/arm/boot/dts/armada-385-linksys-cobra.dts  | 3 ---
 arch/arm/boot/dts/armada-385-linksys-shelby.dts | 3 ---
 3 files changed, 9 deletions(-)

diff --git a/arch/arm/boot/dts/armada-385-linksys-caiman.dts b/arch/arm/boot/dts/armada-385-linksys-caiman.dts
index 765c939..05e854a 100644
--- a/arch/arm/boot/dts/armada-385-linksys-caiman.dts
+++ b/arch/arm/boot/dts/armada-385-linksys-caiman.dts
@@ -47,9 +47,6 @@
 };
 
 &expander0 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-
 	wan_amber at 0 {
 		label = "caiman:amber:wan";
 		reg = <0x0>;
diff --git a/arch/arm/boot/dts/armada-385-linksys-cobra.dts b/arch/arm/boot/dts/armada-385-linksys-cobra.dts
index 2ae1e71..5b1662b 100644
--- a/arch/arm/boot/dts/armada-385-linksys-cobra.dts
+++ b/arch/arm/boot/dts/armada-385-linksys-cobra.dts
@@ -47,9 +47,6 @@
 };
 
 &expander0 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-
 	wan_amber at 0 {
 		label = "cobra:amber:wan";
 		reg = <0x0>;
diff --git a/arch/arm/boot/dts/armada-385-linksys-shelby.dts b/arch/arm/boot/dts/armada-385-linksys-shelby.dts
index 74f4273..a909371 100644
--- a/arch/arm/boot/dts/armada-385-linksys-shelby.dts
+++ b/arch/arm/boot/dts/armada-385-linksys-shelby.dts
@@ -47,9 +47,6 @@
 };
 
 &expander0 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-
 	wan_amber at 0 {
 		label = "shelby:amber:wan";
 		reg = <0x0>;
-- 
2.10.2
