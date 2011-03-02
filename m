From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  2 Mar 2011 16:53:09 +0000
Subject: [RFC PATCH 03/20] ARM: exynos4: remove stubbed twd_timer_setup call
In-Reply-To: <1299084806-16546-1-git-send-email-marc.zyngier@arm.com>
References: <1299084806-16546-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1299084806-16546-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-exynos4/localtimer.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos4/localtimer.c b/arch/arm/mach-exynos4/localtimer.c
index 6bf3d0a..9d9be20 100644
--- a/arch/arm/mach-exynos4/localtimer.c
+++ b/arch/arm/mach-exynos4/localtimer.c
@@ -21,6 +21,5 @@
 int __cpuinit local_timer_setup(struct clock_event_device *evt)
 {
 	evt->irq = IRQ_LOCALTIMER;
-	twd_timer_setup(evt);
 	return 0;
 }
-- 
1.7.0.4
