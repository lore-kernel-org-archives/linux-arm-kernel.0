From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 15 Nov 2018 17:35:51 +0800
Subject: [PATCH v2 03/15] dt-bindings: net: broadcom-bluetooth: Add BCM20702A1
 compatible string
In-Reply-To: <20181115093603.26729-1-wens@csie.org>
References: <20181115093603.26729-1-wens@csie.org>
Message-ID: <20181115093603.26729-4-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The BCM20702A1 is a Bluetooth 4.0 chip from Broadcom. It is found in the
Ampak AP6210 WiFi+BT module, identified from the read verbose config info
command response. However the Bluetooth firmware provided by vendors uses
the name BCM20710. This patch elects to use the chip ID returned by the
chip for the compatible string.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/net/broadcom-bluetooth.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
index 78cfa0fbece9..d9d734a07faf 100644
--- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
@@ -10,6 +10,7 @@ device the slave device is attached to.
 Required properties:
 
  - compatible: should contain one of the following:
+   * "brcm,bcm20702a1"
    * "brcm,bcm43438-bt"
 
 Optional properties:
-- 
2.19.1
