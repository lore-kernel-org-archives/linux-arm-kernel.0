From: jacopo+renesas@jmondi.org (Jacopo Mondi)
Date: Tue, 12 Jun 2018 16:26:04 +0200
Subject: [PATCH v4 4/6] dt-bindings: media: rcar-vin: Add 'data-enable-active'
In-Reply-To: <1528813566-17927-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1528813566-17927-1-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <1528813566-17927-5-git-send-email-jacopo+renesas@jmondi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe optional endpoint property 'data-enable-active' for R-Car VIN.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas at ragnatech.se
---
 Documentation/devicetree/bindings/media/rcar_vin.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/rcar_vin.txt b/Documentation/devicetree/bindings/media/rcar_vin.txt
index 87f93ec..8130849 100644
--- a/Documentation/devicetree/bindings/media/rcar_vin.txt
+++ b/Documentation/devicetree/bindings/media/rcar_vin.txt
@@ -57,6 +57,8 @@ from local SoC CSI-2 receivers (port1) depending on SoC.
       - Optional properties for endpoint nodes of port@0:
         - hsync-active: see [1] for description. Default is active high.
         - vsync-active: see [1] for description. Default is active high.
+        - data-enable-active: polarity of CLKENB signal, see [1] for
+          description. Default is active high.
 
         If both HSYNC and VSYNC polarities are not specified, embedded
         synchronization is selected.
-- 
2.7.4
