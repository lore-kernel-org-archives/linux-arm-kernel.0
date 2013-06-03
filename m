From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon,  3 Jun 2013 17:30:34 +0800
Subject: [PATCH v3 00/11] update irqchip, clocksource, clk in mmp
Message-ID: <1370251845-31373-1-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog:
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
