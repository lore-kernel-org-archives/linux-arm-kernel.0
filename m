From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri,  9 Jan 2015 16:32:41 +0100
Subject: [PATCH 0/4] Add a new RTC driver for recent mvebu SoCs
Message-ID: <1420817565-28800-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The Marvell Armada 38x SoCs contains an RTC which differs from the RTC
used in the other mvebu SoCs until now. This patch set adds support
for this new IP and enable it in the Device Tree of the Armada 38x
SoC.

Thanks,

Gr??gory

Gregory CLEMENT (4):
  rtc: armada38x: Add the device tree binding documentation
  drivers/rtc/rtc-armada38x: Add a new RTC driver for recent mvebu SoCs
  MAINTAINERS: Add the RTC driver for the Armada38x
  ARM: mvebu: add Device Tree description of RTC on Armada 38x

 .../devicetree/bindings/rtc/armada-380-rtc.txt     |  17 ++
 MAINTAINERS                                        |   1 +
 arch/arm/boot/dts/armada-38x.dtsi                  |   6 +
 drivers/rtc/Kconfig                                |  10 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-armada38x.c                        | 305 +++++++++++++++++++++
 6 files changed, 340 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/armada-380-rtc.txt
 create mode 100644 drivers/rtc/rtc-armada38x.c

-- 
1.9.1
