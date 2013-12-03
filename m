From: robertcnelson@gmail.com (Robert Nelson)
Date: Tue,  3 Dec 2013 08:39:38 -0600
Subject: [PATCH] ARM: dts: imx53: Enable AHCI SATA for imx53-qsb
Message-ID: <1386081578-3651-1-git-send-email-robertcnelson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Richard Zhu <r65037@freescale.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Linux-IDE <linux-ide@vger.kernel.org>
---
 arch/arm/boot/dts/imx53-qsb.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx53-qsb.dts b/arch/arm/boot/dts/imx53-qsb.dts
index 91a5935..ea927be 100644
--- a/arch/arm/boot/dts/imx53-qsb.dts
+++ b/arch/arm/boot/dts/imx53-qsb.dts
@@ -307,6 +307,10 @@
 	status = "okay";
 };
 
+&sata {
+	status = "okay";
+};
+
 &vpu {
 	status = "okay";
 };
-- 
1.8.4.3
