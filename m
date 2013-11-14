From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 14 Nov 2013 14:22:26 +0000
Subject: [PATCH 00/10] mtd: st_spi_fsm: Add new device
Message-ID: <1384438956-31153-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

First stab at getting this thing Mainlined. It doesn't do a great deal
yet, but we are able to initialise the device and dynamically set it up
correctly based on an extracted JEDEC ID.

 arch/arm/boot/dts/stih416-b2105.dts    |  10 ++
 arch/arm/boot/dts/stih416-pinctrl.dtsi |  12 +++
 drivers/mtd/devices/Kconfig            |   7 ++
 drivers/mtd/devices/Makefile           |   1 +
 drivers/mtd/devices/st_spi_fsm.c       | 605 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mtd/devices/st_spi_fsm.h       | 187 ++++++++++++++++++++++++++++++++
 6 files changed, 822 insertions(+)
