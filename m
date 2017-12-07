From: sebastien.bourdelin@savoirfairelinux.com (Sebastien Bourdelin)
Date: Thu,  7 Dec 2017 11:05:49 -0500
Subject: [PATCH v4 1/2] of: documentation: add bindings documentation for
 TS-7970
Message-ID: <20171207160550.2782-1-sebastien.bourdelin@savoirfairelinux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the documentation for the TS-7970 by Technologic Systems.

Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
---
Changes v3 -> v4:
  - rebase on master

Changes v1 -> v2:
  - rebase on master
---
 Documentation/devicetree/bindings/arm/technologic.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/technologic.txt b/Documentation/devicetree/bindings/arm/technologic.txt
index 33797acad846..187830bd4f51 100644
--- a/Documentation/devicetree/bindings/arm/technologic.txt
+++ b/Documentation/devicetree/bindings/arm/technologic.txt
@@ -10,3 +10,9 @@ It can be mounted on a carrier board providing additional peripheral connectors.
 Required root node properties:
 	- compatible = "technologic,imx6dl-ts4900", "fsl,imx6dl"
 	- compatible = "technologic,imx6q-ts4900", "fsl,imx6q"
+
+TS-7970 is a System-on-Module based on the Freescale i.MX6 System-on-Chip.
+It can be mounted on a carrier board providing additional peripheral connectors.
+Required root node properties:
+	- compatible = "technologic,imx6dl-ts7970", "fsl,imx6dl"
+	- compatible = "technologic,imx6q-ts7970", "fsl,imx6q"
-- 
2.15.0
