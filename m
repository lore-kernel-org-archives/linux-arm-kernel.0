From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon,  4 Aug 2014 10:58:03 +0800
Subject: [PATCH v16 4/9] document: dt: add the binding on HiP04
In-Reply-To: <1407121088-4151-1-git-send-email-haojian.zhuang@linaro.org>
References: <1407121088-4151-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1407121088-4151-5-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Hisilicon HiP04 SoC platform & Fabric controller.

Fabric controller could be used to configure snoop filter among multiple
clusters.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 .../devicetree/bindings/arm/hisilicon/hisilicon.txt          | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
index 934f000..fd8a759 100644
--- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
+++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
@@ -5,6 +5,11 @@ Hi4511 Board
 Required root node properties:
 	- compatible = "hisilicon,hi3620-hi4511";
 
+HiP04 D01 Board
+Required root node properties:
+	- compatible = "hisilicon,hip04-d01";
+
+
 Hisilicon system controller
 
 Required properties:
@@ -55,3 +60,10 @@ Example:
 		compatible = "hisilicon,pctrl";
 		reg = <0xfca09000 0x1000>;
 	};
+
+-----------------------------------------------------------------------
+Fabric:
+
+Required Properties:
+- compatible: "hisilicon,hip04-fabric";
+- reg: Address and size of Fabric
-- 
1.9.1
