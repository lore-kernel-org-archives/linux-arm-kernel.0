From: clabbe.montjoie@gmail.com (LABBE Corentin)
Date: Sat, 12 Jul 2014 14:59:12 +0200
Subject: [PATCH v4 2/3] ARM: sunxi: dt: Add DT bindings documentation for
 SUNXI Security System
In-Reply-To: <1405169953-13695-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1405169953-13695-1-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <1405169953-13695-3-git-send-email-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds documentation for Device-Tree bindings for the Security
System cryptographic accelerator driver.

Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 Documentation/devicetree/bindings/crypto/sunxi-ss.txt | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/sunxi-ss.txt

diff --git a/Documentation/devicetree/bindings/crypto/sunxi-ss.txt b/Documentation/devicetree/bindings/crypto/sunxi-ss.txt
new file mode 100644
index 0000000..a566803
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/sunxi-ss.txt
@@ -0,0 +1,9 @@
+* Allwinner Security System found on A20 SoC
+
+Required properties:
+- compatible : Should be "allwinner,sun7i-a20-crypto".
+- reg: Should contain the Security System register location and length.
+- interrupts: Should contain the IRQ line for the Security System.
+- clocks : A phandle to the functional clock node of the Security System module
+- clock-names : Name of the functional clock, should be "ahb" and "mod".
+
-- 
1.8.5.5
