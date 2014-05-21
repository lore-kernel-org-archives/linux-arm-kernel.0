From: Nikolay.Borisov@arm.com (Nikolay Borisov)
Date: Wed, 21 May 2014 14:48:05 +0100
Subject: [PATCH 2/2] documentation/devicetree: Update GIC compat strings
In-Reply-To: <1400680085-10430-1-git-send-email-Nikolay.Borisov@arm.com>
References: <1400680085-10430-1-git-send-email-Nikolay.Borisov@arm.com>
Message-ID: <1400680085-10430-3-git-send-email-Nikolay.Borisov@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds two new implementation-agonostic GIC compatible strings,
"gic-v1" and "gic-v2". Any implementation compatible with these revisions 
of the spec may include these strings in their compatible list in addition 
to any more specific string.

Signed-off-by: Nikolay Borisov <Nikolay.Borisov@arm.com>i
Acked-by: Mark Rutland <Mark.Rutland@arm.com>
---
 Documentation/devicetree/bindings/arm/gic.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
index 5573c08..223b4cc 100644
--- a/Documentation/devicetree/bindings/arm/gic.txt
+++ b/Documentation/devicetree/bindings/arm/gic.txt
@@ -12,6 +12,8 @@ Main node required properties:
 
 - compatible : should be one of:
 	"arm,gic-400"
+	"arm,gic-v1"
+	"arm,gic-v2"
 	"arm,cortex-a15-gic"
 	"arm,cortex-a9-gic"
 	"arm,cortex-a7-gic"
-- 
1.8.1.5
