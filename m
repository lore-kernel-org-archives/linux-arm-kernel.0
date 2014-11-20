From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 20 Nov 2014 21:04:54 +0800
Subject: [PATCH] ARM: dts: prima2: add node for Performance Monitor Unit
Message-ID: <1416488694-3387-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ye He <ye.he@csr.com>

It enables Performance Monitor Unit on CSR SiRFprimaII.

Signed-off-by: Ye He <ye.he@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/prima2.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
index 963b7e5..86dcb46 100644
--- a/arch/arm/boot/dts/prima2.dtsi
+++ b/arch/arm/boot/dts/prima2.dtsi
@@ -41,6 +41,11 @@
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
2.1.1
