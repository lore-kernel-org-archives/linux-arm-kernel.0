From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:47:07 -0400
Subject: [PATCH 22/52] ARM: mach-loki: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-22-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-loki/lb88rc8480-setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-loki/lb88rc8480-setup.c b/arch/arm/mach-loki/lb88rc8480-setup.c
index 35eae4e..cd4fa76 100644
--- a/arch/arm/mach-loki/lb88rc8480-setup.c
+++ b/arch/arm/mach-loki/lb88rc8480-setup.c
@@ -90,7 +90,7 @@ static void __init lb88rc8480_init(void)
 
 MACHINE_START(LB88RC8480, "Marvell LB88RC8480 Development Board")
 	/* Maintainer: Ke Wei <kewei@marvell.com> */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= lb88rc8480_init,
 	.map_io		= loki_map_io,
 	.init_early	= loki_init_early,
-- 
1.7.4
