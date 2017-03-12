From: jnair@caviumnetworks.com (Jayachandran C)
Date: Sun, 12 Mar 2017 10:03:34 +0000
Subject: [PATCH v5 1/2] dt-bindings: arm64 ARCH_THUNDER2 platform documentation
In-Reply-To: <1489313015-4783-1-git-send-email-jnair@caviumnetworks.com>
References: <1489313015-4783-1-git-send-email-jnair@caviumnetworks.com>
Message-ID: <1489313015-4783-2-git-send-email-jnair@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation for Cavium's ThunderX2 CN99XX ARM64 processor. This
SoC will use "cavium,thunderx2-cn9900" as the compatible property.

Also add a documentation entry for the "cavium,thunder2" cpu core
present in these SoCs.

Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
Acked-by: Rob Herring <robh@kernel.org>
---
[ v5: updated the commit message for clarity ]

 Documentation/devicetree/bindings/arm/cavium-thunder2.txt | 8 ++++++++
 Documentation/devicetree/bindings/arm/cpus.txt            | 1 +
 2 files changed, 9 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/cavium-thunder2.txt

diff --git a/Documentation/devicetree/bindings/arm/cavium-thunder2.txt b/Documentation/devicetree/bindings/arm/cavium-thunder2.txt
new file mode 100644
index 0000000..dc5dd65
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/cavium-thunder2.txt
@@ -0,0 +1,8 @@
+Cavium ThunderX2 CN99XX platform tree bindings
+----------------------------------------------
+
+Boards with Cavium ThunderX2 CN99XX SoC shall have the root property:
+  compatible = "cavium,thunderx2-cn9900", "brcm,vulcan-soc";
+
+These SoC uses the "cavium,thunder2" core which will be compatible
+with "brcm,vulcan".
diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 698ad1f0..1030f5f 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -170,6 +170,7 @@ nodes to be present and contain the properties described below.
 			    "brcm,brahma-b15"
 			    "brcm,vulcan"
 			    "cavium,thunder"
+			    "cavium,thunder2"
 			    "faraday,fa526"
 			    "intel,sa110"
 			    "intel,sa1100"
-- 
2.7.4
