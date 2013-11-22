From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 22 Nov 2013 16:22:37 +0000
Subject: [PATCH 00/23] mtd: st_spi_fsm: Add new device
Message-ID: <1385137380-28968-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first bunch of these patches have been on the MLs before, but 
didn't receive a great deal of attention for the most part. We are
a little more featureful this time however. We can now successfully
setup and configure the N25Q256. We still can't read/write/erase
it though. I'll start work on that next week and will provide it in
the next instalment.

 arch/arm/boot/dts/stih416-b2105.dts     |  14 +++
 arch/arm/boot/dts/stih416-pinctrl.dtsi  |  12 ++
 drivers/mtd/devices/Kconfig             |   7 ++
 drivers/mtd/devices/Makefile            |   1 +
 drivers/mtd/devices/serial_flash_cmds.h |  91 ++++++++++++++
 drivers/mtd/devices/st_spi_fsm.c        | 737 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mtd/devices/st_spi_fsm.h        | 419 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 1281 insertions(+)
