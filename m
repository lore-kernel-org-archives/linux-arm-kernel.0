From: mike.rapoport@gmail.com (Mike Rapoport)
Date: Fri, 26 Sep 2014 11:07:31 +0300
Subject: [PATCH 2/2] ARM: DT: apq8064: add CM-QS600 board
In-Reply-To: <1411718851-17436-1-git-send-email-mike.rapoport@gmail.com>
References: <1411718851-17436-1-git-send-email-mike.rapoport@gmail.com>
Message-ID: <1411718851-17436-3-git-send-email-mike.rapoport@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mike Rapoport <mike.rapoport@gmail.com>
---
 arch/arm/boot/dts/Makefile                  | 1 +
 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts | 7 +++++++
 2 files changed, 8 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index aaa1a68..71d2ade 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -340,6 +340,7 @@ dtb-$(CONFIG_ARCH_ORION5X) += orion5x-lacie-d2-network.dtb \
 dtb-$(CONFIG_ARCH_PRIMA2) += prima2-evb.dtb
 dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-apq8064-ifc6410.dtb \
+	qcom-apq8064-cm-qs600.dtb \
 	qcom-apq8074-dragonboard.dtb \
 	qcom-apq8084-ifc6540.dtb \
 	qcom-apq8084-mtp.dtb \
diff --git a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
new file mode 100644
index 0000000..ec577e1
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
@@ -0,0 +1,7 @@
+#include "qcom-apq8064-board-common.dtsi"
+
+/ {
+	model = "CompuLab CM-QS600";
+	compatible = "qcom,apq8064-cm-qs600", "qcom,apq8064";
+
+};
-- 
1.9.1
