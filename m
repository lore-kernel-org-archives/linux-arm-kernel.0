From: o.schinagl@ultimaker.com (Olliver Schinagl)
Date: Thu, 10 Sep 2015 10:31:16 +0200
Subject: [PATCH v2 0/5] Add eeprom to the Olimex series of boards
Message-ID: <1441873881-3665-1-git-send-email-o.schinagl@ultimaker.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some of the olimex series of boards feature a permanently connected eeprom on
i2c-1. This patch series adds them on all the boards that I personally have and
where tested with.

Additionally, it brings the eeprom on the OLinuXino a10s in line with the rest
and now follows the binding documentation.

Changes since v1:
* Fixed SoB and removed Tested-by as that is implied with SoB.
* Additionally tested it on an A20 OLinuXino micro as I did actually have one!

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>

Olliver Schinagl (5):
  dts: sunxi: add eeprom to A10 OLinuXino Lime board
  dts: sunxi: correct vendor prefix on OLinuXino a10s micro
  dts: sunxi: add eeprom to A20 OLinuXino Lime board
  dts: sunxi: add eeprom to A20 OLinuXino Lime2 board
  dts: sunxi: add eeprom to A20 OLinuXino micro board

 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts   | 12 ++++++++++++
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts |  2 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts   | 12 ++++++++++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts  |  6 ++++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts  |  6 ++++++
 5 files changed, 37 insertions(+), 1 deletion(-)

-- 
2.1.4
