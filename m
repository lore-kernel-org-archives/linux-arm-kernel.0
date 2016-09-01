From: laurentiu.tudor@nxp.com (Laurentiu Tudor)
Date: Thu, 1 Sep 2016 15:06:03 +0000
Subject: [PATCH] Documentation: kasan: arm64 has kasan support too
Message-ID: <57C843DA.8040705@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mention that arm64 also has kasan support.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 Documentation/kasan.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/kasan.txt b/Documentation/kasan.txt
index 7dd95b3..c156934 100644
--- a/Documentation/kasan.txt
+++ b/Documentation/kasan.txt
@@ -12,7 +12,7 @@ KASAN uses compile-time instrumentation for checking every memory access,
 therefore you will need a GCC version 4.9.2 or later. GCC 5.0 or later is
 required for detection of out-of-bounds accesses to stack or global variables.
 
-Currently KASAN is supported only for x86_64 architecture.
+Currently KASAN is supported only for x86_64 and arm64 architectures.
 
 1. Usage
 ========
-- 
1.8.3.1
