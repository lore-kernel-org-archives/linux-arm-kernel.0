From: jan.tuerk@emtrion.com (jan.tuerk at emtrion.com)
Date: Fri, 27 Apr 2018 15:24:40 +0200
Subject: [PATCH v4 5/7] dt-bindings: arm: Document emtrion emCON-MX6 bindings
In-Reply-To: <20180427132445.3458-1-jan.tuerk@emtrion.com>
References: <20180420125108.14197-1-jan.tuerk@emtrion.com>
 <20180427132445.3458-1-jan.tuerk@emtrion.com>
Message-ID: <20180427132445.3458-6-jan.tuerk@emtrion.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jan Tuerk <jan.tuerk@emtrion.com>

Document the compatible strings for emtrion emCON-MX6 SoM's.

Signed-off-by: Jan Tuerk <jan.tuerk@emtrion.com>
---
For v4:
 - separate patch for the emtrion emCON-MX6 DT-bindings

 Documentation/devicetree/bindings/arm/emtrion.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/emtrion.txt

diff --git a/Documentation/devicetree/bindings/arm/emtrion.txt b/Documentation/devicetree/bindings/arm/emtrion.txt
new file mode 100644
index 000000000000..3ff6c6c2034d
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/emtrion.txt
@@ -0,0 +1,13 @@
+Emtrion Devicetree Bindings
+===========================
+
+emCON Series:
+-------------
+
+Required root node properties
+	- compatible:
+	- "emtrion,emcon-mx6", "fsl,imx6q", "fsl,imx6dl"; : emCON-MX6 Generic SoM
+	- "emtrion,emcon-mx6", "fsl,imx6q"; 		: emCON-MX6D or emCON-MX6Q SoM
+	- "emtrion,emcon-mx6-avari", "fsl,imx6q";	: emCON-MX6D or emCON-MX6Q SoM on Avari Base
+	- "emtrion,emcon-mx6", "fsl,imx6dl"; 		: emCON-MX6S or emCON-MX6DL SoM
+	- "emtrion,emcon-mx6-avari", "fsl,imx6dl";	: emCON-MX6S or emCON-MX6DL SoM on Avari Base
-- 
2.11.0
