From: nathan_lynch@mentor.com (Nathan Lynch)
Date: Fri, 17 Apr 2015 16:27:03 -0500
Subject: [PATCH 1/2] ARM: VDSO: add build artifacts to .gitignore
In-Reply-To: <1429306024-5253-1-git-send-email-nathan_lynch@mentor.com>
References: <1429306024-5253-1-git-send-email-nathan_lynch@mentor.com>
Message-ID: <1429306024-5253-2-git-send-email-nathan_lynch@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vdsomunge and vdso.so.raw are outputs that don't get matched by the
normal ignore rules.

Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
---
 arch/arm/vdso/.gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/vdso/.gitignore b/arch/arm/vdso/.gitignore
index f8b69d84238e..6b47f6e0b032 100644
--- a/arch/arm/vdso/.gitignore
+++ b/arch/arm/vdso/.gitignore
@@ -1 +1,3 @@
 vdso.lds
+vdso.so.raw
+vdsomunge
-- 
1.9.3
