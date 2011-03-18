From: weiyi.huang@gmail.com (Huang Weiyi)
Date: Fri, 18 Mar 2011 22:06:42 +0800
Subject: [PATCH 2/4] ARM: S5P: remove duplicated #include
Message-ID: <1300457202-264-1-git-send-email-weiyi.huang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove duplicated #include('s) in
  arch/arm/mach-s5pv210/mach-smdkv210.c

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
---
 arch/arm/mach-s5pv210/mach-smdkv210.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
index bc08ac4..c6a9e86 100644
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
@@ -44,7 +44,6 @@
 #include <plat/keypad.h>
 #include <plat/pm.h>
 #include <plat/fb.h>
-#include <plat/gpio-cfg.h>
 #include <plat/s5p-time.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
-- 
1.6.1.3
