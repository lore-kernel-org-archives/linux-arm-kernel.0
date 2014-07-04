From: xuwei5@hisilicon.com (xuwei)
Date: Fri, 4 Jul 2014 15:15:47 +0800
Subject: [GIT PULL][for 3.17] pull request for hisilicon soc
Message-ID: <53B654A3.5020603@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please help to merge pull request for hisilicon soc. 

Best Regards,
Wei


The following changes since commit f753b5db43e3819e02354a638ea31e332e08ac3a:

  ARM: hisi: store reboot reg in global variable (2014-07-03 19:29:15 +0800)

are available in the git repository at:

  git://github.com/hisilicon/linux-hisi.git tags/hix5hd2-for-3.17

for you to fetch changes up to 5354cf5f6026b5d16caf0001886c06ab9ca42dff:

  ARM: hisi: enable L2 driver (2014-07-04 14:07:17 +0800)

----------------------------------------------------------------
enable hisilicon terminal SoC based on 3.16-rc1

----------------------------------------------------------------
Haifeng Yan (3):
      ARM: debug: Rename Hi3716 to HI5XHD2
      ARM: hisi: enable hix5hd2 SoC
      ARM: dts: Add hix5hd2-dkb dts file.

Haojian Zhuang (4):
      ARM: debug: add HiP04 debug uart
      ARM: hisi: add ARCH_HISI
      ARM: config: add ARCH_HIX5HD2 in hi3xxx_defconfig
      ARM: hisi: enable L2 driver

 arch/arm/Kconfig.debug            |  22 +++++++++++++-----
 arch/arm/Makefile                 |   2 +-
 arch/arm/boot/dts/Makefile        |   1 +
 arch/arm/boot/dts/hix5hd2-dkb.dts |  52 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/hix5hd2.dtsi    | 171 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/configs/hi3xxx_defconfig |   2 ++
 arch/arm/mach-hisi/Kconfig        |  27 +++++++++++++++++++---
 arch/arm/mach-hisi/Makefile       |   2 +-
 arch/arm/mach-hisi/core.h         |   5 ++++
 arch/arm/mach-hisi/headsmp.S      |  16 +++++++++++++
 arch/arm/mach-hisi/hisilicon.c    |  20 ++++++++++++++++
 arch/arm/mach-hisi/hotplug.c      |  58 ++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-hisi/platsmp.c      |  50 +++++++++++++++++++++++++++++++++++++---
 13 files changed, 414 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm/boot/dts/hix5hd2-dkb.dts
 create mode 100644 arch/arm/boot/dts/hix5hd2.dtsi
 create mode 100644 arch/arm/mach-hisi/headsmp.S
