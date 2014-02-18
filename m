From: ashutosh.s@phytec.in (Ashutosh singh)
Date: Tue, 18 Feb 2014 19:16:25 +0530
Subject: [PATCH v2 4/4] Phytec phyFLEX-i.MX6 : Added SATA Support
In-Reply-To: <1392731185-4885-1-git-send-email-ashutosh.s@phytec.in>
References: <1392731185-4885-1-git-send-email-ashutosh.s@phytec.in>
Message-ID: <1392731185-4885-4-git-send-email-ashutosh.s@phytec.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for SATA on Phytec phyFLEX-i.MX6 Quad module.

Signed-off-by: Ashutosh singh <ashutosh.s@phytec.in>
---
 arch/arm/boot/dts/imx6q-phytec-pbab01.dts |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-phytec-pbab01.dts b/arch/arm/boot/dts/imx6q-phytec-pbab01.dts
index 21c8b37..5607c33 100644
--- a/arch/arm/boot/dts/imx6q-phytec-pbab01.dts
+++ b/arch/arm/boot/dts/imx6q-phytec-pbab01.dts
@@ -25,6 +25,10 @@
 	status = "okay";
 };
 
+&sata {
+	status = "okay";
+};
+
 &uart4 {
 	status = "okay";
 };
-- 
1.7.9.5
