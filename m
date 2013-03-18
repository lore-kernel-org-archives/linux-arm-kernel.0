From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 21:32:46 +0900
Subject: [PATCH 36/43] ARM: shmobile: r8a7779: fixup DT machine name
In-Reply-To: <1363609973-31086-1-git-send-email-horms+renesas@verge.net.au>
References: <1363609973-31086-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363609973-31086-37-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

r8a7779 is not sh73a0

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7779.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 7f8daf1..9322858 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -414,7 +414,7 @@ static const char *r8a7779_compat_dt[] __initdata = {
 	NULL,
 };
 
-DT_MACHINE_START(SH73A0_DT, "Generic R8A7779 (Flattened Device Tree)")
+DT_MACHINE_START(R8A7779_DT, "Generic R8A7779 (Flattened Device Tree)")
 	.map_io		= r8a7779_map_io,
 	.init_early	= r8a7779_init_delay,
 	.nr_irqs	= NR_IRQS_LEGACY,
-- 
1.7.10.4
