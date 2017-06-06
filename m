From: biju.das@bp.renesas.com (Biju Das)
Date: Tue,  6 Jun 2017 16:10:18 +0100
Subject: [PATCH v2 5/5] ARM: dts: iwg20d-q7: Add support for iWave G20D-Q7
 board based on RZ/G1M
In-Reply-To: <1496761818-62126-1-git-send-email-biju.das@bp.renesas.com>
References: <1496420523-23506-4-git-send-email-biju.das@bp.renesas.com>
 <1496761818-62126-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1496761818-62126-6-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for iWave RainboW-G20D-Qseven board based on RZ/G1M.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
---
 arch/arm/boot/dts/r8a7743-iwg20d-q7.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7743-iwg20d-q7.dts

diff --git a/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts b/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
new file mode 100644
index 0000000..9b54783
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
@@ -0,0 +1,25 @@
+/*
+ * Device Tree Source for the iWave-RZG1M Qseven carrier board
+ *
+ * Copyright (C) 2017 Renesas Electronics Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+#include "r8a7743-iwg20m.dtsi"
+
+/ {
+	model = "iWave Systems RainboW-G20D-Qseven board based on RZ/G1M";
+	compatible = "iwave,g20d", "iwave,g20m", "renesas,r8a7743";
+
+	aliases {
+		serial0 = &scif0;
+	};
+};
+
+&scif0 {
+	status = "okay";
+};
-- 
1.9.1
