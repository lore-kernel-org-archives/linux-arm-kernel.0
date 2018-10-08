From: shawnguo@kernel.org (Shawn Guo)
Date: Mon,  8 Oct 2018 15:14:58 +0800
Subject: [PATCH] MAINTAINERS: remove non-exsiting email address of Baoyou
Message-ID: <20181008071458.6237-1-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We keep getting bounces from Baoyou Xie <baoyou.xie@linaro.org>.  We
do not know Baoyou's new email address, nor his interest to stay as
the co-maintainer.  Let's remove the non-exsiting email first, and we
can add his new email back if we heard back from him later.

Cc: Jun Nie <jun.nie@linaro.org>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ad052aeac39..89c9f38b052d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2263,7 +2263,6 @@ F:	arch/arm/mach-pxa/include/mach/z2.h
 
 ARM/ZTE ARCHITECTURE
 M:	Jun Nie <jun.nie@linaro.org>
-M:	Baoyou Xie <baoyou.xie@linaro.org>
 M:	Shawn Guo <shawnguo@kernel.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-- 
2.18.0
