From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  3 Jun 2011 15:57:19 +0100
Subject: [PATCH v1 04/18] ARM: exynos4: remove stubbed twd_timer_setup call
In-Reply-To: <1307113053-30209-1-git-send-email-marc.zyngier@arm.com>
References: <1307113053-30209-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1307113053-30209-5-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-exynos4/localtimer.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos4/localtimer.c b/arch/arm/mach-exynos4/localtimer.c
index 315de6f..6184e29 100644
--- a/arch/arm/mach-exynos4/localtimer.c
+++ b/arch/arm/mach-exynos4/localtimer.c
@@ -22,6 +22,5 @@
 int __cpuinit local_timer_setup(struct clock_event_device *evt)
 {
 	evt->irq = gic_ppi_to_vppi(IRQ_LOCALTIMER);
-	twd_timer_setup(evt);
 	return 0;
 }
-- 
1.7.0.4
