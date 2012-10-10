From: shc_work@mail.ru (Alexander Shiyan)
Date: Wed, 10 Oct 2012 19:45:28 +0400
Subject: [PATCH 2/7] ARM: clps711x: p720t: remove missing #include
In-Reply-To: <1349883933-8881-1-git-send-email-shc_work@mail.ru>
References: <1349883933-8881-1-git-send-email-shc_work@mail.ru>
Message-ID: <1349883933-8881-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/p720t.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-clps711x/p720t.c b/arch/arm/mach-clps711x/p720t.c
index b752b58..7680bea 100644
--- a/arch/arm/mach-clps711x/p720t.c
+++ b/arch/arm/mach-clps711x/p720t.c
@@ -36,8 +36,6 @@
 #include <asm/mach/map.h>
 #include <mach/syspld.h>
 
-#include <asm/hardware/clps7111.h>
-
 #include "common.h"
 
 /*
-- 
1.7.8.6
