From: david@lechnology.com (David Lechner)
Date: Thu, 11 Jan 2018 20:29:49 -0600
Subject: [PATCH v2 0/2] Add reboot modes for LEGO MINDSTORMS EV3
Message-ID: <1515724191-30499-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds a new device tree node to declare a special memory
address that is used by the I2C bootloader on LEGO MINDSTORMS EV3
to boot into a special firmware update mode and enables the required
module to use it.

v2 changes:
* rebase on linux-davinci/master

David Lechner (2):
  ARM: dts: da850-lego-ev3: Add node for reboot modes
  ARM: davinci_all_defconfig: enable SYSCON_REBOOT_MODE

 arch/arm/boot/dts/da850-lego-ev3.dts   | 17 +++++++++++++++++
 arch/arm/configs/davinci_all_defconfig |  1 +
 2 files changed, 18 insertions(+)

-- 
2.7.4
