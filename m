From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Tue, 11 Oct 2011 21:17:24 +0800
Subject: [PATCH v3 0/7] clean pxa gpio driver
Message-ID: <1318339051-19096-1-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reformat these patches since Linus's GPIO patches are already merged.

Changelog
v3:
	1. Rebase on Russell's for-next branch.
	2. Add clock support.
	3. Move gpio edge detection initiliaztion of arch-mmp into gpio driver.

v2:
       1. Remove gpio.c from mach-pxa & mach-mmp that is introduced from v1.
       2. Remove init function in gpio.c. Move the platfrom_device_register()
          into platform driver.
       3. Initialize pxa_gpio_regs in gpio-pxa.c
       4. Simplify code of identifing pxa gpio series or mmp gpio series.
       5. Use linux/io.h instead of asm/io.h.
