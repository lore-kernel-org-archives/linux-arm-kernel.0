From: dingtianhong@huawei.com (Ding Tianhong)
Date: Thu, 19 Jan 2017 19:14:34 +0800
Subject: [PATCH v8 4/4] arm64: arch timer: Add timer erratum property for
 Hip05-d02 and Hip06-d03
In-Reply-To: <1484824474-12172-1-git-send-email-dingtianhong@huawei.com>
References: <1484824474-12172-1-git-send-email-dingtianhong@huawei.com>
Message-ID: <1484824474-12172-5-git-send-email-dingtianhong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable workaround for hisilicon erratum 161010101 on Hip05-d02 and Hip06-d03 board.

Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hip05.dtsi | 1 +
 arch/arm64/boot/dts/hisilicon/hip06.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hip05.dtsi b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
index 4b472a3..6b76f3a 100644
--- a/arch/arm64/boot/dts/hisilicon/hip05.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
@@ -281,6 +281,7 @@
 			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
 			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
 			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+		hisilicon,erratum-161010101;
 	};
 
 	pmu {
diff --git a/arch/arm64/boot/dts/hisilicon/hip06.dtsi b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
index a049b64..cf8b9db 100644
--- a/arch/arm64/boot/dts/hisilicon/hip06.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
@@ -260,6 +260,7 @@
 			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
 			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
 			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+		hisilicon,erratum-161010101;
 	};
 
 	pmu {
-- 
1.9.0
