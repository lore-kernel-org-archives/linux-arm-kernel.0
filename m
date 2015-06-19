From: rogershimizu@gmail.com (Roger Shimizu)
Date: Fri, 19 Jun 2015 20:28:37 +0900
Subject: [PATCH 0/2] ARM: dts: add buffalo linkstation ls-wxl/wsxl & ls-wvl/vl
Message-ID: <1434713319-8691-1-git-send-email-rogershimizu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's the dts-patch support for 2 series of NAS products from Buffalo.

  kirkwood-lswxl.dtsi to support:
    - http://buffalo.jp/product/hdd/network/ls-wxl_r1/
    - http://buffalo.jp/products/catalog/storage/ls-wsxl_r1/

  kirkwood-lswvl.dtsi to support:
    - http://buffalo.jp/product/hdd/network/ls-wvl_r1/
    - http://buffalo.jp/product/hdd/network/ls-vl/

I have tested the patches againt latest next/dt branch (commit: 
1647e3c73ce54fc32536bb3a834eccad39b23572) and found they're booting and working 
fine on the real Buffalo NAS boxes.

These two dts patches are encouraged and reviewed by Iwamatsu-san from Debian 
project. Here I'd like to appreciate his kindness help. 

Since I'm merely a newbie contributor to kernel, if there's any mistake or 
something need to be adjusted, please just let know.

It'd be great if you could consider to merge the patches. Thank you!

Roger Shimizu (2):
  ARM: dts: add buffalo linkstation ls-wxl/wsxl
  ARM: dts: add buffalo linkstation ls-wvl/vl

 .../devicetree/bindings/arm/marvell,kirkwood.txt   |   2 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/kirkwood-lswvl.dts               | 307 ++++++++++++++++++++
 arch/arm/boot/dts/kirkwood-lswxl.dts               | 312 +++++++++++++++++++++
 4 files changed, 623 insertions(+)
 create mode 100644 arch/arm/boot/dts/kirkwood-lswvl.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-lswxl.dts

-- 
1.9.1
