From: andrej@inversepath.com (andrej at inversepath.com)
Date: Mon,  5 Sep 2016 12:11:16 +0200
Subject: [PATCH v3 1/2] devicetree: Add vendor prefix for Inverse Path
In-Reply-To: <20160905101117.27473-1-andrej@inversepath.com>
References: <20160905101117.27473-1-andrej@inversepath.com>
Message-ID: <20160905101117.27473-2-andrej@inversepath.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrej Rosano <andrej@inversepath.com>

Inverse Path is an information security consulting company:
https://inversepath.com

Signed-off-by: Andrej Rosano <andrej@inversepath.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 1992aa9..3003f33 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -135,6 +135,7 @@ innolux	Innolux Corporation
 intel	Intel Corporation
 intercontrol	Inter Control Group
 invensense	InvenSense Inc.
+inversepath	Inverse Path
 isee	ISEE 2007 S.L.
 isil	Intersil
 issi	Integrated Silicon Solutions Inc.
-- 
2.9.3
