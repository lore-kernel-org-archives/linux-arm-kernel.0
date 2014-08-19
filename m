From: wills.wang.open@gmail.com (Wills Wang)
Date: Tue, 19 Aug 2014 15:32:59 +0800
Subject: [PATH v6 0/2] ARM: dts: sun7i: Add Merrii A20 Hummingbird support
Message-ID: <1408433581-14417-1-git-send-email-wills.wang.open@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v5:
  - add generic pinmux spi2_pins_b
  - remove redundant newline

Changes since v4:
  - move generic pinmux into a20 dtsi
  - add the board name as suffix

Changes since v3:
  - adjust dtb file in alphabetic order

Changes since v2:
  - fixed mistake about uart3/4/5 pinctrl config

Changes since v1:
  - add Signed-off-by and commit msg      
  - add uart2/3/4/5, i2c3 and spi2
  - remove pwm1 node
  - use reg_vcc3v0 according to board schematic
  - add comment for gpio pin
  - remove unused pull-up pin setting

Wills Wang (2):
  ARM: dts: sun7i: Add uart3/4/5, i2c3 and spi2 pinmux
  ARM: dts: sun7i: Add Merrii A20 Hummingbird board

 arch/arm/boot/dts/Makefile                  |   1 +
 arch/arm/boot/dts/sun7i-a20-hummingbird.dts | 236 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi            |  35 +++++
 3 files changed, 272 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun7i-a20-hummingbird.dts

-- 
1.8.3.2
