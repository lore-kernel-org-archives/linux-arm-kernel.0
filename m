From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue, 28 Feb 2017 07:35:22 +0100
Subject: [PATCH v3 12/25] dt-bindings: Add vendor prefix for uCRobotics
In-Reply-To: <20170228063535.32069-1-afaerber@suse.de>
References: <20170228063535.32069-1-afaerber@suse.de>
Message-ID: <20170228063535.32069-13-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: 96boards at ucrobotics.com
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v1 -> v2 -> v3: unchanged
 
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 2f294c8..44232c2 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -320,6 +320,7 @@ tronfy	Tronfy
 tronsmart	Tronsmart
 truly	Truly Semiconductors Limited
 tyan	Tyan Computer Corporation
+ucrobotics	uCRobotics
 udoo	Udoo
 uniwest	United Western Technologies Corp (UniWest)
 upisemi	uPI Semiconductor Corp.
-- 
2.10.2
