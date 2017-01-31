From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 31 Jan 2017 12:19:56 +0000
Subject: [PATCH 7/7] arm64: arch timer: Add timer erratum property for
 Hip05-d02 and Hip06-d03
In-Reply-To: <1485865196-12742-1-git-send-email-mark.rutland@arm.com>
References: <1485865196-12742-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1485865196-12742-8-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ding Tianhong <dingtianhong@huawei.com>

Enable workaround for hisilicon erratum 161010101 on Hip05-d02 and
Hip06-d03 board.

Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
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
1.9.1
