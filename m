From: stefan@agner.ch (Stefan Agner)
Date: Wed, 15 Jul 2015 16:50:17 +0200
Subject: [PATCH v2] ARM: dts: vf-colibri: define stdout-path property
Message-ID: <1436971817-28523-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define Vybrid's UART0, connected to the Colibri pinout UART_A, as
standard output.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
index 77e1a45..2ce6fe5 100644
--- a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
@@ -9,7 +9,7 @@
 
 / {
 	chosen {
-		bootargs = "console=ttyLP0,115200";
+		stdout-path = "serial0:115200n8";
 	};
 
 	clk16m: clk16m {
-- 
2.4.5
