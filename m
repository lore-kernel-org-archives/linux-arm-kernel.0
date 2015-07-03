From: stefan@agner.ch (Stefan Agner)
Date: Fri,  3 Jul 2015 10:06:39 +0200
Subject: [PATCH] ARM: dts: vf-colibri: define stdout-path property
Message-ID: <1435910799-11706-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define Vybrid's UART0, connected to the Colibri pinout UART_A, as
standard output.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
index 2cbe663..cb199ae 100644
--- a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
@@ -10,6 +10,7 @@
 / {
 	chosen {
 		bootargs = "console=ttyLP0,115200";
+		stdout-path = "serial0:115200n8";
 	};
 
 	clk16m: clk16m {
-- 
2.4.4
