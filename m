From: jacopo+renesas@jmondi.org (Jacopo Mondi)
Date: Tue, 29 May 2018 17:05:55 +0200
Subject: [PATCH v3 4/8] dt-bindings: media: rcar-vin: Add 'data-enable-active'
In-Reply-To: <1527606359-19261-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1527606359-19261-1-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <1527606359-19261-5-git-send-email-jacopo+renesas@jmondi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe optional endpoint property 'data-enable-active' for R-Car VIN.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
v3:
- new patch
---

 Documentation/devicetree/bindings/media/rcar_vin.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/rcar_vin.txt b/Documentation/devicetree/bindings/media/rcar_vin.txt
index 4d91a36..ff53226 100644
--- a/Documentation/devicetree/bindings/media/rcar_vin.txt
+++ b/Documentation/devicetree/bindings/media/rcar_vin.txt
@@ -58,6 +58,8 @@ from local SoC CSI-2 receivers (port1) depending on SoC.
       - Optional properties for endpoint nodes of port at 0:
         - hsync-active: see [1] for description. Default is active high.
         - vsync-active: see [1] for description. Default is active high.
+        - data-enable-active: polarity of CLKENB signal, see [1] for
+          description. Default is active high.

         If both HSYNC and VSYNC polarities are not specified, embedded
         synchronization is selected.
--
2.7.4
