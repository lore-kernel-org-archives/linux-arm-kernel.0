From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri,  5 Sep 2014 14:44:35 -0700
Subject: [GIT PULL 3.18] ARM: BCM: Broadcom BCM63138 support
Message-ID: <1409953475-23130-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

This pull request contains the basic Broadcom BCM63138 DSL SoC support
that has been posted a few weeks ago. Arnd has reviewed those changes, and
I was expecting Matt to carry these changes for me, but I did not get an
answer so far and I don't want these patches to be held much longer.

Thanks!

The following changes since commit 244a68e90d0775d3e579020768ef3d5409473adc:

  Merge fixes branch into for-next (2014-09-05 22:56:46 +0200)

are available in the git repository at:


  https://github.com/brcm/linux.git bcm63138-v3

for you to fetch changes up to ad672f6d6aaf748488ee6a759c23d4f8528f1b6c:

  MAINTAINERS: add entry for the Broadcom BCM63xx ARM SoCs (2014-09-05 14:30:56 -0700)

----------------------------------------------------------------
Florian Fainelli (5):
      ARM: BCM63XX: add basic support for the Broadcom BCM63138 DSL SoC
      ARM: BCM63XX: add low-level UART debug support
      ARM: BCM63XX: add BCM63138 minimal Device Tree
      ARM: BCM63XX: add BCM963138DVT Reference platform DTS
      MAINTAINERS: add entry for the Broadcom BCM63xx ARM SoCs

 .../devicetree/bindings/arm/bcm/bcm63138.txt       |   9 ++
 MAINTAINERS                                        |   8 ++
 arch/arm/Kconfig.debug                             |  18 ++-
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/bcm63138.dtsi                    | 134 +++++++++++++++++++++
 arch/arm/boot/dts/bcm963138dvt.dts                 |  30 +++++
 arch/arm/include/debug/bcm63xx.S                   |  33 +++++
 arch/arm/mach-bcm/Kconfig                          |  17 +++
 arch/arm/mach-bcm/Makefile                         |   3 +
 arch/arm/mach-bcm/bcm63xx.c                        |  27 +++++
 10 files changed, 278 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/bcm63138.txt
 create mode 100644 arch/arm/boot/dts/bcm63138.dtsi
 create mode 100644 arch/arm/boot/dts/bcm963138dvt.dts
 create mode 100644 arch/arm/include/debug/bcm63xx.S
 create mode 100644 arch/arm/mach-bcm/bcm63xx.c
