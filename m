From: sricharan@codeaurora.org (Sricharan R)
Date: Fri, 18 May 2018 13:49:18 +0530
Subject: [PATCH V7 05/12] ARM: dts: ipq4019: Add ipq4019-ap.dk04.1-c1 board
 file
In-Reply-To: <1526631565-9972-1-git-send-email-sricharan@codeaurora.org>
References: <1526631565-9972-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1526631565-9972-6-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>
Tested-by: Varadarajan Narayanan <varada@codeaurora.org>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 arch/arm/boot/dts/Makefile                      |  1 +
 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7e24249..4e15d0d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -760,6 +760,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-apq8084-ifc6540.dtb \
 	qcom-apq8084-mtp.dtb \
 	qcom-ipq4019-ap.dk01.1-c1.dtb \
+	qcom-ipq4019-ap.dk04.1-c1.dtb \
 	qcom-ipq8064-ap148.dtb \
 	qcom-msm8660-surf.dtb \
 	qcom-msm8960-cdp.dtb \
diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts
new file mode 100644
index 0000000..7a96f30
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018, The Linux Foundation. All rights reserved.
+
+#include "qcom-ipq4019-ap.dk04.1.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. IPQ4019/AP-DK04.1-C1";
+	compatible = "qcom,ipq4019-dk04.1-c1";
+
+	soc {
+		dma at 7984000 {
+			status = "ok";
+		};
+
+		qpic-nand at 79b0000 {
+			status = "ok";
+		};
+	};
+};
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
