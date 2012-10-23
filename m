From: rpjday@crashcourse.ca (Robert P. J. Day)
Date: Tue, 23 Oct 2012 10:12:39 -0400 (EDT)
Subject: [PATCH] ARM: Remove obsolete reference to subsystem_init().
Message-ID: <alpine.DEB.2.02.1210231009300.5104@oneiric>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Since subsystem_init() doesn't exist anymore, reword the comment to
reflect the more general subsys_initcalls.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

  obviously, just a pedantic documentation tweak.

diff --git a/arch/arm/plat-versatile/leds.c b/arch/arm/plat-versatile/leds.c
index d2490d0..536c69a 100644
--- a/arch/arm/plat-versatile/leds.c
+++ b/arch/arm/plat-versatile/leds.c
@@ -98,6 +98,6 @@ static int __init versatile_leds_init(void)

 /*
  * Since we may have triggers on any subsystem, defer registration
- * until after subsystem_init.
+ * until after the subsys_initcalls.
  */
 fs_initcall(versatile_leds_init);

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
