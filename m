From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 13 May 2014 17:44:41 +0800
Subject: [PATCH v2 6/6] document: add dt binding on hix5hd2 SoC
In-Reply-To: <1399974281-9737-1-git-send-email-haojian.zhuang@linaro.org>
References: <1399974281-9737-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1399974281-9737-7-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the DT binding of basic SoC on Hisilicon HiX5HD2 SoC.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
index 5024992..4b06c1e 100644
--- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
+++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
@@ -7,6 +7,9 @@ Required root node properties:
 HiP04 D01 Board
 Required root node properties:
 	- compatible = "hisilicon,hip04-d01";
+HiX5HD2 DKB Board
+Required root node properties:
+	- compatible = "hisilicon,hix5hd2";
 
 
 Hisilicon system controller
@@ -65,3 +68,9 @@ Fabric:
 Required Properties:
 - compatible: "hisilicon,hip04-fabric";
 - reg: Address and size of Fabric
+
+Cpu power controller:
+
+Required Properties:
+- compatible: "hisilicon,cpuctrl";
+- reg: Address and size of cpu power controller.
-- 
1.9.1
