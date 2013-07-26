From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 26 Jul 2013 18:05:22 +0800
Subject: No subject
Message-ID: <1374833133-21119-1-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog:
v6:
1. Merge clk apbc & apbcp together.
2. Add DT binding document of clock driver.
3. Remove marvell string in properties of clock driver.

v5:
1. Use clk mux table.

v4:
1. Remove .init_irq in mmp & mmp2 DT machine descriptor.
2. Use an argument to replace TIMER_PHYS_BASE. Now transfer virtual
address directly.
3. Merge 10th & 11th patches together. Remove the redundant changes
on drivers/clocksource/Kconfig & drivers/clocksource/Makefile.

v3:
1. Don't use include/linux/irqchip/mmp.h since we don't need to
move <mach/irqs.h> to <include/linux/irqchip/mmp.h>.
2. Move timer-mmp driver into clocksource directory & support
clocksource.
3. Support clksrc in mmp & parse all clock from DTS.

v2:
1. Avoid to include <mach/irqs.h>. Move the head file into
   include/linux/irqchip directory.
2. Avoid to include <mach/pm-pxa910.h> & <mach/pm-mmp2.h>.
