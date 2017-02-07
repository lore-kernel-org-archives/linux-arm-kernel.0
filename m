From: jnair@caviumnetworks.com (Jayachandran C)
Date: Tue, 7 Feb 2017 21:19:58 +0000
Subject: [PATCH v3 4/5] dt-bindings: arm64 ARCH_THUNDER2 platform documentation
In-Reply-To: <1486502399-2950-1-git-send-email-jnair@caviumnetworks.com>
References: <1486502399-2950-1-git-send-email-jnair@caviumnetworks.com>
Message-ID: <1486502399-2950-5-git-send-email-jnair@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation for Cavium ThunderX2 CN99XX ARM64 processor family.
The the SoC will use the ID "cavium,thunder-99xx".

Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
---

All marketing material refers to the chip as CN99XX (like CN88XX before)
that is why I have used the wildcard-like 99xx here.

 Documentation/devicetree/bindings/arm/cavium-thunder2.txt | 5 +++++
 1 file changed, 5 insertions(+)
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
-- 
2.7.4
