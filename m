From: weiyi.huang@gmail.com (Huang Weiyi)
Date: Thu, 20 May 2010 07:11:58 +0800
Subject: [PATCH 1/3] [ARM] remove duplicated #include
Message-ID: <1274310718-4840-1-git-send-email-weiyi.huang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove duplicated #include('s) in
  arch/arm/mach-spear6xx/spear6xx.c

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
---
 arch/arm/mach-spear6xx/spear6xx.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
index b67e571..baf6bcc 100644
--- a/arch/arm/mach-spear6xx/spear6xx.c
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@ -13,7 +13,6 @@
 
 #include <linux/types.h>
 #include <linux/amba/pl061.h>
-#include <linux/types.h>
 #include <linux/ptrace.h>
 #include <linux/io.h>
 #include <asm/hardware/vic.h>
-- 
1.6.1.3
