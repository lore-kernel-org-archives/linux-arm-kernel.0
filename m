From: marex@denx.de (Marek Vasut)
Date: Sun, 17 Nov 2013 23:56:22 +0100
Subject: [PATCH 5/5] ARM: dts: imx53: Enable AHCI SATA for M53EVK
In-Reply-To: <1384728982-19834-1-git-send-email-marex@denx.de>
References: <1384728982-19834-1-git-send-email-marex@denx.de>
Message-ID: <1384728982-19834-5-git-send-email-marex@denx.de>
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
index 658d32a..c45a8d9c 100644
--- a/arch/arm/boot/dts/imx53-m53evk.dts
+++ b/arch/arm/boot/dts/imx53-m53evk.dts
@@ -44,6 +44,10 @@
 				};
 			};
 		};
+
+		sata at 10000000 {
+			status = "okay";
+		};
 	};
 
 	backlight {
-- 
1.8.4.2
