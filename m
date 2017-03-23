From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 23 Mar 2017 17:27:27 +0100
Subject: [RFT PATCH 4/6] ARM: dts: meson8b: Add gpio-ranges properties
In-Reply-To: <1490286449-19448-1-git-send-email-narmstrong@baylibre.com>
References: <1490286449-19448-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1490286449-19448-5-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 41fd536..828aa49 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -198,6 +198,7 @@
 				reg-names = "mux", "pull", "pull-enable", "gpio";
 				gpio-controller;
 				#gpio-cells = <2>;
+				gpio-ranges = <&pinctrl_cbus 0 0 130>;
 			};
 		};
 
@@ -215,6 +216,7 @@
 				reg-names = "mux", "pull", "gpio";
 				gpio-controller;
 				#gpio-cells = <2>;
+				gpio-ranges = <&pinctrl_aobus 0 130 16>;
 			};
 
 			uart_ao_a_pins: uart_ao_a {
-- 
1.9.1
