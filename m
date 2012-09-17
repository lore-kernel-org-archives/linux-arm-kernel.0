From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 17 Sep 2012 17:26:58 +0200
Subject: [PATCH 01/16] ARM: at91: fix missing #interrupt-cells on
 gpio-controller
In-Reply-To: <20120917140423.GA17667@game.jcrosoft.org>
References: <20120917140423.GA17667@game.jcrosoft.org>
Message-ID: <1347895633-1763-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tested-by: Bo Shen <voice.shen@atmel.com>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/boot/dts/at91sam9260.dtsi |    3 +++
 arch/arm/boot/dts/at91sam9263.dtsi |    5 +++++
 arch/arm/boot/dts/at91sam9g45.dtsi |    5 +++++
 arch/arm/boot/dts/at91sam9n12.dtsi |    4 ++++
 arch/arm/boot/dts/at91sam9x5.dtsi  |    4 ++++
 5 files changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 66389c1..7c95f76 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -104,6 +104,7 @@
 				#gpio-cells = <2>;
 				gpio-controller;
 				interrupt-controller;
+				#interrupt-cells = <2>;
 			};
 
 			pioB: gpio at fffff600 {
@@ -113,6 +114,7 @@
 				#gpio-cells = <2>;
 				gpio-controller;
 				interrupt-controller;
+				#interrupt-cells = <2>;
 			};
 
 			pioC: gpio at fffff800 {
@@ -122,6 +124,7 @@
 				#gpio-cells = <2>;
 				gpio-controller;
 				interrupt-controller;
+				#interrupt-cells = <2>;
 			};
 
 			dbgu: serial at fffff200 {
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index b460d6c..195019b 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -95,6 +95,7 @@
 				#gpio-cells = <2>;
 				gpio-controller;
 				interrupt-controller;
+				#interrupt-cells = <2>;
 			};
 
 			pioB: gpio at fffff400 {
@@ -104,6 +105,7 @@
 				#gpio-cells = <2>;
 				gpio-controller;
 				interrupt-controller;
+				#interrupt-cells = <2>;
 			};
 
 			pioC: gpio at fffff600 {
@@ -113,6 +115,7 @@
 				#gpio-cells = <2>;
 				gpio-controller;
 				interrupt-controller;
+				#interrupt-cells = <2>;
 			};
 
 			pioD: gpio at fffff800 {
@@ -122,6 +125,7 @@
 				#gpio-cells = <2>;
 				gpio-controller;
 				interrupt-controller;
+				#interrupt-cells = <2>;
 			};
 
 			pioE: gpio at fffffa00 {
@@ -131,6 +135,7 @@
 				#gpio-cells = <2>;
 				gpio-controller;
 				interrupt-controller;
+				#interrupt-cells = <2>;
 			};
 
 			dbgu: serial at ffffee00 {
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index bafa880..63751b1 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -113,6 +113,7 @@
 				#gpio-cells = <2>;
 				gpio-controller;
 				interrupt-controller;
+				#interrupt-cells = <2>;
 			};
 
 			pioB: gpio at fffff400 {
@@ -122,6 +123,7 @@
 				#gpio-cells = <2>;
 				gpio-controller;
 				interrupt-controller;
+				#interrupt-cells = <2>;
 			};
 
 			pioC: gpio at fffff600 {
@@ -131,6 +133,7 @@
 				#gpio-cells = <2>;
 				gpio-controller;
 				interrupt-controller;
+				#interrupt-cells = <2>;
 			};
 
 			pioD: gpio at fffff800 {
@@ -140,6 +143,7 @@
 				#gpio-cells = <2>;
 				gpio-controller;
 				interrupt-controller;
+				#interrupt-cells = <2>;
 			};
 
 			pioE: gpio at fffffa00 {
@@ -149,6 +153,7 @@
 				#gpio-cells = <2>;
 				gpio-controller;
 				interrupt-controller;
+				#interrupt-cells = <2>;
 			};
 
 			dbgu: serial at ffffee00 {
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index bfac0df..ef9336a 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -107,6 +107,7 @@
 				#gpio-cells = <2>;
 				gpio-controller;
 				interrupt-controller;
+				#interrupt-cells = <2>;
 			};
 
 			pioB: gpio at fffff600 {
@@ -116,6 +117,7 @@
 				#gpio-cells = <2>;
 				gpio-controller;
 				interrupt-controller;
+				#interrupt-cells = <2>;
 			};
 
 			pioC: gpio at fffff800 {
@@ -125,6 +127,7 @@
 				#gpio-cells = <2>;
 				gpio-controller;
 				interrupt-controller;
+				#interrupt-cells = <2>;
 			};
 
 			pioD: gpio at fffffa00 {
@@ -134,6 +137,7 @@
 				#gpio-cells = <2>;
 				gpio-controller;
 				interrupt-controller;
+				#interrupt-cells = <2>;
 			};
 
 			dbgu: serial at fffff200 {
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 4a18c39..8a387a8 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -115,6 +115,7 @@
 				#gpio-cells = <2>;
 				gpio-controller;
 				interrupt-controller;
+				#interrupt-cells = <2>;
 			};
 
 			pioB: gpio at fffff600 {
@@ -124,6 +125,7 @@
 				#gpio-cells = <2>;
 				gpio-controller;
 				interrupt-controller;
+				#interrupt-cells = <2>;
 			};
 
 			pioC: gpio at fffff800 {
@@ -133,6 +135,7 @@
 				#gpio-cells = <2>;
 				gpio-controller;
 				interrupt-controller;
+				#interrupt-cells = <2>;
 			};
 
 			pioD: gpio at fffffa00 {
@@ -142,6 +145,7 @@
 				#gpio-cells = <2>;
 				gpio-controller;
 				interrupt-controller;
+				#interrupt-cells = <2>;
 			};
 
 			dbgu: serial at fffff200 {
-- 
1.7.10.4
