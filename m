From: Nikolay.Borisov@arm.com (Nikolay Borisov)
Date: Wed, 21 May 2014 10:28:21 +0100
Subject: [PATCH 2/2] documentation/devicetree: Update GIC compat strings
In-Reply-To: <1400664501-4208-1-git-send-email-Nikolay.Borisov@arm.com>
References: <1400664501-4208-1-git-send-email-Nikolay.Borisov@arm.com>
Message-ID: <1400664501-4208-3-git-send-email-Nikolay.Borisov@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the addition of 2 new, implementation-agnostic compatible
strings. This allows for more flexibility such that new implementation 
can either state whether they are an extension of an existing implementation,
a brand new implementation or just that they conform to a standard revision
of the GIC spec.

Signed-off-by: Nikolay Borisov <Nikolay.Borisov@arm.com>
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
