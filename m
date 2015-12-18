From: marex@denx.de (Marek Vasut)
Date: Fri, 18 Dec 2015 06:29:49 +0100
Subject: [PATCH V2 1/2] devicetree: bindings: Add vendor prefix for Kosagi
Message-ID: <1450416590-14908-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Cross <xobs@kosagi.com>

Add a vendor prefix for Sutajio Ko-Usagi PTE Ltd., which goes by the
more common name of Kosagi.

Signed-off-by: Sean Cross <xobs@kosagi.com>
Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

V2: Rebase on top of linux-next

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 38eeaa2..265ec68 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -125,6 +125,7 @@ karo	Ka-Ro electronics GmbH
 keymile	Keymile GmbH
 kinetic Kinetic Technologies
 kyo	Kyocera Corporation
+kosagi	Sutajio Ko-Usagi PTE Ltd.
 lacie	LaCie
 lantiq	Lantiq Semiconductor
 lenovo	Lenovo Group Ltd.
-- 
2.1.4
