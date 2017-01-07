From: dingtianhong@huawei.com (Ding Tianhong)
Date: Sat, 7 Jan 2017 15:07:38 +0800
Subject: [PATCH v7 4/4] arm64: arch timer: Add timer erratum property for
 Hip05-d02 and Hip06-d03
In-Reply-To: <1483772858-10380-1-git-send-email-dingtianhong@huawei.com>
References: <1483772858-10380-1-git-send-email-dingtianhong@huawei.com>
Message-ID: <1483772858-10380-5-git-send-email-dingtianhong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable workaround for hisilicon erratum 161601 on Hip05-d02 and Hip06-d03 board.

Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hip05.dtsi | 1 +
 arch/arm64/boot/dts/hisilicon/hip06.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hip05.dtsi b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
index 4b472a3..a8e9969 100644
--- a/arch/arm64/boot/dts/hisilicon/hip05.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
@@ -281,6 +281,7 @@
 			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
 			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
 			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+		hisilicon,erratum-161601;
 	};
 
 	pmu {
diff --git a/arch/arm64/boot/dts/hisilicon/hip06.dtsi b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
index a049b64..344e0f0 100644
--- a/arch/arm64/boot/dts/hisilicon/hip06.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
@@ -260,6 +260,7 @@
 			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
 			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
 			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+		hisilicon,erratum-161601;
 	};
 
 	pmu {
-- 
1.9.0
