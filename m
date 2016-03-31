From: xuejiancheng@hisilicon.com (Jiancheng Xue)
Date: Thu, 31 Mar 2016 16:10:10 +0800
Subject: [RESEND PATCH v10 5/6] ARM: dt-bindings: add device tree bindings for
 Hi3519 sysctrl
In-Reply-To: <1459411811-12390-1-git-send-email-xuejiancheng@hisilicon.com>
References: <1459411811-12390-1-git-send-email-xuejiancheng@hisilicon.com>
Message-ID: <1459411811-12390-6-git-send-email-xuejiancheng@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jiancheng Xue <xuejiancheng@huawei.com>

Add device tree bindings for Hi3519 system controller.

Signed-off-by: Jiancheng Xue <xuejiancheng@huawei.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/hisilicon/hi3519-sysctrl.txt   | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hi3519-sysctrl.txt

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hi3519-sysctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/hi3519-sysctrl.txt
new file mode 100644
index 0000000..115c5be
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/hisilicon/hi3519-sysctrl.txt
@@ -0,0 +1,14 @@
+* Hisilicon Hi3519 System Controller Block
+
+This bindings use the following binding:
+Documentation/devicetree/bindings/mfd/syscon.txt
+
+Required properties:
+- compatible: "hisilicon,hi3519-sysctrl".
+- reg: the register region of this block
+
+Examples:
+sysctrl: system-controller at 12010000 {
+	compatible = "hisilicon,hi3519-sysctrl", "syscon";
+	reg = <0x12010000 0x1000>;
+};
-- 
1.9.1
