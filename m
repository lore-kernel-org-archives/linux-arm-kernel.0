From: wens@csie.org (Chen-Yu Tsai)
Date: Wed,  7 Nov 2018 18:12:57 +0800
Subject: [PATCH 04/15] dt-bindings: net: broadcom-bluetooth: Add BCM4330
 compatible string
In-Reply-To: <20181107101308.7626-1-wens@csie.org>
References: <20181107101308.7626-1-wens@csie.org>
Message-ID: <20181107101308.7626-5-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The BCM4330 is a 802.11 a/b/g/n WiFi + Bluetooth 4.0 chip from Broadcom.
It is found in the Ampak AP6330 WiFi+BT module. The partiular one I have
identifies as BCM4330B1 for Bluetooth and BCM4330/4 for WiFi.

It is unclear if the AP6330 module uses this revision of the BCM4330, or
if there are multiple revisions. The module does not have revision
markings. This patch elects to use just BCM4330 for the compatible
string.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/net/broadcom-bluetooth.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
index cb50931a6506..33423002c8c2 100644
--- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
@@ -11,6 +11,7 @@ Required properties:
 
  - compatible: should contain one of the following:
    * "brcm,bcm20702a1"
+   * "brcm,bcm4330-bt"
    * "brcm,bcm43438-bt"
 
 Optional properties:
-- 
2.19.1
