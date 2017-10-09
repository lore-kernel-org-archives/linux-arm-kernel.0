From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon,  9 Oct 2017 22:22:54 +0200
Subject: [PATCH v2 5/5] ARM: dts: sun9i: Change node names to remove
 underscores
In-Reply-To: <cover.e7363fd7884334063590603c0b0de566f66e0c18.1507580565.git-series.maxime.ripard@free-electrons.com>
References: <cover.e7363fd7884334063590603c0b0de566f66e0c18.1507580565.git-series.maxime.ripard@free-electrons.com>
Message-ID: <4962f525ca78e8864de3c69c12ba41d08134f057.1507580565.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some boards have had node names with underscores. Remove them in favour of
hyphens in order to reduce the DTC warnings.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts | 2 +-
 arch/arm/boot/dts/sun9i-a80-optimus.dts     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
index cb337e08adab..4024639aa005 100644
--- a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
+++ b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
@@ -74,7 +74,7 @@
 		};
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: wifi-pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		clocks = <&ac100_rtc 1>;
 		clock-names = "ext_clock";
diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index ba62e814f4b8..a9b807be99a0 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -98,7 +98,7 @@
 		gpio = <&pio 7 5 GPIO_ACTIVE_HIGH>; /* PH5 */
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: wifi-pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		clocks = <&ac100_rtc 1>;
 		clock-names = "ext_clock";
-- 
git-series 0.9.1
