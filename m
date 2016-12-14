From: sebastien.bourdelin@savoirfairelinux.com (Sebastien Bourdelin)
Date: Wed, 14 Dec 2016 18:12:31 -0500
Subject: [PATCH 1/6] of: documentation: add bindings documentation for TS-4600
In-Reply-To: <20161214231237.17496-1-sebastien.bourdelin@savoirfairelinux.com>
References: <20161214231237.17496-1-sebastien.bourdelin@savoirfairelinux.com>
Message-ID: <20161214231237.17496-2-sebastien.bourdelin@savoirfairelinux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the documentation for the TS-4600 by Technologic Systems.

Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
---
 Documentation/devicetree/bindings/arm/technologic.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/technologic.txt b/Documentation/devicetree/bindings/arm/technologic.txt
index 33797ac..e9d6d65 100644
--- a/Documentation/devicetree/bindings/arm/technologic.txt
+++ b/Documentation/devicetree/bindings/arm/technologic.txt
@@ -1,6 +1,11 @@
 Technologic Systems Platforms Device Tree Bindings
 --------------------------------------------------
 
+TS-4600 is a System-on-Module based on the Freescale i.MX28 System-on-Chip.
+It can be mounted on a carrier board providing additional peripheral connectors.
+Required root node properties:
+	- compatible = "technologic,imx28-ts4600", "fsl,imx28"
+
 TS-4800 board
 Required root node properties:
 	- compatible = "technologic,imx51-ts4800", "fsl,imx51";
-- 
2.10.2
