From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Tue, 4 Nov 2014 15:30:49 +0800
Subject: [PATCH v5 2/8] ARM: mediatek: add dts for 8127 Moose board
In-Reply-To: <1415086255-5555-1-git-send-email-yingjoe.chen@mediatek.com>
References: <1415086255-5555-1-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <1415086255-5555-3-git-send-email-yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Joe.C" <yingjoe.chen@mediatek.com>

Moose is a tablet evalutation board based on MT8127 SoC.

Signed-off-by: Joe.C <yingjoe.chen@mediatek.com>
---
 arch/arm/boot/dts/mt8127-moose.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 arch/arm/boot/dts/mt8127-moose.dts

diff --git a/arch/arm/boot/dts/mt8127-moose.dts b/arch/arm/boot/dts/mt8127-moose.dts
new file mode 100644
index 0000000..c9c3a5c
--- /dev/null
+++ b/arch/arm/boot/dts/mt8127-moose.dts
@@ -0,0 +1,25 @@
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ * Author: Joe.C <yingjoe.chen@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+/dts-v1/;
+#include "mt8127.dtsi"
+
+/ {
+	model = "MediaTek MT8127 Moose Board";
+	compatible = "mediatek,mt8127-moose", "mediatek,mt8127";
+
+	memory {
+		reg = <0x80000000 0x40000000>;
+	};
+};
-- 
1.8.1.1.dirty
