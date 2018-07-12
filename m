From: luaraneda@gmail.com (Luis Araneda)
Date: Thu, 12 Jul 2018 01:50:45 -0400
Subject: [PATCH 0/3] arm: dts: zynq: Improvements to Zybo z7 board
Message-ID: <20180712055049.5098-1-luaraneda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset corrects and improves the device-tree
of the Zybo Z7 board

The first patch correct the RAM size
( supersedes https://lkml.org/lkml/2018/6/26/965 )

The second patch introduce the use of GPIO constants
to replace a literal

Finally, the third patch adds a gpio-leds node with
one LED

Luis Araneda (3):
  arm: dts: zynq: Fix memory size on the Zybo Z7 board
  arm: dts: zynq: Use gpio constants for the Zybo Z7 board
  arm: dts: zynq: Add LEDs to the Zybo Z7 board

 arch/arm/boot/dts/zynq-zybo-z7.dts | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

-- 
2.18.0
