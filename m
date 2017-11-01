From: sebastien.bourdelin@savoirfairelinux.com (Sebastien Bourdelin)
Date: Wed,  1 Nov 2017 13:06:44 -0400
Subject: [PATCH v7 1/2] of: documentation: add bindings documentation for
 TS-4600
Message-ID: <20171101170645.12918-1-sebastien.bourdelin@savoirfairelinux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the documentation for the TS-4600 by Technologic Systems.

Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes v6 -> v7:
  - rebase on master

Changes v5 -> v6:
  - rebase on master
  - split the previous patch series into series by subsystem

Changes v4 -> v5:
  - fix missing signed off

Changes v3 -> v4:
  - rebase on master

Changes v2 -> v3:
  - rebase on master

Changes v1 -> v2:
  - rebase on master
  - add ack by Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/technologic.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/technologic.txt b/Documentation/devicetree/bindings/arm/technologic.txt
index 33797acad846..e9d6d6575566 100644
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
2.13.4
