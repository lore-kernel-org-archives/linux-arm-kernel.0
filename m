From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 23 Mar 2017 17:27:24 +0100
Subject: [RFT PATCH 1/6] ARM64: dts: meson-gxbb: Add gpio-ranges properties
In-Reply-To: <1490286449-19448-1-git-send-email-narmstrong@baylibre.com>
References: <1490286449-19448-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1490286449-19448-2-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 04b3324..84c590b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -129,6 +129,7 @@
 			reg-names = "mux", "pull", "gpio";
 			gpio-controller;
 			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_aobus 0 0 14>;
 		};
 
 		uart_ao_a_pins: uart_ao_a {
@@ -245,6 +246,7 @@
 			reg-names = "mux", "pull", "pull-enable", "gpio";
 			gpio-controller;
 			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_periphs 0 14 120>;
 		};
 
 		emmc_pins: emmc {
-- 
1.9.1
