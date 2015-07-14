From: rogershimizu@gmail.com (Roger Shimizu)
Date: Tue, 14 Jul 2015 22:00:00 +0900
Subject: [PATCH 0/2] ARM: DTS support for Linkstation LS-WTGL (orion5x)
Message-ID: <1436878802-25712-1-git-send-email-rogershimizu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Orion5x Maintainer,

I'd like to add DTS support for a bit older linkstation orion5x device, LS-WTGL.
I have tested againt latest kernel next/dt branch on my box and it works fine.
Please consider to merge. Thank you!

Cheers,
Roger

Roger Shimizu (2):
  ARM: dts: add buffalo linkstation ls-wtgl
  ARM: defconfig: add DT support for orion5x_defconfig

 arch/arm/boot/dts/Makefile                       |   1 +
 arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts | 242 +++++++++++++++++++++++
 arch/arm/configs/orion5x_defconfig               |   4 +
 3 files changed, 247 insertions(+)
 create mode 100644 arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts

-- 
1.9.1
