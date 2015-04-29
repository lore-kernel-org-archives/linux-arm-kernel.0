From: hramrach@gmail.com (Michal Suchanek)
Date: Wed, 29 Apr 2015 09:41:17 +0200
Subject: [PATCH 4/4] ARM: dts: sunxi: Add SPI aliases on A10s Olinuxino.
In-Reply-To: <cover.1430295711.git.hramrach@gmail.com>
References: <cover.1430295711.git.hramrach@gmail.com>
Message-ID: <b37eb9810d805ec1ac6e1e3f9d860c081ed87966.1430295711.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SPI aliases give nicer spidev device node names.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
index cd8d08a..a49fc6a 100644
--- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
@@ -63,6 +63,9 @@
 		serial0 = &uart0;
 		serial1 = &uart2;
 		serial2 = &uart3;
+		spi0 = &spi0;
+		spi1 = &spi1;
+		spi2 = &spi2;
 	};
 
 	leds {
-- 
2.1.4
