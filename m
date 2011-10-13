From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Thu, 13 Oct 2011 12:06:57 +0800
Subject: [PATCH v4 0/8] Clean gpio in arch-pxa and arch-mmp
Message-ID: <1318478825-17187-1-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog
v4:
       1. append one patch for clean gpio macros and use function instead.
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
