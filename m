From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 24 Feb 2016 16:16:45 +0100
Subject: [PATCH 1/3] dt-bindings: arm/marvell: ABI unstability warning about
 Marvell 7K/8K
In-Reply-To: <1456327007-31008-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1456327007-31008-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1456327007-31008-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we are still very early in the support of Marvell Armada 7/8K
chips and those chips are significantly different from earlier 32 bits
Armada SOCs, it is difficult to commit to Device Tree ABI stability at
this point.

Therefore, this commit adds a warning to the Marvell 7K/8K DT binding
documentation to indicate that the bindings are for the moment
unstable.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../devicetree/bindings/arm/marvell/armada-7k-8k.txt         | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.txt b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.txt
index df98a9c..758b3ae 100644
--- a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.txt
@@ -1,6 +1,18 @@
 Marvell Armada 7K/8K Platforms Device Tree Bindings
 ---------------------------------------------------
 
+Work in progress statement:
+
+Device tree files and bindings applying to Marvell Armada 7K and 8K
+SoCs and boards are considered "unstable". Any Marvell Armada 7K/8K
+device tree binding may change at any time. Be sure to use a device
+tree binary and a kernel image generated from the same source tree.
+
+Please refer to Documentation/devicetree/bindings/ABI.txt for a
+definition of a stable binding/ABI.
+
+---------------------------------------------------------------
+
 Boards using a SoC of the Marvell Armada 7K or 8K families must carry
 the following root node property:
 
-- 
2.6.4
