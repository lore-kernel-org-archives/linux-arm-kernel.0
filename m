From: jnair@caviumnetworks.com (Jayachandran C)
Date: Fri, 20 Jan 2017 20:46:40 +0000
Subject: [PATCH 2/3] dt-bindings: arm64 ARCH_THUNDER2 platform documentation
In-Reply-To: <1484945201-17248-1-git-send-email-jnair@caviumnetworks.com>
References: <1484945201-17248-1-git-send-email-jnair@caviumnetworks.com>
Message-ID: <1484945201-17248-3-git-send-email-jnair@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation for Cavium ThunderX2 CN99XX ARM64 processor family.
The processor core will use cavium,thunder2 as ID and the SoC will use
cavium,thunder-99xx

Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
---
 Documentation/devicetree/bindings/arm/cavium-thunder2.txt | 5 +++++
 Documentation/devicetree/bindings/arm/cpus.txt            | 1 +
 2 files changed, 6 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/cavium-thunder2.txt

diff --git a/Documentation/devicetree/bindings/arm/cavium-thunder2.txt b/Documentation/devicetree/bindings/arm/cavium-thunder2.txt
new file mode 100644
index 0000000..82276a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/cavium-thunder2.txt
@@ -0,0 +1,5 @@
+Cavium Thunder2 Family device tree bindings
+-------------------------------------------
+
+Boards with Cavium ThunderX2 CN99XX shall have the root property:
+  compatible = "cavium,thunder-99xx";
diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index a1bcfee..74f0b23 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -169,6 +169,7 @@ nodes to be present and contain the properties described below.
 			    "brcm,brahma-b15"
 			    "brcm,vulcan"
 			    "cavium,thunder"
+			    "cavium,thunder2"
 			    "faraday,fa526"
 			    "intel,sa110"
 			    "intel,sa1100"
-- 
2.7.4
