From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 20 May 2010 08:13:00 +0200
Subject: [PATCH v3] Add support for Samsung Aquila board (S5PC110 based)
Message-ID: <1274335987-1141-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series add basic support for Samsung Aquila board. The board
is based on Samsung S5PC110 SoC. This patch series also add platform
device helpers for i2c, fb and hsmmc drivers.

Changes since v2:
- rebased onto git://git.fluff.org/bjdooks/linux for-linus/samsung4
- added missing changes to mach-s5pv210/setup-i2c0.c

Changes since v1:
- removed custom gpiolib implementation in favour of the GPIOlib patch
  provided by Pannaga Bhushan,
- adjusted hsmmc setup code for 'sclk_mmc' clock names

This patch series includes:

[PATCH 1/7] ARM: S5PV210: add support for software reset
[PATCH 2/7] ARM: S5PV210: add Aquila board
[PATCH 3/7] ARM: Samsung: move common framebuffer regs to common platform directory
[PATCH 4/7] ARM: S5PV210: add framebuffer platform helpers for s5pv210 based machines
[PATCH 5/7] ARM: S5PV210: add support for s3c-fb driver on Aquila machine
[PATCH 6/7] ARM: S5PV210: add common I2C device helpers
[PATCH 7/7] ARM: S5PV210: add common HSMMC device helpers

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
