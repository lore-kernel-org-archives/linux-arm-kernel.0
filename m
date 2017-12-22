From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 21 Dec 2017 16:12:26 -0800
Subject: [GIT PULL 1/2] Broadcom devicetree changes for 4.16
Message-ID: <20171222001227.30625-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.16/devicetree

for you to fetch changes up to ececb5639c33a6a0444bd8e1cda8bf2ef20c6a6b:

  Merge tag 'bcm2835-dt-next-2017-12-19' into devicetree/next (2017-12-20 17:32:58 -0800)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based SoCs Device Tree changes for
4.16, please pull the following:

- Stefan updates the BCM283x DTS to make consistent use of the existing GPIO
  defines for the polarity specifier

----------------------------------------------------------------
Florian Fainelli (1):
      Merge tag 'bcm2835-dt-next-2017-12-19' into devicetree/next

Stefan Wahren (1):
      ARM: dts: bcm283x: Use GPIO polarity defines consistently

 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts | 4 ++--
 arch/arm/boot/dts/bcm2835-rpi-a.dts      | 2 +-
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts | 4 ++--
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts | 2 +-
 arch/arm/boot/dts/bcm2835-rpi-b.dts      | 2 +-
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts    | 4 ++--
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts    | 2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)
