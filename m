From: naobsd@gmail.com (FUKAUMI Naoki)
Date: Thu, 15 Jan 2015 11:40:57 +0900
Subject: [PATCH 1/3] dt-bindings: add vendor prefix and root compatible
 property for Rockchip boards
In-Reply-To: <1421289659-16627-1-git-send-email-naobsd@gmail.com>
References: <1421289659-16627-1-git-send-email-naobsd@gmail.com>
Message-ID: <1421289659-16627-2-git-send-email-naobsd@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this adds vendor prefix and root compatible property for following boards

- Firefly, Firefly-RK3288 board
- ChipSPARK, Rayeager PX2 board

PX2 SoC is fully compatible with RK3066.

Signed-off-by: FUKAUMI Naoki <naobsd@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.txt    | 8 ++++++++
 Documentation/devicetree/bindings/vendor-prefixes.txt | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
index eaa3d1a..7cc1cecd 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.txt
+++ b/Documentation/devicetree/bindings/arm/rockchip.txt
@@ -9,6 +9,14 @@ Rockchip platforms device tree bindings
     Required root node properties:
       - compatible = "mundoreader,bq-curie2", "rockchip,rk3066a";
 
+- ChipSPARK Rayeager PX2 board:
+    Required root node properties:
+      - compatible = "chipspark,rayeager-px2", "rockchip,rk3066a";
+
 - Radxa Rock board:
     Required root node properties:
       - compatible = "radxa,rock", "rockchip,rk3188";
+
+- Firefly Firefly-RK3288 board:
+    Required root node properties:
+      - compatible = "firefly,firefly-rk3288", "rockchip,rk3288";
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 5d2251a..0d37f5f 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -32,6 +32,7 @@ capella	Capella Microsystems, Inc
 cavium	Cavium, Inc.
 cdns	Cadence Design Systems Inc.
 chipidea	Chipidea, Inc
+chipspark	ChipSPARK
 chrp	Common Hardware Reference Platform
 chunghwa	Chunghwa Picture Tubes Ltd.
 cirrus	Cirrus Logic, Inc.
@@ -62,6 +63,7 @@ everest	Everest Semiconductor Co. Ltd.
 everspin	Everspin Technologies, Inc.
 excito	Excito
 fcs	Fairchild Semiconductor
+firefly	Firefly
 fsl	Freescale Semiconductor
 GEFanuc	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
 gef	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
-- 
2.2.2
