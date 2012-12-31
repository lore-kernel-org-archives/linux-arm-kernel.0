From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Mon, 31 Dec 2012 12:23:50 +0100 (CET)
Subject: [PATCH 1/2] ARM: shmobile: add function declarations for sh7372 DT
 helper functions
Message-ID: <Pine.LNX.4.64.1212311213510.24596@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sh7372_add_early_devices_dt() and sh7372_add_standard_devices_dt() are
defined as global functions in arch/arm/mach-shmobile/setup-sh7372.c,
but their declarations are missing. Add them to common.h, where similar
functions for this and other SoC types are already declared.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/include/mach/common.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 7e08fa5..abce184 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -23,6 +23,8 @@ extern void sh7372_init_irq(void);
 extern void sh7372_map_io(void);
 extern void sh7372_add_early_devices(void);
 extern void sh7372_add_standard_devices(void);
+extern void sh7372_add_early_devices_dt(void);
+extern void sh7372_add_standard_devices_dt(void);
 extern void sh7372_clock_init(void);
 extern void sh7372_pinmux_init(void);
 extern void sh7372_pm_init(void);
-- 
1.7.2.5
