From: vigneshr@ti.com (Vignesh R)
Date: Wed, 13 Apr 2016 16:22:03 +0530
Subject: [PATCH] ARM: dts: keystone: Add aliases for SPI nodes
Message-ID: <1460544723-32647-1-git-send-email-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add aliases for SPI nodes, this is required to probe the SPI devices in
U-Boot.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm/boot/dts/keystone.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index 3f272826f537..94d4e45138ce 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -20,6 +20,9 @@
 
 	aliases {
 		serial0	= &uart0;
+		spi0 = &spi0;
+		spi1 = &spi1;
+		spi2 = &spi2;
 	};
 
 	memory {
-- 
2.8.1
