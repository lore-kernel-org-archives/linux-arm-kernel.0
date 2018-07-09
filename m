From: jacopo+renesas@jmondi.org (Jacopo Mondi)
Date: Mon,  9 Jul 2018 16:19:20 +0200
Subject: [PATCH v5 5/6] dt-bindings: media: rcar-vin: Add 'data-enable-active'
In-Reply-To: <1531145962-1540-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1531145962-1540-1-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <1531145962-1540-6-git-send-email-jacopo+renesas@jmondi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe optional endpoint property 'data-enable-active' for R-Car VIN.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se
---
 Documentation/devicetree/bindings/media/rcar_vin.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/rcar_vin.txt b/Documentation/devicetree/bindings/media/rcar_vin.txt
index b410863..2f42005 100644
--- a/Documentation/devicetree/bindings/media/rcar_vin.txt
+++ b/Documentation/devicetree/bindings/media/rcar_vin.txt
@@ -55,6 +55,8 @@ The per-board settings Gen2 platforms:
       the SoC type and selected input image format.
       Valid values are: 8, 10, 12, 16, 24 and 32.
     - data-shift: see [1] for description. Valid values are 0 and 8.
+    - data-enable-active: polarity of CLKENB signal, see [1] for
+      description. Default is active high.
 
 The per-board settings Gen3 platforms:
 
-- 
2.7.4
