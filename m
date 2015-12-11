From: xuejiancheng@huawei.com (Jiancheng Xue)
Date: Fri, 11 Dec 2015 15:45:20 +0800
Subject: [PATCH v3 6/7] mfd: dt-bindings: add device tree bindings for Hi3519
 sysctrl
In-Reply-To: <1449819921-18464-1-git-send-email-xuejiancheng@huawei.com>
References: <1449819921-18464-1-git-send-email-xuejiancheng@huawei.com>
Message-ID: <1449819921-18464-7-git-send-email-xuejiancheng@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree bindings for Hi3519 system controller.

Signed-off-by: Jiancheng Xue <xuejiancheng@huawei.com>
---
 Documentation/devicetree/bindings/mfd/hi3519.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/hi3519.txt

diff --git a/Documentation/devicetree/bindings/mfd/hi3519.txt b/Documentation/devicetree/bindings/mfd/hi3519.txt
new file mode 100644
index 0000000..4b1c294
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/hi3519.txt
@@ -0,0 +1,14 @@
+* Hisilicon Hi3519 System Controller Block
+
+This bindings use the following binding:
+Dcumentation/devicetree/bindings/clock/clock-bindings.txt
+
+Required properties:
+- compatible: "hislicon,hi3519-sysctrl".
+- reg: the register region of this block
+
+Examples:
+sysctrl: system-controller at 12010000 {
+	compatible = "hisilicon,hi3519-sysctrl", "syscon";
+	reg = <0x12010000 0x1000>;
+};
-- 
1.9.1
