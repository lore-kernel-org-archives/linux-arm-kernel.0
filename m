From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 24 Sep 2013 00:16:35 +0800
Subject: [PATCH 6/9] arm/dts: sirf: add missed address-cells and size-cells
 for prima2 I2C
In-Reply-To: <1379952998-16393-1-git-send-email-Baohua.Song@csr.com>
References: <1379952998-16393-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <1379952998-16393-7-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Renwei Wu <Renwei.Wu@csr.com>

here prima2 i2c node is lacking of address-cells and size-cells.

Signed-off-by: Renwei Wu <Renwei.Wu@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/prima2.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
index 244156f..1484a45 100644
--- a/arch/arm/boot/dts/prima2.dtsi
+++ b/arch/arm/boot/dts/prima2.dtsi
@@ -325,6 +325,8 @@
 				reg = <0xb00e0000 0x10000>;
 				interrupts = <24>;
 				clocks = <&clks 17>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 			};
 
 			i2c1: i2c at b00f0000 {
@@ -333,6 +335,8 @@
 				reg = <0xb00f0000 0x10000>;
 				interrupts = <25>;
 				clocks = <&clks 18>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 			};
 
 			tsc at b0110000 {
-- 
1.8.2.3
