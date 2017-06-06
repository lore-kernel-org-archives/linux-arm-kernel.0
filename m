From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue,  6 Jun 2017 02:53:59 +0200
Subject: [PATCH v4 01/28] dt-bindings: Add vendor prefix for Actions Semi
In-Reply-To: <20170606005426.26446-1-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
Message-ID: <20170606005426.26446-2-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Actions Semiconductor was listed on NASDAQ as ACTS until Dec 16, 2016.

Cc: mp-cs at actions-semi.com
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v3 -> v4: Unchanged
 
 v2 -> v3:
 * Fixed sort order after rename
 
 v1 -> v2:
 * Reverted from "acts" to "actions" (cf. IAP140 "mrvl" vs. "marvell")
 
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index d808f24af949..3b02d90e2003 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -5,6 +5,7 @@ using them to avoid name-space collisions.
 
 abcn	Abracon Corporation
 abilis	Abilis Systems
+actions	Actions Semiconductor Co., Ltd.
 active-semi	Active-Semi International Inc
 ad	Avionic Design GmbH
 adapteva	Adapteva, Inc.
-- 
2.12.3
