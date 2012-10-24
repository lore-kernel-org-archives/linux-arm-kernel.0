From: b32955@freescale.com (Huang Shijie)
Date: Wed, 24 Oct 2012 18:27:36 +0800
Subject: [PATCH v2 3/3] ARM: dts: enable dma support for auart0 in mx28
In-Reply-To: <1351074456-25863-1-git-send-email-b32955@freescale.com>
References: <1351074456-25863-1-git-send-email-b32955@freescale.com>
Message-ID: <1351074456-25863-4-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

enable the dma support for auart0 in mx28.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx28.dtsi |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index e16d631..73d1a9f 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -798,6 +798,7 @@
 				compatible = "fsl,imx28-auart", "fsl,imx23-auart";
 				reg = <0x8006a000 0x2000>;
 				interrupts = <112 70 71>;
+				fsl,auart-dma-channel = <8 9>;
 				clocks = <&clks 45>;
 				status = "disabled";
 			};
-- 
1.7.0.4
