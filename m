From: weiyi.huang@gmail.com (Huang Weiyi)
Date: Fri, 18 Mar 2011 22:05:55 +0800
Subject: [PATCH 1/4] ARM i.MX: remove duplicated #include
Message-ID: <1300457155-3348-1-git-send-email-weiyi.huang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove duplicated #include('s) in
  arch/arm/mach-mx5/mx51_efika.c

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
---
 arch/arm/mach-mx5/mx51_efika.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx5/mx51_efika.c b/arch/arm/mach-mx5/mx51_efika.c
index 51a67fc..07aea9c 100644
--- a/arch/arm/mach-mx5/mx51_efika.c
+++ b/arch/arm/mach-mx5/mx51_efika.c
@@ -42,7 +42,6 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
-#include <asm/mach-types.h>
 
 #include "devices-imx51.h"
 #include "devices.h"
-- 
1.6.1.3
