From: david@lechnology.com (David Lechner)
Date: Thu, 31 May 2018 15:25:47 -0500
Subject: [PATCH 0/2] ARM: LEGO MINDSTORMS EV3 Bluetooth support
Message-ID: <20180531202549.11255-1-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds Bluetooth support to LEGO MINDSTORMS EV3.

The pwm-clock depends on the common clock framework, so this requires the
recent davinci common clock series to switch to the common clock framework
before it will actually work.

David Lechner (2):
  ARM: dts: da850-lego-ev3: Add Bluetooth nodes
  ARM: davinci_all_defconfig: Enable Bluetooth

 arch/arm/boot/dts/da850-lego-ev3.dts   | 82 ++++++++++++++++++++++++++
 arch/arm/configs/davinci_all_defconfig |  9 +++
 2 files changed, 91 insertions(+)

-- 
2.17.0
