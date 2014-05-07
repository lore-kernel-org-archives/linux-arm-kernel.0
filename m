From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 08 May 2014 08:32:29 +0900
Subject: [PATCH 01/04] ARM: shmobile: Add r8a7740 Maximum CPU Frequency to DTS
In-Reply-To: <20140507233219.29712.9253.sendpatchset@w520>
References: <20140507233219.29712.9253.sendpatchset@w520>
Message-ID: <20140507233229.29712.29821.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Add 800 MHz to the r8a7740 DTS to describe the maximum CPU frequency.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/boot/dts/r8a7740.dtsi |    1 +
 1 file changed, 1 insertion(+)

--- 0001/arch/arm/boot/dts/r8a7740.dtsi
+++ work/arch/arm/boot/dts/r8a7740.dtsi	2014-04-24 17:50:40.000000000 +0900
@@ -22,6 +22,7 @@
 			compatible = "arm,cortex-a9";
 			device_type = "cpu";
 			reg = <0x0>;
+			clock-frequency = <800000000>;
 		};
 	};
 
