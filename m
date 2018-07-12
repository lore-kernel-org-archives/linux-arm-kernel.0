From: luaraneda@gmail.com (Luis Araneda)
Date: Thu, 12 Jul 2018 01:50:46 -0400
Subject: [PATCH 1/3] arm: dts: zynq: Fix memory size on the Zybo Z7 board
In-Reply-To: <20180712055049.5098-1-luaraneda@gmail.com>
References: <20180712055049.5098-1-luaraneda@gmail.com>
Message-ID: <20180712055049.5098-2-luaraneda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the reference manual, the board has two Micron
MT41K256M16HA-125 DDR3L memory ICs, which have 512 MiB each

Tested on a ZYBO-Z7-20 board

Signed-off-by: Luis Araneda <luaraneda@gmail.com>
---
 arch/arm/boot/dts/zynq-zybo-z7.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/zynq-zybo-z7.dts b/arch/arm/boot/dts/zynq-zybo-z7.dts
index 1e713dc98920..bc81ebee50fe 100644
--- a/arch/arm/boot/dts/zynq-zybo-z7.dts
+++ b/arch/arm/boot/dts/zynq-zybo-z7.dts
@@ -13,7 +13,7 @@
 
 	memory at 0 {
 		device_type = "memory";
-		reg = <0x0 0x20000000>;
+		reg = <0x0 0x40000000>;
 	};
 
 	chosen {
-- 
2.18.0
