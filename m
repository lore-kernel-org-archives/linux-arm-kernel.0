From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Thu, 7 Apr 2016 16:23:16 +0800
Subject: [PATCH v2 1/2] dt/bindings: Add bindings for hisilicon random number
 generator
In-Reply-To: <1460017397-30996-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1460017397-30996-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1460017397-30996-2-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the devicetree bindings for the random number generator found
on Hisilicon Hip04 and Hip05 soc.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 Documentation/devicetree/bindings/rng/hisi-rng.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rng/hisi-rng.txt

diff --git a/Documentation/devicetree/bindings/rng/hisi-rng.txt b/Documentation/devicetree/bindings/rng/hisi-rng.txt
new file mode 100644
index 0000000..72efcc1
--- /dev/null
+++ b/Documentation/devicetree/bindings/rng/hisi-rng.txt
@@ -0,0 +1,12 @@
+Hisilicon Random Number Generator
+
+Required properties:
+- compatible : Should be "hisilicon,rng"
+- reg : Offset and length of the register set of this block
+
+Example:
+
+rng at d1010000 {
+	compatible = "hisilicon,rng";
+	reg = <0xd1010000 0x100>;
+};
-- 
2.6.0.GIT
