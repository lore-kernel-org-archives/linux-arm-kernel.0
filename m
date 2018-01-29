From: sricharan@codeaurora.org (Sricharan R)
Date: Mon, 29 Jan 2018 10:41:21 +0530
Subject: [PATCH 07/15] ARM: dts: ipq4019: Add ipq4019-ap.dk04.1-c1 board file
In-Reply-To: <1517202689-14212-1-git-send-email-sricharan@codeaurora.org>
References: <1517202689-14212-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1517202689-14212-8-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 arch/arm/boot/dts/Makefile                      | 1 +
 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts | 8 ++++++++
 2 files changed, 9 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 21ed56d..1a8ab050 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -725,6 +725,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-apq8084-mtp.dtb \
 	qcom-ipq4019-ap.dk01.1-c1.dtb \
 	qcom-ipq4019-ap.dk01.1-c2.dtb \
+	qcom-ipq4019-ap.dk04.1-c1.dtb \
 	qcom-ipq8064-ap148.dtb \
 	qcom-msm8660-surf.dtb \
 	qcom-msm8960-cdp.dtb \
diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts
new file mode 100644
index 0000000..41123be
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2017, The Linux Foundation. All rights reserved.
+
+#include "qcom-ipq4019-ap.dk04.1.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. IPQ4019/AP-DK04.1-C1";
+};
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
