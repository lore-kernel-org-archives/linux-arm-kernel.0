From: dingtianhong@huawei.com (Ding Tianhong)
Date: Sun, 23 Oct 2016 11:21:18 +0800
Subject: [PATCH 3/3] arm64: arch timer: Add timer erratum property for
 Hip05-d02 and Hip06-d03
Message-ID: <bf391642-82f7-2a3e-3118-1a8384a133e5@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hip05.dtsi | 1 +
 arch/arm64/boot/dts/hisilicon/hip06.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hip05.dtsi b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
index bf322ed..9d18875 100644
--- a/arch/arm64/boot/dts/hisilicon/hip05.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
@@ -281,6 +281,7 @@
 			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
 			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
 			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+		hisilicon,erratum-161x01;
 	};

 	pmu {
diff --git a/arch/arm64/boot/dts/hisilicon/hip06.dtsi b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
index 5927bc4..c38c658 100644
--- a/arch/arm64/boot/dts/hisilicon/hip06.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
@@ -260,6 +260,7 @@
 			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
 			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
 			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+		hisilicon,erratum-161x01;
 	};

 	pmu {
-- 
1.9.0
