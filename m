From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:47:14 -0400
Subject: [PATCH 29/52] ARM: mach-nuc93x: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-29-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-nuc93x/mach-nuc932evb.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-nuc93x/mach-nuc932evb.c b/arch/arm/mach-nuc93x/mach-nuc932evb.c
index d702570..1f741b1 100644
--- a/arch/arm/mach-nuc93x/mach-nuc932evb.c
+++ b/arch/arm/mach-nuc93x/mach-nuc932evb.c
@@ -35,7 +35,6 @@ static void __init nuc932evb_init(void)
 
 MACHINE_START(NUC932EVB, "NUC932EVB")
 	/* Maintainer: Wan ZongShun */
-	.boot_params	= 0,
 	.map_io		= nuc932evb_map_io,
 	.init_irq	= nuc93x_init_irq,
 	.init_machine	= nuc932evb_init,
-- 
1.7.4
