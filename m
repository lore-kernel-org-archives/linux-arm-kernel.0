From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sat, 13 May 2017 17:23:10 +0200
Subject: [PATCH v2 1/3] dt-bindings: Add Kingnovel vendor prefix
In-Reply-To: <20170513152312.19912-1-afaerber@suse.de>
References: <20170513152312.19912-1-afaerber@suse.de>
Message-ID: <20170513152312.19912-2-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Their domain name is spelled kingnoval, but textually Kingnovel.

Cc: ada at kingnoval.com
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v1 -> v2:
 * Tweaked subject
 
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 4dcc3a7bcf2d..33342feb6c23 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -162,6 +162,7 @@ keithkoep	Keith & Koep GmbH
 keymile	Keymile GmbH
 khadas	Khadas
 kinetic Kinetic Technologies
+kingnovel	Kingnovel Technology Co., Ltd.
 kosagi	Sutajio Ko-Usagi PTE Ltd.
 kyo	Kyocera Corporation
 lacie	LaCie
-- 
2.12.0
