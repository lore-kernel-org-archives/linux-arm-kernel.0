From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 16 Jul 2010 17:58:26 +0900
Subject: [PATCH v2 0/8] ARM: S5PV310: Add support for Samsung S5PV310 SoC
Message-ID: <1279270714-15146-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds support for Samsung S5PV310/S5PC210. The S5PV310
integrates a ARM Cortex A9 microprocessor with several other peripherals
to support features such as multimedia, storage, graphics and gaming.
The S5PV310 can be used in products such as Netbooks and Mobile devices.

Changes since v1:

- Address comments from Rabin Vincent
  : removed unnecessary loking in the irq support functions
  : removed unnecessary debug message in the s5pv310_pwm_init()
  : moved pwm_init() and pwm_start()

- Modified FRACVAL support method in serial/samsung.c
  This can be supported S5PV310 serial with serial/s5pv210.c

- Some coding-style fixes

- Added some comments


This patch set consists of the following patches.

[PATCH v2 1/8] ARM: S5P: Remove fixed uart offset dependent code
[PATCH v2 2/8] ARM: S5PV310: Add new CPU initialization support
[PATCH v2 3/8] ARM: S5PV310: Add Clock and PLL support
[PATCH v2 4/8] ARM: S5PV310: Add IRQ support
[PATCH v2 5/8] ARM: S5PV310: Add Timer support
[PATCH v2 6/8] ARM: S5PV310: Add new Kconfig and Makefiles
[PATCH v2 7/8] ARM: S5PV310: Add Board support file
[PATCH v2 8/8] ARM: S5PV310: Add serial port support
