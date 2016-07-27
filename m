From: lucile.quirion@savoirfairelinux.com (Lucile Quirion)
Date: Wed, 27 Jul 2016 13:53:01 -0400
Subject: [PATCH 1/2] of: documentation: add bindings documentation for TS-4900
In-Reply-To: <1469641982-19558-1-git-send-email-lucile.quirion@savoirfairelinux.com>
References: <1469641982-19558-1-git-send-email-lucile.quirion@savoirfairelinux.com>
Message-ID: <1469641982-19558-2-git-send-email-lucile.quirion@savoirfairelinux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the documentation for the TS-4900 by Technologic Systems.

Signed-off-by: Lucile Quirion <lucile.quirion@savoirfairelinux.com>
---
 Documentation/devicetree/bindings/arm/technologic.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/technologic.txt b/Documentation/devicetree/bindings/arm/technologic.txt
index 8422988..33797ac 100644
--- a/Documentation/devicetree/bindings/arm/technologic.txt
+++ b/Documentation/devicetree/bindings/arm/technologic.txt
@@ -4,3 +4,9 @@ Technologic Systems Platforms Device Tree Bindings
 TS-4800 board
 Required root node properties:
 	- compatible = "technologic,imx51-ts4800", "fsl,imx51";
+
+TS-4900 is a System-on-Module based on the Freescale i.MX6 System-on-Chip.
+It can be mounted on a carrier board providing additional peripheral connectors.
+Required root node properties:
+	- compatible = "technologic,imx6dl-ts4900", "fsl,imx6dl"
+	- compatible = "technologic,imx6q-ts4900", "fsl,imx6q"
-- 
2.5.5
