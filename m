From: andrej@inversepath.com (andrej at inversepath.com)
Date: Tue, 21 Jun 2016 16:50:52 +0200
Subject: [PATCH 1/2] devicetree: Add vendor prefix for Inverse Path
In-Reply-To: <20160621145053.7742-1-andrej@inversepath.com>
References: <20160621145053.7742-1-andrej@inversepath.com>
Message-ID: <20160621145053.7742-2-andrej@inversepath.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrej Rosano <andrej@inversepath.com>

Inverse Path is an information security consulting company:
https://inversepath.com

Signed-off-by: Andrej Rosano <andrej@inversepath.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 2c2500d..37bfd91 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -134,6 +134,7 @@ innolux	Innolux Corporation
 intel	Intel Corporation
 intercontrol	Inter Control Group
 invensense	InvenSense Inc.
+inversepath	Inverse Path
 isee	ISEE 2007 S.L.
 isil	Intersil
 issi	Integrated Silicon Solutions Inc.
-- 
2.9.0
