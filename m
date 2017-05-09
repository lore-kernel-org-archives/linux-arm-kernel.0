From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Wed, 10 May 2017 00:12:31 +0800
Subject: [PATCH v3] dt-bindings: add vendor prefix for bananapi
Message-ID: <271c3a1548a712c529e5fd783f785e9847ab5103.1494345301.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Add BIPAI KEJI LIMITED which is a company dedicating to design and
manufacture bananapi open hardware.

Website: http://www.banana-pi.org/

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index c7d1b72..8f7283d 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -44,6 +44,7 @@ avia	avia semiconductor
 avic	Shanghai AVIC Optoelectronics Co., Ltd.
 axentia	Axentia Technologies AB
 axis	Axis Communications AB
+bananapi BIPAI KEJI LIMITED
 boe	BOE Technology Group Co., Ltd.
 bosch	Bosch Sensortec GmbH
 boundary	Boundary Devices Inc.
-- 
2.7.4
