From: eric.nelson@boundarydevices.com (Eric Nelson)
Date: Tue,  2 Dec 2014 15:36:37 -0700
Subject: [PATCH 2/3 RESEND] ARM: dts: sabrelite: add hdmi
In-Reply-To: <1417559798-17290-1-git-send-email-eric.nelson@boundarydevices.com>
References: <1417559798-17290-1-git-send-email-eric.nelson@boundarydevices.com>
Message-ID: <1417559798-17290-3-git-send-email-eric.nelson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Nelson <eric.nelson@boundarydevices.com>
---
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index 37f53f3..3bddc8f 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -173,6 +173,11 @@
 	status = "okay";
 };
 
+&hdmi {
+	ddc-i2c-bus = <&i2c2>;
+	status = "okay";
+};
+
 &i2c1 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
-- 
1.9.1
