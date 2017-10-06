From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri,  6 Oct 2017 15:20:14 -0700
Subject: [GIT PULL 1/1] Broadcom devicetree fixes for 4.14
Message-ID: <20171006222014.2704-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.14/devicetree-fixes

for you to fetch changes up to 80a86dbd98497ea7ccf77a82458baf0779de87d6:

  Merge tag 'bcm2835-dt-fixes-2017-10-06' into devicetree/fixes (2017-10-06 15:11:23 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based SoC Device Tree fixes for 4.14,
please pull the following:

- Loic fixes the console path on the Raspberry Pi 3 which was not correctly set
  and would cause all sorts of confusion between the Bluetooth controller and the
  kernel console

----------------------------------------------------------------
Florian Fainelli (1):
      Merge tag 'bcm2835-dt-fixes-2017-10-06' into devicetree/fixes

Loic Poulain (1):
      ARM: dts: bcm283x: Fix console path on RPi3

 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts | 9 +++------
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts    | 5 +++++
 arch/arm/boot/dts/bcm283x.dtsi           | 7 ++++++-
 3 files changed, 14 insertions(+), 7 deletions(-)
