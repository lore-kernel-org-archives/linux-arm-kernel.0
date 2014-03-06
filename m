From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 06 Mar 2014 12:15:36 +0900
Subject: [PATCH] ARM: shmobile: Update r8a7791 CPU freq to 1500MHz in DTS
Message-ID: <20140306031536.10779.98781.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

The correct maximum CPU frequency for r8a7791 is 1500 MHz
so update the r8a7791 SoC DTS to reflect this.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/r8a7791.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- 0001/arch/arm/boot/dts/r8a7791.dtsi
+++ work/arch/arm/boot/dts/r8a7791.dtsi	2014-03-06 10:52:09.000000000 +0900
@@ -37,14 +37,14 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0>;
-			clock-frequency = <1300000000>;
+			clock-frequency = <1500000000>;
 		};
 
 		cpu1: cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <1>;
-			clock-frequency = <1300000000>;
+			clock-frequency = <1500000000>;
 		};
 	};
 
