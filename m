From: hramrach@gmail.com (Michal Suchanek)
Date: 26 May 2016 19:25:24 -0000
Subject: [PATCH 3/3] ARM: dts: sun5i: Add spi2 alias on A10s Olinuxino
In-Reply-To: <908ed06eb46f2162e222258aa14df545d0fa5b48.1464129859.git.hramrach@gmail.com>
References: <908ed06eb46f2162e222258aa14df545d0fa5b48.1464129859.git.hramrach@gmail.com>
Message-ID: <df27dbe5931dcb7d8f404759ad42e25b15bcf780.1464129859.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

spi2 is available on the UEXT connector

The bus is named spi2 in the A10s manual and Olinuxino manual so it is
pointless to alias it to something else like spi0.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
index 7d2ff60..9729c37 100644
--- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
@@ -58,6 +58,7 @@
 		serial0 = &uart0;
 		serial1 = &uart2;
 		serial2 = &uart3;
+		spi2 = &spi2;
 	};
 
 	chosen {
-- 
2.8.1
