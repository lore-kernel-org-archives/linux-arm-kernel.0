From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 30 Sep 2011 18:19:15 +0800
Subject: [PATCH v2 0/5] ARM: pxa: move gpio driver into drivers directory
Message-ID: <1317377960-11063-1-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog:
v2:
	1. Remove gpio.c from mach-pxa & mach-mmp that is introduced from v1.
	2. Remove init function in gpio.c. Move the platfrom_device_register()
	   into platform driver.
	3. Initialize pxa_gpio_regs in gpio-pxa.c
	4. Simplify code of identifing pxa gpio series or mmp gpio series.
	5. Use linux/io.h instead of asm/io.h.
