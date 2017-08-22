From: stefan@olimex.com (Stefan Mavrodiev)
Date: Tue, 22 Aug 2017 14:43:10 +0300
Subject: [PATCH 0/3] Update board support for OLinuXino boards
Message-ID: <20170822114313.9038-1-stefan@olimex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based of increased number of boards with their shipping options,
there is new board naming convention.

Along with that, A20-OLinuXino-MICRO has new revision(rev.J),
which introduce new PHY chip (LAN8710) and eMMC option. The new
dts file is based on the already existing one for lime2-emmc.

Stefan Mavrodiev (3):
  ARM: dts: sun7i: Fix A20-OLinuXino-MICRO dts for use with LAN8710
  ARM: dts: sun7i: Add dts file for A20-OLinuXino-MICRO-exGB
  ARM: dts: sun7i: Rename sun7i-a20-olinuxino-lime2-emmc

 arch/arm/boot/dts/Makefile                         |  3 +-
 ...emmc.dts => sun7i-a20-olinuxino-lime2-exgb.dts} |  4 +-
 .../boot/dts/sun7i-a20-olinuxino-micro-exgb.dts    | 81 ++++++++++++++++++++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts    |  7 +-
 4 files changed, 91 insertions(+), 4 deletions(-)
 rename arch/arm/boot/dts/{sun7i-a20-olinuxino-lime2-emmc.dts => sun7i-a20-olinuxino-lime2-exgb.dts} (96%)
 create mode 100644 arch/arm/boot/dts/sun7i-a20-olinuxino-micro-exgb.dts

-- 
2.11.0
