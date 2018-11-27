From: jan.tuerk@emtrion.com (Jan Tuerk)
Date: Tue, 27 Nov 2018 16:04:02 +0100
Subject: [PATCH v8 2/4] dt-bindings: arm: Document emtrion emCON-MX6 bindings
In-Reply-To: <20181127150407.15098-1-jan.tuerk@emtrion.com>
References: <20180829100811.55836-1-jan.tuerk@emtrion.com>
 <20181127150407.15098-1-jan.tuerk@emtrion.com>
Message-ID: <20181127150407.15098-2-jan.tuerk@emtrion.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the compatible strings for emtrion emCON-MX6 SoM's.

Signed-off-by: Jan Tuerk <jan.tuerk@emtrion.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/emtrion.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/emtrion.txt

Unchanged since v6 (rebased)

diff --git a/Documentation/devicetree/bindings/arm/emtrion.txt b/Documentation/devicetree/bindings/arm/emtrion.txt
new file mode 100644
index 000000000000..83329aefc483
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/emtrion.txt
@@ -0,0 +1,12 @@
+Emtrion Devicetree Bindings
+===========================
+
+emCON Series:
+-------------
+
+Required root node properties
+	- compatible:
+	- "emtrion,emcon-mx6", "fsl,imx6q"; 		: emCON-MX6D or emCON-MX6Q SoM
+	- "emtrion,emcon-mx6-avari", "fsl,imx6q";	: emCON-MX6D or emCON-MX6Q SoM on Avari Base
+	- "emtrion,emcon-mx6", "fsl,imx6dl"; 		: emCON-MX6S or emCON-MX6DL SoM
+	- "emtrion,emcon-mx6-avari", "fsl,imx6dl";	: emCON-MX6S or emCON-MX6DL SoM on Avari Base
-- 
emtrion GmbH
Alter Schlachthof 45
76131 Karlsruhe
GERMANY
https://www.emtrion.de

Amtsgericht Mannheim
HRB 110 300
Gesch?ftsf?hrer: Dieter Baur, Ramona Maurer
