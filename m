From: maz@misterjones.org (Marc Zyngier)
Date: Thu, 18 Feb 2010 20:30:31 +0000
Subject: [PATCH 3/5] Add Eurotech as the manufacturer of the Zeus board
Message-ID: <20100218203031.4d45ef39@taxman.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Amit Walambe <amit.walambe@eurotech.com>
Signed-off-by: Marc Zyngier <maz@misterjones.org>
---
 arch/arm/mach-pxa/zeus.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index 4034b98..c252ea3 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -839,7 +839,7 @@ static void __init zeus_map_io(void)
 	PCFR = PCFR_OPDE | PCFR_DC_EN | PCFR_FS | PCFR_FP;
 }
 
-MACHINE_START(ARCOM_ZEUS, "Arcom ZEUS")
+MACHINE_START(ARCOM_ZEUS, "Arcom/Eurotech ZEUS")
 	/* Maintainer: Marc Zyngier <maz@misterjones.org> */
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= ((io_p2v(0x40000000) >> 18) & 0xfffc),
-- 
1.7.0



-- 
I'm the slime oozin' out from your TV set...
