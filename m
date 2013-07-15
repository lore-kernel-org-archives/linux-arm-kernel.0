From: b32955@freescale.com (Huang Shijie)
Date: Mon, 15 Jul 2013 11:08:56 +0800
Subject: [PATCH 3/3] ARM: dts: imx28-evk: add the rts/cts property for auart0
In-Reply-To: <1373857736-30108-1-git-send-email-b32955@freescale.com>
References: <1373857736-30108-1-git-send-email-b32955@freescale.com>
Message-ID: <1373857736-30108-3-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the rts/cts property for auart0 which means we enable the
DMA support for it.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx28-evk.dts |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index e035f46..15715d9 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -220,6 +220,7 @@
 			auart0: serial at 8006a000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&auart0_pins_a>;
+				fsl,uart-has-rtscts;
 				status = "okay";
 			};
 
-- 
1.7.1
