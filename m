From: dinguyen@kernel.org (Dinh Nguyen)
Date: Tue,  1 Nov 2016 10:36:30 -0500
Subject: [PATCH 1/3] dt-bindings: Add Macnica Americas vendor prefix
Message-ID: <20161101153632.6844-1-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a vendor prefix for the Macnica company.
http://http://www.macnica.com

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index f0a48ea..81674f2 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -158,6 +158,7 @@ lg	LG Corporation
 linux	Linux-specific binding
 lltc	Linear Technology Corporation
 lsi	LSI Corp. (LSI Logic)
+macnica	Macnica Americas
 marvell	Marvell Technology Group Ltd.
 maxim	Maxim Integrated Products
 meas	Measurement Specialties
-- 
2.8.3
