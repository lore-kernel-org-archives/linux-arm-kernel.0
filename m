From: codekipper@gmail.com (codekipper at gmail.com)
Date: Wed, 10 May 2017 12:31:02 +0000
Subject: [PATCH 1/2] devicetree: add Itead vendor prefix
Message-ID: <20170510123103.21992-1-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Add the "itead" vendor prefix for ITEAD Intelligent Systems Co.Ltd.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index c03d20140366..832759934517 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -158,6 +158,7 @@ iom	Iomega Corporation
 isee	ISEE 2007 S.L.
 isil	Intersil
 issi	Integrated Silicon Solutions Inc.
+itead	ITEAD Intelligent Systems Co.Ltd
 jdi	Japan Display Inc.
 jedec	JEDEC Solid State Technology Association
 karo	Ka-Ro electronics GmbH
-- 
2.12.2
