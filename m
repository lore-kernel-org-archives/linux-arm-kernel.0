From: srv_yingjoe.chen@mediatek.com (Joe.C)
Date: Fri, 19 Sep 2014 11:04:16 +0800
Subject: [PATCH v3 4/7] arm: mediatek: add dts for MT8135 evaluation board.
In-Reply-To: <1411095859-18737-1-git-send-email-srv_yingjoe.chen@mediatek.com>
References: <1411095859-18737-1-git-send-email-srv_yingjoe.chen@mediatek.com>
Message-ID: <1411095859-18737-5-git-send-email-srv_yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Joe.C" <yingjoe.chen@mediatek.com>

Evbp1 is a tablet evaluation board based on MT8135 SoC.

Signed-off-by: Joe.C <yingjoe.chen@mediatek.com>
---
 arch/arm/boot/dts/mt8135-evbp1.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 arch/arm/boot/dts/mt8135-evbp1.dts

diff --git a/arch/arm/boot/dts/mt8135-evbp1.dts b/arch/arm/boot/dts/mt8135-evbp1.dts
new file mode 100644
index 0000000..cba80b8
--- /dev/null
+++ b/arch/arm/boot/dts/mt8135-evbp1.dts
@@ -0,0 +1,24 @@
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
+#include "mt8135.dtsi"
+
+/ {
+	model = "mediatek,mt8135-evbp1", "mediatek,mt8135";
+
+	memory {
+		reg = <0 0x80000000 0 0x40000000>;
+	};
+};
-- 
1.8.1.1.dirty
