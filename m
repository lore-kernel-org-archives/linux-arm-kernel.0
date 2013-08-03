From: shijie8@gmail.com (Huang Shijie)
Date: Sat,  3 Aug 2013 10:09:16 -0400
Subject: [PATCH v3 3/3] ARM: dts: imx28-evk: add the RTS/CTS property for
 auart0
In-Reply-To: <1375538956-15862-1-git-send-email-shijie8@gmail.com>
References: <1375538956-15862-1-git-send-email-shijie8@gmail.com>
Message-ID: <1375538956-15862-4-git-send-email-shijie8@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Huang Shijie <b32955@freescale.com>

Add the RTS/CTS property for auart0 which means we enable the
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
1.7.4.4
