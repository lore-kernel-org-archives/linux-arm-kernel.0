From: horms@verge.net.au (Simon Horman)
Date: Thu,  1 Nov 2012 08:41:48 +0800
Subject: [PATCH 06/11] ARM: shmobile: r8a7740: fixup DT machine desc name typo
In-Reply-To: <1351730513-2952-1-git-send-email-horms@verge.net.au>
References: <1351730513-2952-1-git-send-email-horms@verge.net.au>
Message-ID: <1351730513-2952-7-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

r8a7740 machine desc name should be R8A7740,
not SH7372

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7740.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 11bb1d9..9777e2d 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -747,7 +747,7 @@ static const char *r8a7740_boards_compat_dt[] __initdata = {
 	NULL,
 };
 
-DT_MACHINE_START(SH7372_DT, "Generic R8A7740 (Flattened Device Tree)")
+DT_MACHINE_START(R8A7740_DT, "Generic R8A7740 (Flattened Device Tree)")
 	.map_io		= r8a7740_map_io,
 	.init_early	= r8a7740_add_early_devices_dt,
 	.init_irq	= r8a7740_init_irq,
-- 
1.7.10.4
