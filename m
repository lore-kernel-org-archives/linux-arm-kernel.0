From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Thu,  3 Oct 2013 23:21:38 +0200
Subject: [PATCH v2 2/5] ARM: socfpga: dts: Change baudrate for socdk
In-Reply-To: <1380835301-26512-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1380835301-26512-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1380835301-26512-3-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The baudrate for the SoCDK was lower in previous development stages.
Change it to the more common 115200 baudrate.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Acked-by: Dinh Nguyen <dinguyen@altera.com>
---
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
index 0ea6399..2ee52ab 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
@@ -22,7 +22,7 @@
 	compatible = "altr,socfpga-cyclone5", "altr,socfpga";
 
 	chosen {
-		bootargs = "console=ttyS0,57600";
+		bootargs = "console=ttyS0,115200";
 	};
 
 	memory {
-- 
1.8.4.rc3
