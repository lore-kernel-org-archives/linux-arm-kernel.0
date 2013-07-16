From: b32955@freescale.com (Huang Shijie)
Date: Tue, 16 Jul 2013 14:55:32 +0800
Subject: [PATCH v2 3/3] ARM: dts: imx28-evk: add the RTS/CTS property for
 auart0
In-Reply-To: <1373957732-16638-1-git-send-email-b32955@freescale.com>
References: <1373957732-16638-1-git-send-email-b32955@freescale.com>
Message-ID: <1373957732-16638-4-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
1.7.1
