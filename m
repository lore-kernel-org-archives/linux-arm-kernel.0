From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 20 Jun 2012 13:56:48 +0100
Subject: [PATCH 12/15] ARM: ux500: Ensure vendor specific properties have the
 vendor's identifier
In-Reply-To: <1340197011-5435-1-git-send-email-lee.jones@linaro.org>
References: <1340197011-5435-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1340197011-5435-13-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Any non-standard property should contain the vendor's identifier which
should be perpended onto the property name followed by a comma. This
aids in name-space collision prevention.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/db8500.dtsi |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/db8500.dtsi b/arch/arm/boot/dts/db8500.dtsi
index d89b88d..7279165 100644
--- a/arch/arm/boot/dts/db8500.dtsi
+++ b/arch/arm/boot/dts/db8500.dtsi
@@ -60,7 +60,7 @@
 			interrupts = <0 119 0x4>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
-			supports-sleepmode;
+			st,supports-sleepmode;
 			gpio-controller;
 			#gpio-cells = <2>;
 			gpio-bank = <0>;
@@ -73,7 +73,7 @@
 			interrupts = <0 120 0x4>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
-			supports-sleepmode;
+			st,supports-sleepmode;
 			gpio-controller;
 			#gpio-cells = <2>;
 			gpio-bank = <1>;
@@ -86,7 +86,7 @@
 			interrupts = <0 121 0x4>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
-			supports-sleepmode;
+			st,supports-sleepmode;
 			gpio-controller;
 			#gpio-cells = <2>;
 			gpio-bank = <2>;
@@ -99,7 +99,7 @@
 			interrupts = <0 122 0x4>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
-			supports-sleepmode;
+			st,supports-sleepmode;
 			gpio-controller;
 			#gpio-cells = <2>;
 			gpio-bank = <3>;
@@ -112,7 +112,7 @@
 			interrupts = <0 123 0x4>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
-			supports-sleepmode;
+			st,supports-sleepmode;
 			gpio-controller;
 			#gpio-cells = <2>;
 			gpio-bank = <4>;
@@ -125,7 +125,7 @@
 			interrupts = <0 124 0x4>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
-			supports-sleepmode;
+			st,supports-sleepmode;
 			gpio-controller;
 			#gpio-cells = <2>;
 			gpio-bank = <5>;
@@ -138,7 +138,7 @@
 			interrupts = <0 125 0x4>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
-			supports-sleepmode;
+			st,supports-sleepmode;
 			gpio-controller;
 			#gpio-cells = <2>;
 			gpio-bank = <6>;
@@ -151,7 +151,7 @@
 			interrupts = <0 126 0x4>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
-			supports-sleepmode;
+			st,supports-sleepmode;
 			gpio-controller;
 			#gpio-cells = <2>;
 			gpio-bank = <7>;
@@ -164,7 +164,7 @@
 			interrupts = <0 127 0x4>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
-			supports-sleepmode;
+			st,supports-sleepmode;
 			gpio-controller;
 			#gpio-cells = <2>;
 			gpio-bank = <8>;
-- 
1.7.9.5
