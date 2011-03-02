From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  2 Mar 2011 16:53:10 +0000
Subject: [RFC PATCH 04/20] ARM: shmobile: remove stubbed twd_timer_setup call
In-Reply-To: <1299084806-16546-1-git-send-email-marc.zyngier@arm.com>
References: <1299084806-16546-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1299084806-16546-5-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-shmobile/localtimer.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/localtimer.c b/arch/arm/mach-shmobile/localtimer.c
index ad9ccc9..a4c4e8b 100644
--- a/arch/arm/mach-shmobile/localtimer.c
+++ b/arch/arm/mach-shmobile/localtimer.c
@@ -21,6 +21,5 @@
 int __cpuinit local_timer_setup(struct clock_event_device *evt)
 {
 	evt->irq = 29;
-	twd_timer_setup(evt);
 	return 0;
 }
-- 
1.7.0.4
