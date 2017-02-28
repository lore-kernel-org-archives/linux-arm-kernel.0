From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue, 28 Feb 2017 07:35:11 +0100
Subject: [PATCH v3 01/25] dt-bindings: Add vendor prefix for Actions Semi
In-Reply-To: <20170228063535.32069-1-afaerber@suse.de>
References: <20170228063535.32069-1-afaerber@suse.de>
Message-ID: <20170228063535.32069-2-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Actions Semiconductor was listed on NASDAQ as ACTS until Dec 16, 2016.

Cc: mp-cs at actions-semi.com
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2 -> v3:
 * Fixed sort order after rename
 
 v1 -> v2:
 * Reverted from "acts" to "actions" (cf. IAP140 "mrvl" vs. "marvell")
 
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index a76b981..2f294c8 100644
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
2.10.2
