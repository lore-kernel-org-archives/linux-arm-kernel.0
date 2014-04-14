From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 14 Apr 2014 17:37:32 +0200
Subject: [PATCH 10/10] ARM: dts: pbab01: Enable DVI
In-Reply-To: <1397489852-1669-1-git-send-email-p.zabel@pengutronix.de>
References: <1397489852-1669-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1397489852-1669-10-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi
index 323a647..5847212 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi
@@ -23,6 +23,10 @@
 	status = "okay";
 };
 
+&hdmi {
+	status = "okay";
+};
+
 &i2c2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c2>;
-- 
1.9.1
