From: gdjakov@mm-sol.com (Georgi Djakov)
Date: Tue,  2 Sep 2014 18:40:41 +0300
Subject: [PATCH v2 1/3] ARM: dts: qcom: Add initial IFC6540 board device tree
In-Reply-To: <1409672443-4289-1-git-send-email-gdjakov@mm-sol.com>
References: <1409672443-4289-1-git-send-email-gdjakov@mm-sol.com>
Message-ID: <1409672443-4289-2-git-send-email-gdjakov@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initial device tree for the IFC6540 Snapdragon 805 pico-itx
single-board computer.

Signed-off-by: Georgi Djakov <gdjakov@mm-sol.com>
---
 arch/arm/boot/dts/Makefile                 |    1 +
 arch/arm/boot/dts/qcom-apq8084-ifc6540.dts |    6 ++++++
 2 files changed, 7 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-apq8084-ifc6540.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b022972..df8453a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -345,6 +345,7 @@ dtb-$(CONFIG_ARCH_PRIMA2) += prima2-evb.dtb
 dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-apq8064-ifc6410.dtb \
 	qcom-apq8074-dragonboard.dtb \
+	qcom-apq8084-ifc6540.dtb \
 	qcom-apq8084-mtp.dtb \
 	qcom-msm8660-surf.dtb \
 	qcom-msm8960-cdp.dtb
diff --git a/arch/arm/boot/dts/qcom-apq8084-ifc6540.dts b/arch/arm/boot/dts/qcom-apq8084-ifc6540.dts
new file mode 100644
index 0000000..4603e91
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-apq8084-ifc6540.dts
@@ -0,0 +1,6 @@
+#include "qcom-apq8084.dtsi"
+
+/ {
+	model = "Qualcomm APQ8084/IFC6540";
+	compatible = "qcom,apq8084-ifc6540", "qcom,apq8084";
+};
-- 
1.7.9.5
