From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 25 Jul 2014 12:49:52 +0200
Subject: [PATCH 2/3] ARM: dts: nitrogen6x: add hdmi
In-Reply-To: <1406285393-23545-1-git-send-email-l.stach@pengutronix.de>
References: <1406285393-23545-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1406285393-23545-2-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michael Olbrich <m.olbrich@pengutronix.de>

Signed-off-by: Michael Olbrich <m.olbrich@pengutronix.de>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
index 3362d2600d85..4e27cf9f3d2e 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
@@ -174,6 +174,12 @@
 	status = "okay";
 };
 
+&hdmi {
+	ddc-i2c-bus = <&i2c2>;
+	hpd-unreliable;
+	status = "okay";
+};
+
 &i2c1 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
-- 
2.0.1
