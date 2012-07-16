From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 16 Jul 2012 11:16:44 +0200
Subject: [PATCHv3]   I2C: MV64XXX: Add Device Tree support
Message-ID: <1342430205-13702-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is one patch out of a larger patchset adding DT support to a
number of Orion drivers. All the other patches have been acked-by,
etc, so i'm only re-posting the one which has been modified.

The I2C driver now uses the clock-frequency property.

Andrew Lunn (1):
  I2C: MV64XXX: Add Device Tree support

 Documentation/devicetree/bindings/i2c/mrvl-i2c.txt |   21 +++-
 arch/arm/boot/dts/kirkwood.dtsi                    |   11 ++
 arch/arm/mach-kirkwood/board-dt.c                  |    2 +
 arch/arm/mach-kirkwood/common.c                    |    2 +
 arch/arm/plat-orion/common.c                       |    1 +
 drivers/i2c/busses/i2c-mv64xxx.c                   |  107 +++++++++++++++++++-
 6 files changed, 138 insertions(+), 6 deletions(-)

-- 
1.7.10
