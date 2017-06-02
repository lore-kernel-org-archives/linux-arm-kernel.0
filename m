From: biju.das@bp.renesas.com (Biju Das)
Date: Fri,  2 Jun 2017 17:22:00 +0100
Subject: [PATCH 1/4] of: Add vendor prefix for iWave Systems Technologies Pvt.
 Ltd
In-Reply-To: <1496420523-23506-1-git-send-email-biju.das@bp.renesas.com>
References: <1496420523-23506-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1496420523-23506-2-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds vendor prefix for iWave Systems Technologies Pvt. Ltd.
Website: http://www.iwavesystems.com/

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index d808f24..a74400a 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -160,6 +160,7 @@ isee	ISEE 2007 S.L.
 isil	Intersil
 issi	Integrated Silicon Solutions Inc.
 itead	ITEAD Intelligent Systems Co.Ltd
+iwave  iWave Systems Technologies Pvt. Ltd.
 jdi	Japan Display Inc.
 jedec	JEDEC Solid State Technology Association
 karo	Ka-Ro electronics GmbH
-- 
1.9.1
