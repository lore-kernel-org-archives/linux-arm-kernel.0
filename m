From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 17 Oct 2017 11:06:27 +0200
Subject: [PATCH 20/23] arm: dts: sun8i: a83t: Add the PWM pin group
In-Reply-To: <cover.fe3d65d1ee05a55224d26e7d113388c428592b26.1508231063.git-series.maxime.ripard@free-electrons.com>
References: <cover.fe3d65d1ee05a55224d26e7d113388c428592b26.1508231063.git-series.maxime.ripard@free-electrons.com>
Message-ID: <6347546cd95cce11268effb14ed03f5e9ac382e5.1508231063.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A83T has a PWM that can be output from the SoC. Let's add a pinctrl
group for it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 6f1221556587..1986e8341e33 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -445,6 +445,11 @@
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
