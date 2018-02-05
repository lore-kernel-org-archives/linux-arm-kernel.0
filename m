From: festevam@gmail.com (Fabio Estevam)
Date: Mon,  5 Feb 2018 16:45:38 -0200
Subject: [PATCH 7/7] arm64: ls208xa-qds: Fix the 'reg' property
In-Reply-To: <1517856338-28289-1-git-send-email-festevam@gmail.com>
References: <1517856338-28289-1-git-send-email-festevam@gmail.com>
Message-ID: <1517856338-28289-7-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

The 'reg' property should match the corresponding @ address, so
fix it accordingly.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
index a1a5ccb..1de6188 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
@@ -177,7 +177,7 @@
 		#size-cells = <1>;
 		compatible = "st,m25p80";
 		spi-max-frequency = <20000000>;
-		reg = <0>;
+		reg = <2>;
 	};
 };
 
-- 
2.7.4
