From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 17 May 2010 08:53:08 +0200
Subject: [PATCH v2] Add support for Samsung Aquila board (S5PC110 based)
Message-ID: <1274079195-18105-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series add basic support for Samsung Aquila board. The board
is based on Samsung S5PC110 SoC. This patch series also add platform
device helpers for i2c, fb and hsmmc drivers.

The patches are prepared with assumption that my previous patch series
'Common plat-s5p fixes' has been already applied, as well as the patch
'ARM: S5PV210: Add S5PV210 GPIO support.'

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
