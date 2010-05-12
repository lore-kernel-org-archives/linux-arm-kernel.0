From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 12 May 2010 09:52:02 +0100
Subject: current next-samsung
Message-ID: <20100512085202.GG26401@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current contents of next-samsung:

Arnaud Patard (3):
      ARM: h1940: fix touchscreen support
      ARM: S3C24XX: fix s3c2410fb platdata passing
      ARM: S3C24XX: s3c24xx_mci_set_platdata should be marked __init

Ben Dooks (44):
      ARM: S3C24XX: Add initial s3c_gpio configuration code
      ARM: S3C24XX: Add the gpio pull configuration for pull-up
      ARM: S3C24XX: Add extended GPIO used on S3C2443 and beyond
      ARM: H1940: Change h1940-bluetooth to use gpiolib API
      ARM: JIVE: Update mach-jive to use gpiolib API
      ARM: H1940: Change mach-h1940 to use gpiolib API
      ARM: QT2410: Update mach-qt2410 to use gpiolib API
      ARM: n30: Update mach-n30 to use gpiolib API
      ARM: BAST: Update mach-bast to use gpiolib API
      ARM: VR1000: Update mach-vr1000.c to use gpiolib API
      ARM: S3C2410: Change s3c2410_gpio_pullupl(x, 1) to use s3c_gpio_cfgpull()
      ARM: S3C24XX: Change s3c2410_gpio_pullupl(x, 1) to use s3c_gpio_cfgpull()
      ARM: S3C24XX: Drop s3c2410 specific s3c2410_gpio_cfgpin()
      ARM: S3C24XX: Remove s3c2410_gpio_setcfg()
      ARM: S3C24XX: Remove s3c2410_gpio_getpull()
      ARM: S3C24XX: Remove s3c2410_gpio_getirq()
      ARM: SAMSUNG: Add GPIO configuration read calls
      ARM: S3C24XX: Remove s3c2410_gpio_getcfg(), implement s3c_gpio_getcfg()
      ARM: mini2440: Move to using gpiolib API and s3c_gpio functions
      ARM: S3C2410: Remove the users of s3c2410_gpio_pullup()
      ARM: S3C24XX: Wrapper s3c2410_gpio_setpin and s3c2410_gpio_pullup()
      ARM: S3C24XX: Remove S3C2410_GPJ numbering
      ARM: S3C24XX: Remove _INP macros in <mach/regs-gpioj.h>
      ARM: Merge for-2635/s3c24xx-gpio
      ARM: Merge for-2635/s3c64xx-general
      ARM: Merge for-2635/s3c64xx-ts
      ARM: SAMSUNG: Move S3C6400 PLL code to <plat/pll.h> for re-use
      ARM: SAMSUNG: Add s3c_disable_clocks() and tidy init+disable usage
      ARM: S3C24XX: Identify S3C2416 if S3C2412/S3C2413 built in
      ARM: S3C2443: Move parts of the clock code to common clock file
      ARM: S3C2416: Add basic clock support
      ARM: S3C2416: Add support for second HSMMC channel
      ARM: S3C2416: Add support for OHCI on SMDK2416
      ARM: S3C2416: Use s3c2440 style i2c controller
      ARM: S3C2413: Update GPIO pull-up support
      ARM: SAMSUNG: Update S3C2416 entry with S3C2450
      ARM: Merge $1
      ARM: Merge $1
      ARM: Merge $1
      ARM: Merge for-2635/rx1950
      ARM: SAMSUNG: Remove old email address for ben-linux at fluff.org
      ARM: Merge for-2635/s3c24xx-general
      ARM: Merge for-2635/s5p-general
      ARM: Merge for-2635/samsung-hwmon

Jassi Brar (1):
      ARM: S3C6410: Declare IISv4 audio-bus clock

Jongpill Lee (3):
      ARM: S5P6440: Bug fix on PWM Timer
      ARM: S5P6442: Bug fix on PWM Timer
      ARM: S5PV210: Bug fix on PWM Timer

Kukjin Kim (1):
      ARM: SAMSUNG: Remove static of S5P SoCs sysclass

Mark Brown (1):
      ARM: SMDK6410: Register AC97 controller

Maurus Cuelenaere (3):
      ARM: SAMSUNG: Move mach/ts.h to plat/ts.h
      ARM: S3C64XX: Add touchscreen platform device definition
      ARM: SAMSUNG: Move HWMON from plat-s3c24xx to plat-samsung

Thomas Abraham (1):
      ARM: S5P: Add USB External Crystal clock definition

Vasily Khoruzhick (4):
      ARM: S3C2440: Add HP iPAQ RX1950 machine support
      ARM: S3C24XX: Locate kernel at 0x30108000 if PM_H1940 is enabled
      ARM: RX1950: Add suspend/resume support for RX1950
      ARM: RX1950: configure GPG13-15 as input before suspend

Yauhen Kharuzhy (5):
      ARM: S3C: Add S3C2416 detection to uncompress code
      serial: Use s3c2440 driver for S3C2416 SoC
      ARM: S3C2416: Add S3C2416-specific registers definitions
      ARM: S3C2416: Add arch support
      ARM: S3C2416: Add initial support of SMDK2416


-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
