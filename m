From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 21 Oct 2016 16:40:32 +0200
Subject: [RFC PATCH 07/13] ARM64: dts: meson-gxl-p23x: Add uart pinctrl
In-Reply-To: <1477060838-14164-1-git-send-email-narmstrong@baylibre.com>
References: <1477060838-14164-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1477060838-14164-8-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinctrl attribute to p23x uart node.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p23x.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p23x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p23x.dtsi
index bf08e87..666fe2b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p23x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p23x.dtsi
@@ -58,6 +58,9 @@
 	};
 };
 
+/* This UART is brought out to the DB9 connector */
 &uart_AO {
 	status = "okay";
+	pinctrl-0 = <&uart_ao_a_pins>;
+	pinctrl-names = "default";
 };
-- 
1.9.1
