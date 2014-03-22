From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 22 Mar 2014 13:46:00 +0100
Subject: [PATCH 5/5] ARM: Kirkwood: DT: Add missing vendor prefix
In-Reply-To: <1395492360-1865-1-git-send-email-andrew@lunn.ch>
References: <1395492360-1865-1-git-send-email-andrew@lunn.ch>
Message-ID: <1395492360-1865-6-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add vendor prefixes to compatible strings where they are missing.

Both the I2C and MTD framework ignore the prefix, so adding them has
no effect on backwards compatibility.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-b3.dts              | 2 +-
 arch/arm/boot/dts/kirkwood-cloudbox.dts        | 2 +-
 arch/arm/boot/dts/kirkwood-dreamplug.dts       | 2 +-
 arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts | 2 +-
 arch/arm/boot/dts/kirkwood-ns2-common.dtsi     | 2 +-
 arch/arm/boot/dts/kirkwood-nsa310.dts          | 2 +-
 arch/arm/boot/dts/kirkwood-nsa310a.dts         | 2 +-
 arch/arm/boot/dts/kirkwood-openblocks_a6.dts   | 2 +-
 arch/arm/boot/dts/kirkwood-openblocks_a7.dts   | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-b3.dts b/arch/arm/boot/dts/kirkwood-b3.dts
index 40791053106b..6becedebaa4e 100644
--- a/arch/arm/boot/dts/kirkwood-b3.dts
+++ b/arch/arm/boot/dts/kirkwood-b3.dts
@@ -77,3 +77,3 @@
 				#size-cells = <1>;
-				compatible = "m25p16";
+				compatible = "st,m25p16";
 				reg = <0>;
diff --git a/arch/arm/boot/dts/kirkwood-cloudbox.dts b/arch/arm/boot/dts/kirkwood-cloudbox.dts
index 0e06fd3cee4d..3b62aeeaa3a2 100644
--- a/arch/arm/boot/dts/kirkwood-cloudbox.dts
+++ b/arch/arm/boot/dts/kirkwood-cloudbox.dts
@@ -48,3 +48,3 @@
 				#size-cells = <1>;
-				compatible = "mx25l4005a";
+				compatible = "mxicy,mx25l4005a";
 				reg = <0>;
diff --git a/arch/arm/boot/dts/kirkwood-dreamplug.dts b/arch/arm/boot/dts/kirkwood-dreamplug.dts
index ef3463e0ae19..28b3ee369778 100644
--- a/arch/arm/boot/dts/kirkwood-dreamplug.dts
+++ b/arch/arm/boot/dts/kirkwood-dreamplug.dts
@@ -45,3 +45,3 @@
 				#size-cells = <1>;
-				compatible = "mx25l1606e";
+				compatible = "mxicy,mx25l1606e";
 				reg = <0>;
diff --git a/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts b/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
index 2cb0dc529165..32c6fb4a1162 100644
--- a/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
+++ b/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
@@ -58,3 +58,3 @@
 				#size-cells = <1>;
-				compatible = "mx25l12805d";
+				compatible = "mxicy,mx25l12805d";
 				reg = <0>;
diff --git a/arch/arm/boot/dts/kirkwood-ns2-common.dtsi b/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
index 843eb478b3e4..e6e5ec4fe6b9 100644
--- a/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
+++ b/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
@@ -34,3 +34,3 @@
 				#size-cells = <1>;
-				compatible = "mx25l4005a";
+				compatible = "mxicy,mx25l4005a";
 				reg = <0>;
diff --git a/arch/arm/boot/dts/kirkwood-nsa310.dts b/arch/arm/boot/dts/kirkwood-nsa310.dts
index 03fa24cf3344..0a07af9d8e58 100644
--- a/arch/arm/boot/dts/kirkwood-nsa310.dts
+++ b/arch/arm/boot/dts/kirkwood-nsa310.dts
@@ -106,3 +106,3 @@
 			adt7476: adt7476a at 2e {
-				compatible = "adt7476";
+				compatible = "adi,adt7476";
 				reg = <0x2e>;
diff --git a/arch/arm/boot/dts/kirkwood-nsa310a.dts b/arch/arm/boot/dts/kirkwood-nsa310a.dts
index a5e779452867..27ca6a79c48a 100644
--- a/arch/arm/boot/dts/kirkwood-nsa310a.dts
+++ b/arch/arm/boot/dts/kirkwood-nsa310a.dts
@@ -96,3 +96,3 @@
 			lm85: lm85 at 2e {
-				compatible = "lm85";
+				compatible = "national,lm85";
 				reg = <0x2e>;
diff --git a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
index b88da9392c32..0650beafc1de 100644
--- a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
+++ b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
@@ -42,3 +42,3 @@
 			s35390a: s35390a at 30 {
-				compatible = "s35390a";
+				compatible = "sii,s35390a";
 				reg = <0x30>;
diff --git a/arch/arm/boot/dts/kirkwood-openblocks_a7.dts b/arch/arm/boot/dts/kirkwood-openblocks_a7.dts
index b2f7cae06839..38520a287514 100644
--- a/arch/arm/boot/dts/kirkwood-openblocks_a7.dts
+++ b/arch/arm/boot/dts/kirkwood-openblocks_a7.dts
@@ -54,3 +54,3 @@
 			s24c02: s24c02 at 50 {
-				compatible = "24c02";
+				compatible = "atmel,24c02";
 				reg = <0x50>;
-- 
1.9.1
