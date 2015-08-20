From: hramrach@gmail.com (Michal Suchanek)
Date: 20 Aug 2015 14:19:48 -0000
Subject: [PATCH 9/9] ARM: dts: sunxi: Add SPI aliases on A10s Olinuxino.
In-Reply-To: <cover.1440080122.git.hramrach@gmail.com>
References: <cover.1440080122.git.hramrach@gmail.com>
Message-ID: <de1151651088bd3acfd279785412ed9537023472.1440080122.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SPI aliases give nicer spidev device node names.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
index b546fc2..1a0e0c0 100644
--- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
@@ -58,6 +58,9 @@
 		serial0 = &uart0;
 		serial1 = &uart2;
 		serial2 = &uart3;
+		spi0 = &spi0;
+		spi1 = &spi1;
+		spi2 = &spi2;
 	};
 
 	chosen {
-- 
2.1.4
