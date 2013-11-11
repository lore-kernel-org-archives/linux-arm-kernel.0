From: gwenhael.goavec-merou@armadeus.com (Gwenhael Goavec-Merou)
Date: Mon, 11 Nov 2013 18:56:49 +0100
Subject: [PATCH] ARM: imx27-apf27dev: Add sdhci support
Message-ID: <1384192609-97029-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
---
 arch/arm/boot/dts/imx27-apf27dev.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-apf27dev.dts b/arch/arm/boot/dts/imx27-apf27dev.dts
index 47c8c26..7d90877 100644
--- a/arch/arm/boot/dts/imx27-apf27dev.dts
+++ b/arch/arm/boot/dts/imx27-apf27dev.dts
@@ -89,3 +89,9 @@
 &i2c2 {
 	status = "okay";
 };
+
+&sdhci2 {
+	bus-width = <4>;
+	cd-gpios = <&gpio3 14 0>;
+	status = "okay";
+};
-- 
1.8.3.2
