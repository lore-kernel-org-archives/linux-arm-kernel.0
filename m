From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 25 Mar 2015 18:32:59 +0000 (UTC)
Subject: [PATCH] MAINTAINERS: clk: discuss on the linux-clk@vger.kernel.org
 list
Message-ID: <alpine.DEB.2.02.1503251828240.13341@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Most Linux clock framework discussions take place on the
linux-kernel at vger.kernel.org or linux-arm-kernel at lists.infradead.org
mailing lists.  The volume of unrelated messages on these lists makes
it difficult for non-maintainers to follow along with discussions.
Switch the discussion list for clock framework discussions to
linux-clk at vger.kernel.org.  Also, add linux-clk at vger.kernel.org as a
mailing list for clock API discussions.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Viresh Kumar <viresh.linux@gmail.com>
Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: Prashant Gaikwad <pgaikwad@nvidia.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
Mike/Stephen, want to take this one?

 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 85024e23309f..3ca8ae5aadb0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2551,6 +2551,7 @@ F:	include/linux/cleancache.h
 
 CLK API
 M:	Russell King <linux@arm.linux.org.uk>
+L:	linux-clk at vger.kernel.org
 S:	Maintained
 F:	include/linux/clk.h
 
@@ -2611,7 +2612,7 @@ F:	drivers/media/platform/coda/
 COMMON CLK FRAMEWORK
 M:	Mike Turquette <mturquette@linaro.org>
 M:	Stephen Boyd <sboyd@codeaurora.org>
-L:	linux-kernel at vger.kernel.org
+L:	linux-clk at vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
 S:	Maintained
 F:	drivers/clk/
-- 
2.1.4
