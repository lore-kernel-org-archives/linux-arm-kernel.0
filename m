From: david@lechnology.com (David Lechner)
Date: Tue,  7 Feb 2017 13:22:06 -0600
Subject: [PATCH 0/3] A/C and Sound device tree nodes for LEGO MINDSTORMS EV3
Message-ID: <1486495329-2789-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds device tree nodes for an analog/digital convert and for sound
on LEGO MINDSTORMS EV3. The device tree bindings for these nodes have been acked
and the drivers used by these nodes have been in linux-next for a couple weeks
now and as far as I know, will be included in mainline v4.11.

This series has been tested on LEGO MINDSTORMS EV3 using next-20170207 merged
with linux-davinci/master.


David Lechner (3):
  ARM: da850-lego-ev3: Add device tree node for A/DC
  ARM: davinci_all_defconfig: Enable TI ADS7950
  ARM: da850-lego-ev3: Add device tree node for sound

 arch/arm/boot/dts/da850-lego-ev3.dts   | 52 ++++++++++++++++++++++++++++++++++
 arch/arm/configs/davinci_all_defconfig |  4 +--
 2 files changed, 53 insertions(+), 3 deletions(-)

-- 
2.7.4
