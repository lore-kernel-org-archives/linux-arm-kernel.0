From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 06 Mar 2013 09:22:53 +0900
Subject: [PATCH 04/04] ARM: shmobile: Remove r8a7779_register_twd() from
 common.h
In-Reply-To: <20130306002214.5430.43766.sendpatchset@w520>
References: <20130306002214.5430.43766.sendpatchset@w520>
Message-ID: <20130306002253.5430.18137.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove unnecessary r8a7779_register_twd() from common.h

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/common.h |    2 --
 1 file changed, 2 deletions(-)

--- 0001/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2013-03-05 18:38:07.000000000 +0900
@@ -71,8 +71,6 @@ extern void r8a7779_pinmux_init(void);
 extern void r8a7779_pm_init(void);
 extern void r8a7740_meram_workaround(void);
 
-extern void r8a7779_register_twd(void);
-
 #ifdef CONFIG_SUSPEND
 int shmobile_suspend_init(void);
 #else
