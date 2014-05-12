From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 12 May 2014 09:30:31 +0800
Subject: [PATCH 0/5] enable HiX5HD2 SoC
Message-ID: <1399858236-29027-1-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Haifeng Yan (4):
  ARM: debug: Rename Hi3716 to HI5XHD2
  ARM: hisi: enable hix5hd2 SoC
  ARM: hisi: Add hix5hd2 SoC support.
  ARM: dts: Add hix5hd2-dkb dts file.

Haojian Zhuang (1):
  ARM: config: add ARCH_HIX5HD2 in hi3xxx_defconfig

 arch/arm/Kconfig.debug            |  20 ++--
 arch/arm/boot/dts/Makefile        |   1 +
 arch/arm/boot/dts/hix5hd2-dkb.dts |  56 +++++++++++
 arch/arm/boot/dts/hix5hd2.dtsi    | 189 ++++++++++++++++++++++++++++++++++++++
 arch/arm/configs/hi3xxx_defconfig |   1 +
 arch/arm/mach-hisi/Kconfig        |  13 ++-
 arch/arm/mach-hisi/Makefile       |   1 +
 arch/arm/mach-hisi/core.h         |   3 +
 arch/arm/mach-hisi/headsmp.S      |  39 ++++++++
 arch/arm/mach-hisi/hisilicon.c    |  31 +++++++
 arch/arm/mach-hisi/hotplug.c      |  36 ++++++++
 arch/arm/mach-hisi/platsmp.c      |  70 +++++++++++++-
 12 files changed, 445 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm/boot/dts/hix5hd2-dkb.dts
 create mode 100644 arch/arm/boot/dts/hix5hd2.dtsi
 create mode 100644 arch/arm/mach-hisi/headsmp.S

-- 
1.9.1
