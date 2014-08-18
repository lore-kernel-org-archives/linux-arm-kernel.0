From: wills.wang.open@gmail.com (Wills Wang)
Date: Mon, 18 Aug 2014 14:00:33 +0800
Subject: [linux-sunxi] [PATCH v4 0/1] ARM: dts: sun7i: Add Merrii A20
 Hummingbird support
Message-ID: <1408341634-9952-1-git-send-email-wills.wang.open@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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

Wills Wang (1):
  ARM: dts: sun7i: Add Merrii A20 Hummingbird support

 arch/arm/boot/dts/Makefile                  |   1 +
 arch/arm/boot/dts/sun7i-a20-hummingbird.dts | 264 ++++++++++++++++++++++++++++
 2 files changed, 265 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun7i-a20-hummingbird.dts

-- 
1.8.3.2
