From: marex@denx.de (Marek Vasut)
Date: Wed, 20 Nov 2013 11:17:39 +0100
Subject: [PATCH 6/6] ARM: dts: imx53: Enable AHCI SATA for M53EVK
In-Reply-To: <1384942659-5362-1-git-send-email-marex@denx.de>
References: <1384942659-5362-1-git-send-email-marex@denx.de>
Message-ID: <1384942659-5362-6-git-send-email-marex@denx.de>
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
