From: stefan@agner.ch (Stefan Agner)
Date: Fri, 29 Jan 2016 16:04:48 -0800
Subject: [PATCH] ARM: dts: vf610: Add alias for ethernet controller
Message-ID: <1454112288-7490-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add alias for FEC ethernet on Vybrid to allow bootloaders (like U-Boot)
patch-in the MAC address using this alias.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/vfxxx.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index eb42172..f23eb82 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -16,6 +16,8 @@
 	aliases {
 		can0 = &can0;
 		can1 = &can1;
+		ethernet0 = &fec0;
+		ethernet1 = &fec1;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
-- 
2.7.0
