From: mylene.josserand@free-electrons.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Thu,  2 Feb 2017 10:24:22 +0100
Subject: [PATCH v4 8/8] ARM: dts: sun8i: sinlinx: Enable audio nodes
In-Reply-To: <20170202092422.5588-1-mylene.josserand@free-electrons.com>
References: <20170202092422.5588-1-mylene.josserand@free-electrons.com>
Message-ID: <20170202092422.5588-9-mylene.josserand@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the audio codec and the audio dai for the sun8i A33 sinlinx board.

Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
index 71bb9418c5f9..53a3bb23b35c 100644
--- a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
+++ b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
@@ -63,6 +63,14 @@
 	};
 };
 
+&codec {
+	status = "okay";
+};
+
+&dai {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -207,6 +215,10 @@
 	regulator-name = "vcc-rtc";
 };
 
+&sound {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_b>;
-- 
2.11.0
