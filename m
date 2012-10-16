From: simon.guinot@sequanux.org (Simon Guinot)
Date: Tue, 16 Oct 2012 22:22:04 +0200
Subject: [PATCH] ARM: mach-kirkwood: add documentation for device tree bindings
In-Reply-To: <507C6AE4.1020406@gmail.com>
References: <507C6AE4.1020406@gmail.com>
Message-ID: <1350418924-6253-1-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
---
 Documentation/devicetree/bindings/arm/kirkwood.txt |   37 ++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/kirkwood.txt

diff --git a/Documentation/devicetree/bindings/arm/kirkwood.txt b/Documentation/devicetree/bindings/arm/kirkwood.txt
new file mode 100644
index 0000000..14fb6b9
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/kirkwood.txt
@@ -0,0 +1,37 @@
+Marvell Kirkwood Platforms Device Tree Bindings
+-----------------------------------------------
+
+Boards with a SoC of the Marvell Kirkwood family shall have the
+following property:
+Required root node property:
+compatible: must contain "marvell,kirkwood"
+
+In addition, boards with a Kirkwood SoC 88F6192 shall have the
+following property:
+Required root node property:
+compatible: must contain "marvell,kirkwood-88f6192"
+
+In addition, boards with a Kirkwood SoC 88F6281 shall have the
+following property:
+Required root node property:
+compatible: must contain "marvell,kirkwood-88f6281"
+
+In addition, boards with a Kirkwood SoC 88F6702 shall have the
+following property:
+Required root node property:
+compatible: must contain "marvell,kirkwood-88f6702"
+
+Board with a SoC of the Marvell Armada 300 family (Kirkwood compatible)
+shall have the following property:
+Required root node property:
+compatible: must contain "marvell,armada300", "marvell,kirkwood"
+
+In addition, boards with an Armada 300 SoC 88F6282 shall have the
+following property:
+Required root node property:
+compatible: must contain "marvell,armada300-88f6282"
+
+In addition, boards with an Armada 300 SoC 88F6283 shall have the
+following property:
+Required root node property:
+compatible: must contain "marvell,armada300-88f6283"
-- 
1.7.10
