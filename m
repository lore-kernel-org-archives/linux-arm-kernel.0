From: b32955@freescale.com (Huang Shijie)
Date: Fri, 16 Nov 2012 16:03:54 +0800
Subject: [PATCH v3 3/3] ARM: dts: enable dma support for auart0 in mx28
In-Reply-To: <1353053034-10944-1-git-send-email-b32955@freescale.com>
References: <1353053034-10944-1-git-send-email-b32955@freescale.com>
Message-ID: <1353053034-10944-4-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

enable the dma support for auart0 in mx28.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx28.dtsi |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 55c57ea..b4587b2 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -799,6 +799,7 @@
 				compatible = "fsl,imx28-auart", "fsl,imx23-auart";
 				reg = <0x8006a000 0x2000>;
 				interrupts = <112 70 71>;
+				fsl,auart-dma-channel = <8 9>;
 				clocks = <&clks 45>;
 				status = "disabled";
 			};
-- 
1.7.0.4
