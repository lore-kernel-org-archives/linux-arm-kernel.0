From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 28 May 2013 10:21:42 +0800
Subject: [PATCH v2 0/5] ARM: mmp: move irq driver into irqchip
Message-ID: <1369707707-30295-1-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog:
v2:
1. Avoid to include <mach/irqs.h>. Move the head file into
   include/linux/irqchip directory.
2. Avoid to include <mach/pm-pxa910.h> & <mach/pm-mmp2.h>.
