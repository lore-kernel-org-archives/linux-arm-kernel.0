From: Ying.Liu@freescale.com (Liu Ying)
Date: Tue, 23 Dec 2014 18:02:00 +0800
Subject: [PATCH RFC v4 02/21] of: Add vendor prefix for Himax Technologies Inc.
In-Reply-To: <1419328939-22758-1-git-send-email-Ying.Liu@freescale.com>
References: <1419328939-22758-1-git-send-email-Ying.Liu@freescale.com>
Message-ID: <1419328939-22758-3-git-send-email-Ying.Liu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
---
v3->v4:
 * Fix an ordering issue to address Stefan Wahren's comment.

v2->v3:
 * None.

v1->v2:
 * None.

 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 78efebb..f46adb2 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -67,6 +67,7 @@ gumstix	Gumstix, Inc.
 gw	Gateworks Corporation
 hannstar	HannStar Display Corporation
 haoyu	Haoyu Microelectronic Co. Ltd.
+himax	Himax Technologies, Inc.
 hisilicon	Hisilicon Limited.
 hit	Hitachi Ltd.
 honeywell	Honeywell
-- 
2.1.0
