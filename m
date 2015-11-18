From: marex@denx.de (Marek Vasut)
Date: Wed, 18 Nov 2015 10:48:39 +0100
Subject: [PATCH 1/2] devicetree: bindings: Add vendor prefix for Kosagi
Message-ID: <1447840120-8513-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Cross <xobs@kosagi.com>

Add a vendor prefix for Sutajio Ko-Usagi PTE Ltd., which goes by the
more common name of Kosagi.

Signed-off-by: Sean Cross <xobs@kosagi.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 55df1d4..a51e829 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -123,6 +123,7 @@ jedec	JEDEC Solid State Technology Association
 karo	Ka-Ro electronics GmbH
 keymile	Keymile GmbH
 kinetic Kinetic Technologies
+kosagi	Sutajio Ko-Usagi PTE Ltd.
 lacie	LaCie
 lantiq	Lantiq Semiconductor
 lenovo	Lenovo Group Ltd.
-- 
2.1.4
