From: Jonathan.Cameron@huawei.com (Jonathan Cameron)
Date: Wed, 12 Sep 2018 17:07:18 +0100
Subject: [PATCH 2/2] arm64: dts: hisilicon hip07: drop commas from @address
 node names
In-Reply-To: <20180912160718.3324-2-Jonathan.Cameron@huawei.com>
References: <20180912160718.3324-2-Jonathan.Cameron@huawei.com>
Message-ID: <20180912160718.3324-3-Jonathan.Cameron@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reported-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Fixes: e4a1f7858ab8 ("arm64: dts: hisi: add SEC crypto accelerator nodes for hip07 SoC")
---
 arch/arm64/boot/dts/hisilicon/hip07.dtsi | 28 ++++++++++++------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hip07.dtsi b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
index c33adefc3061..bc0113445655 100644
--- a/arch/arm64/boot/dts/hisilicon/hip07.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
@@ -949,35 +949,35 @@
 			reg = <0x0 0xc6000000 0x0 0x40000>;
 		};
 
-		p0_its_dsa_b: interrupt-controller at 8,c6000000 {
+		p0_its_dsa_b: interrupt-controller at 8c6000000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
 			#msi-cells = <1>;
 			reg = <0x8 0xc6000000 0x0 0x40000>;
 		};
 
-		p1_its_peri_a: interrupt-controller at 400,4c000000 {
+		p1_its_peri_a: interrupt-controller at 4004c000000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
 			#msi-cells = <1>;
 			reg = <0x400 0x4c000000 0x0 0x40000>;
 		};
 
-		p1_its_peri_b: interrupt-controller at 400,6c000000 {
+		p1_its_peri_b: interrupt-controller at 4006c000000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
 			#msi-cells = <1>;
 			reg = <0x400 0x6c000000 0x0 0x40000>;
 		};
 
-		p1_its_dsa_a: interrupt-controller at 400,c6000000 {
+		p1_its_dsa_a: interrupt-controller at 400c6000000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
 			#msi-cells = <1>;
 			reg = <0x400 0xc6000000 0x0 0x40000>;
 		};
 
-		p1_its_dsa_b: interrupt-controller at 408,c6000000 {
+		p1_its_dsa_b: interrupt-controller at 408c6000000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
 			#msi-cells = <1>;
@@ -1066,7 +1066,7 @@
 			num-pins = <3>;
 		};
 	};
-	p0_mbigen_alg_b:interrupt-controller at 8,d0080000 {
+	p0_mbigen_alg_b:interrupt-controller at 8d0080000 {
 		compatible = "hisilicon,mbigen-v2";
 		reg = <0x8 0xd0080000 0x0 0x10000>;
 
@@ -1083,7 +1083,7 @@
 			num-pins = <3>;
 		};
 	};
-	p1_mbigen_alg_a:interrupt-controller at 400,d0080000 {
+	p1_mbigen_alg_a:interrupt-controller at 400d0080000 {
 		compatible = "hisilicon,mbigen-v2";
 		reg = <0x400 0xd0080000 0x0 0x10000>;
 
@@ -1100,7 +1100,7 @@
 			num-pins = <3>;
 		};
 	};
-	p1_mbigen_alg_b:interrupt-controller at 408,d0080000 {
+	p1_mbigen_alg_b:interrupt-controller at 408d0080000 {
 		compatible = "hisilicon,mbigen-v2";
 		reg = <0x408 0xd0080000 0x0 0x10000>;
 
@@ -1187,7 +1187,7 @@
 		hisilicon,broken-prefetch-cmd;
 		/* smmu-cb-memtype = <0x0 0x1>;*/
 	};
-	p0_smmu_alg_b: smmu_alg at 8,d0040000 {
+	p0_smmu_alg_b: smmu_alg at 8d0040000 {
 		compatible = "arm,smmu-v3";
 		reg = <0x8 0xd0040000 0x0 0x20000>;
 		interrupt-parent = <&p0_mbigen_smmu_alg_b>;
@@ -1200,7 +1200,7 @@
 		hisilicon,broken-prefetch-cmd;
 		/* smmu-cb-memtype = <0x0 0x1>;*/
 	};
-	p1_smmu_alg_a: smmu_alg at 400,d0040000 {
+	p1_smmu_alg_a: smmu_alg at 400d0040000 {
 		compatible = "arm,smmu-v3";
 		reg = <0x400 0xd0040000 0x0 0x20000>;
 		interrupt-parent = <&p1_mbigen_smmu_alg_a>;
@@ -1213,7 +1213,7 @@
 		hisilicon,broken-prefetch-cmd;
 		/* smmu-cb-memtype = <0x0 0x1>;*/
 	};
-	p1_smmu_alg_b: smmu_alg at 408,d0040000 {
+	p1_smmu_alg_b: smmu_alg at 408d0040000 {
 		compatible = "arm,smmu-v3";
 		reg = <0x408 0xd0040000 0x0 0x20000>;
 		interrupt-parent = <&p1_mbigen_smmu_alg_b>;
@@ -1763,7 +1763,7 @@
 				     <605 1>, <606 4>,
 				     <607 1>, <608 4>;
 		};
-		p0_sec_b: crypto at 8,d2000000 {
+		p0_sec_b: crypto at 8d2000000 {
 			compatible = "hisilicon,hip07-sec";
 			reg = <0x8 0xd0000000 0x0 0x10000
 			       0x8 0xd2000000 0x0 0x10000
@@ -1804,7 +1804,7 @@
 				     <605 1>, <606 4>,
 				     <607 1>, <608 4>;
 		};
-		p1_sec_a: crypto at 400,d2000000 {
+		p1_sec_a: crypto at 400d2000000 {
 			compatible = "hisilicon,hip07-sec";
 			reg = <0x400 0xd0000000 0x0 0x10000
 			       0x400 0xd2000000 0x0 0x10000
@@ -1845,7 +1845,7 @@
 				     <605 1>, <606 4>,
 				     <607 1>, <608 4>;
 		};
-		p1_sec_b: crypto at 408,d2000000 {
+		p1_sec_b: crypto at 408d2000000 {
 			compatible = "hisilicon,hip07-sec";
 			reg = <0x408 0xd0000000 0x0 0x10000
 			       0x408 0xd2000000 0x0 0x10000
-- 
2.18.0
