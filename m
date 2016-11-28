From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 28 Nov 2016 10:46:48 +0100
Subject: [PATCH net-next v3 3/4] dt: bindings: add ethernet phy
 eee-broken-modes option documentation
In-Reply-To: <1480326409-25419-1-git-send-email-jbrunet@baylibre.com>
References: <1480326409-25419-1-git-send-email-jbrunet@baylibre.com>
Message-ID: <1480326409-25419-4-git-send-email-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Documentation/devicetree/bindings/net/phy.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/phy.txt b/Documentation/devicetree/bindings/net/phy.txt
index 4627da3d52c4..54749b60a466 100644
--- a/Documentation/devicetree/bindings/net/phy.txt
+++ b/Documentation/devicetree/bindings/net/phy.txt
@@ -38,6 +38,8 @@ Optional Properties:
 - enet-phy-lane-swap: If set, indicates the PHY will swap the TX/RX lanes to
   compensate for the board being designed with the lanes swapped.
 
+- eee-broken-modes: Bits to clear in the MDIO_AN_EEE_ADV register to
+  disable EEE broken modes.
 
 Example:
 
-- 
2.7.4
