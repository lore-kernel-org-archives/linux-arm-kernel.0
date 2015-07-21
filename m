From: rogershimizu@gmail.com (Roger Shimizu)
Date: Tue, 21 Jul 2015 23:49:15 +0900
Subject: [PATCH v2 0/2] ARM: orion5x: DTS support for Linkstation LS-WTGL
Message-ID: <1437490157-8194-1-git-send-email-rogershimizu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Orion5x Maintainer,

I'd like to add DTS support for a bit older linkstation orion5x device, LS-WTGL.
I have tested againt latest kernel next/dt branch on my box and it works fine.
Please consider to merge. Thank you!

Changelog(v2):
- remove commented lines in DTS
- use GPL/X11 dual license
- some changes in orion5x_defconfig

Cheers,
Roger

Roger Shimizu (2):
  ARM: dts: orion5x: add buffalo linkstation ls-wtgl
  ARM: defconfig: orion5x: add DT support

 arch/arm/boot/dts/Makefile                       |   1 +
 arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts | 273 +++++++++++++++++++++++
 arch/arm/configs/orion5x_defconfig               |   3 +
 3 files changed, 277 insertions(+)
 create mode 100644 arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts

-- 
1.9.1
