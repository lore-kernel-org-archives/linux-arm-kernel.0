From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Thu, 26 Jun 2014 12:05:47 +0800
Subject: [PATCH v4 8/8] document: add dt binding on hix5hd2 SoC
In-Reply-To: <1403755547-623-1-git-send-email-haojian.zhuang@linaro.org>
References: <1403755547-623-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1403755547-623-9-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the DT binding of basic SoC on Hisilicon HiX5HD2 SoC.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
index df0a452..b0ea477 100644
--- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
+++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
@@ -4,6 +4,9 @@ Hisilicon Platforms Device Tree Bindings
 Hi4511 Board
 Required root node properties:
 	- compatible = "hisilicon,hi3620-hi4511";
+HIX5HD2 DKB Board
+Required root node properties:
+	- compatible = "hisilicon,hix5hd2";
 
 Hisilicon system controller
 
@@ -44,3 +47,9 @@ Example:
 		compatible = "hisilicon,pctrl";
 		reg = <0xfca09000 0x1000>;
 	};
+
+Cpu power controller:
+
+Required Properties:
+- compatible: "hisilicon,cpuctrl";
+- reg: Address and size of cpu power controller.
-- 
1.9.1
