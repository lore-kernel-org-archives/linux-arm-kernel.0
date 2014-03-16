From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 16 Mar 2014 18:09:20 -0300
Subject: [PATCH RESEND] ARM: dts: imx25-pdk: Add USB Host1 support
Message-ID: <1395004160-22732-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx25-pdk.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx25-pdk.dts b/arch/arm/boot/dts/imx25-pdk.dts
index ebaf48d..c608942 100644
--- a/arch/arm/boot/dts/imx25-pdk.dts
+++ b/arch/arm/boot/dts/imx25-pdk.dts
@@ -243,3 +243,9 @@
 	fsl,uart-has-rtscts;
 	status = "okay";
 };
+
+&usbhost1 {
+	phy_type = "serial";
+	dr_mode = "host";
+	status = "okay";
+};
-- 
1.8.1.2
