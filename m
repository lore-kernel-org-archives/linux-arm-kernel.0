From: marex@denx.de (Marek Vasut)
Date: Mon, 18 Nov 2013 15:30:43 +0100
Subject: [PATCH V2 5/5] ARM: dts: imx53: Enable AHCI SATA for M53EVK
In-Reply-To: <1384785043-5027-1-git-send-email-marex@denx.de>
References: <1384785043-5027-1-git-send-email-marex@denx.de>
Message-ID: <1384785043-5027-5-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Richard Zhu <r65037@freescale.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Linux-IDE <linux-ide@vger.kernel.org>
---
 arch/arm/boot/dts/imx53-m53evk.dts | 4 ++++
 1 file changed, 4 insertions(+)

V2: Reference sata like other devices.

diff --git a/arch/arm/boot/dts/imx53-m53evk.dts b/arch/arm/boot/dts/imx53-m53evk.dts
index 7a006cb..c623774 100644
--- a/arch/arm/boot/dts/imx53-m53evk.dts
+++ b/arch/arm/boot/dts/imx53-m53evk.dts
@@ -315,6 +315,10 @@
 	status = "okay";
 };
 
+&sata {
+	status = "okay";
+};
+
 &ssi2 {
 	fsl,mode = "i2s-slave";
 	status = "okay";
-- 
1.8.4.2
