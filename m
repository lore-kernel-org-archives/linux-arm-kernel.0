From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Thu, 28 Feb 2013 15:19:25 +0800
Subject: [PATCH 6/7] Document: dts: create hisilicon document
In-Reply-To: <1362035966-17628-1-git-send-email-haojian.zhuang@linaro.org>
References: <1362035966-17628-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1362035966-17628-6-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Append the illustration on two boards from hisilicon.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 Documentation/devicetree/bindings/arm/hs/hisilicon.txt |   10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/hs/hisilicon.txt

diff --git a/Documentation/devicetree/bindings/arm/hs/hisilicon.txt b/Documentation/devicetree/bindings/arm/hs/hisilicon.txt
new file mode 100644
index 0000000..3be60c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/hs/hisilicon.txt
@@ -0,0 +1,10 @@
+Hisilicon Platforms Device Tree Bindings
+----------------------------------------------------
+
+Hi3716 Development Board
+Required root node properties:
+	- compatible = "hisilicon,hi3716-dkb";
+
+Hi4511 Board
+Required root node properties:
+	- compatible = "hisilicon,hi3620-hi4511";
-- 
1.7.10.4
