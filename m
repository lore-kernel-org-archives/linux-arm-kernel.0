From: weiyi.huang@gmail.com (Huang Weiyi)
Date: Sun, 14 Mar 2010 10:57:16 +0800
Subject: [PATCH 3/3] [ARM] pxa/raumfeld: remove duplicated #include
Message-ID: <1268535436-876-1-git-send-email-weiyi.huang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove duplicated #include('s) in
  arch/arm/mach-pxa/raumfeld.c

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
---
 arch/arm/mach-pxa/raumfeld.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index 3184bdc..9d23f69 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -37,8 +37,6 @@
 #include <linux/lis3lv02d.h>
 #include <linux/pda_power.h>
 #include <linux/power_supply.h>
-#include <linux/pda_power.h>
-#include <linux/power_supply.h>
 #include <linux/regulator/max8660.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/fixed.h>
-- 
1.6.1.3
