From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 25 Jun 2010 23:27:09 +0900
Subject: [PATCH 0/8] ARM: S5PV310: Add support for Samsung S5PV310 SoC
Message-ID: <1277476037-8806-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds support for Samsung S5PV310/S5PC210. The S5PV310
integrates a ARM Cortex A9 microprocessor with several other peripherals
to support features such as multimedia, storage, graphics and gaming.
The S5PV310 can be used in products such as Netbooks and Mobile devices.

This patch set consists of the following patches.

[PATCH 1/8] ARM: S5P: Remove fixed uart offset dependent code
[PATCH 2/8] ARM: S5PV310: Add new CPU initialization support
[PATCH 3/8] ARM: S5PV310: Add Clock and PLL support
[PATCH 4/8] ARM: S5PV310: Add IRQ support
[PATCH 5/8] ARM: S5PV310: Add Timer support
[PATCH 6/8] ARM: S5PV310: Add new Kconfig and Makefiles
[PATCH 7/8] ARM: S5PV310: Add Board support file
[PATCH 8/8] ARM: S5PV310: Add serial port support
