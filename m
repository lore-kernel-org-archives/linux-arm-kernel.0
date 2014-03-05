From: 21cnbao@gmail.com (Barry Song)
Date: Wed,  5 Mar 2014 11:35:35 +0800
Subject: [PATCH 2/2] ARM: dts: atlas6: add cortex-a9-pmu compatible PMU node
In-Reply-To: <1393990536-9306-1-git-send-email-21cnbao@gmail.com>
References: <1393990536-9306-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1393990536-9306-2-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ye He <Ye.He@csr.com>

add cortex-a9-pmu node to make the performance monitor unit work on atlas6.

Signed-off-by: Ye He <Ye.He@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas6.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
index 14495c4..82fcf66 100644
--- a/arch/arm/boot/dts/atlas6.dtsi
+++ b/arch/arm/boot/dts/atlas6.dtsi
@@ -39,6 +39,11 @@
 		};
 	};
 
+	arm-pmu {
+		compatible = "arm,cortex-a9-pmu";
+		interrupts = <29>;
+	};
+
 	axi {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
1.7.9.5
