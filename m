From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  5 Dec 2017 16:10:25 +0100
Subject: [PATCH v3 13/15] ARM: dts: sun8i: a83t: Add the PWM pin group
In-Reply-To: <cover.825a49a4c1c565a548f3de0375e7537e7e8fd3a4.1512486553.git-series.maxime.ripard@free-electrons.com>
References: <cover.825a49a4c1c565a548f3de0375e7537e7e8fd3a4.1512486553.git-series.maxime.ripard@free-electrons.com>
Message-ID: <9d640f746ff4dbc968cdd46438874685f58dc2ba.1512486553.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A83T has a PWM that can be output from the SoC. Let's add a pinctrl
group for it.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index e200df5a9058..a37517d4472a 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -446,6 +446,11 @@
 				bias-pull-up;
 			};
 
+			pwm_pin: pwm-pin {
+				pins = "PD28";
+				function = "pwm";
+			};
+
 			spdif_tx_pin: spdif-tx-pin {
 				pins = "PE18";
 				function = "spdif";
-- 
git-series 0.9.1
