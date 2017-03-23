From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 23 Mar 2017 17:27:26 +0100
Subject: [RFT PATCH 3/6] ARM: dts: meson8: Add gpio-ranges properties
In-Reply-To: <1490286449-19448-1-git-send-email-narmstrong@baylibre.com>
References: <1490286449-19448-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1490286449-19448-4-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/boot/dts/meson8.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index 45619f6..ebc763e 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -106,6 +106,7 @@
 			reg-names = "mux", "pull", "pull-enable", "gpio";
 			gpio-controller;
 			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_cbus 0 0 120>;
 		};
 
 		spi_nor_pins: nor {
@@ -148,6 +149,7 @@
 			reg-names = "mux", "pull", "gpio";
 			gpio-controller;
 			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_aobus 0 120 16>;
 		};
 
 		uart_ao_a_pins: uart_ao_a {
-- 
1.9.1
