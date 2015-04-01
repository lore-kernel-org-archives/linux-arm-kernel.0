From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Wed, 1 Apr 2015 17:17:36 +0530
Subject: [RESEND PATCH 6/8] dts/ls2085a: Update Simulator DTS to add support
 of various peripherals
In-Reply-To: <1427888858-29636-1-git-send-email-bhupesh.sharma@freescale.com>
References: <1427888858-29636-1-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <1427888858-29636-7-git-send-email-bhupesh.sharma@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the LS2085a simulator DTS to add support of various
peripherals which are supported on the simulator platform and explicitly
disables those which are yet not supported on the platform.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls2085a-simu.dts |   40 ++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2085a-simu.dts b/arch/arm64/boot/dts/freescale/fsl-ls2085a-simu.dts
index 82e2a6f..8cd4a4d 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2085a-simu.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2085a-simu.dts
@@ -63,3 +63,43 @@
 		interrupts = <0 58 0x1>;
 	};
 };
+
+&esdhc {
+	status = "disabled";
+};
+
+&ifc {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "disabled";
+};
+
+&i2c1 {
+	status = "disabled";
+};
+
+&i2c2 {
+	status = "disabled";
+};
+
+&i2c3 {
+	status = "disabled";
+};
+
+&dspi {
+	status = "disabled";
+};
+
+&qspi {
+	status = "disabled";
+};
+
+&usb0 {
+	status = "disabled";
+};
+
+&usb1 {
+	status = "disabled";
+};
-- 
1.7.9.5
