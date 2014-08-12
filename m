From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 12 Aug 2014 18:44:28 +0200
Subject: [PATCH 6/6] ARM: dts: Add tps65090 FETs constraints
In-Reply-To: <1407861868-20097-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1407861868-20097-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1407861868-20097-7-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The tps65090 PMU data manual [0] has a table that list the
"Recommended operating conditions" for each regulator. Add
the information about the FET constraints to its dtsi file.

[0]: http://www.ti.com/lit/ds/symlink/tps65090.pdf

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/boot/dts/tps65090.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/tps65090.dtsi b/arch/arm/boot/dts/tps65090.dtsi
index a2ff534..60c56da 100644
--- a/arch/arm/boot/dts/tps65090.dtsi
+++ b/arch/arm/boot/dts/tps65090.dtsi
@@ -24,30 +24,48 @@
 		};
 
 		tps65090_fet1: fet1 {
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <17000000>;
 		};
 
 		tps65090_fet2: fet2 {
+			regulator-min-microvolt = <4500000>;
+			regulator-max-microvolt = <5500000>;
 		};
 
 		tps65090_fet3: fet3 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <5500000>;
 		};
 
 		tps65090_fet4: fet4 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <5500000>;
 		};
 
 		tps65090_fet5: fet5 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <5500000>;
 		};
 
 		tps65090_fet6: fet6 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <5500000>;
 		};
 
 		tps65090_fet7: fet7 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <5500000>;
 		};
 
 		tps65090_ldo1: ldo1 {
+			regulator-min-microvolt = <6000000>;
+			regulator-max-microvolt = <17000000>;
 		};
 
 		tps65090_ldo2: ldo2 {
+			regulator-min-microvolt = <6000000>;
+			regulator-max-microvolt = <17000000>;
 		};
 	};
 
-- 
2.0.0.rc2
