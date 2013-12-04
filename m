From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 04 Dec 2013 17:20:11 +0800
Subject: [GIT PULL][v2] pull request for hisilicon soc
Message-ID: <529EF3CB.5040505@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Please help to merge this pull request.

I have to use gmail address since my GPG key is based on gmail.com.

Best Regards
Haojian

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/hzhuang1/linux.git 
tags/hisilicon-basic

for you to fetch changes up to 10d3095df4393ba3531508691b133a4f69adbd5e:

   ARM: hi3xxx: add hotplug support (2013-11-25 15:10:01 +0800)

----------------------------------------------------------------
enable hisilicon soc

----------------------------------------------------------------
Haojian Zhuang (4):
       ARM: hi3xxx: add board support with device tree
       ARM: dts: enable hi4511 with device tree
       ARM: config: enable hi3xxx in multi_v7_defconfig
       ARM: config: add defconfig for Hi3xxx

Zhangfei Gao (2):
       ARM: hi3xxx: add smp support
       ARM: hi3xxx: add hotplug support

  Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt |  32 ++++
  arch/arm/Kconfig                                              |   2 +
  arch/arm/Makefile                                             |   1 +
  arch/arm/boot/dts/Makefile                                    |   1 +
  arch/arm/boot/dts/hi3620.dtsi                                 | 556 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  arch/arm/boot/dts/hi4511.dts                                  | 648 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  arch/arm/configs/hi3xxx_defconfig                             |  56 
+++++++
  arch/arm/configs/multi_v7_defconfig                           |   1 +
  arch/arm/mach-hi3xxx/Kconfig                                  |  16 ++
  arch/arm/mach-hi3xxx/Makefile                                 |   7 +
  arch/arm/mach-hi3xxx/core.h                                   |  15 ++
  arch/arm/mach-hi3xxx/hi3xxx.c                                 |  97 
++++++++++++
  arch/arm/mach-hi3xxx/hotplug.c                                | 200 
+++++++++++++++++++++++++
  arch/arm/mach-hi3xxx/platsmp.c                                |  89 
+++++++++++
  14 files changed, 1721 insertions(+)
  create mode 100644 
Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
  create mode 100644 arch/arm/boot/dts/hi3620.dtsi
  create mode 100644 arch/arm/boot/dts/hi4511.dts
  create mode 100644 arch/arm/configs/hi3xxx_defconfig
  create mode 100644 arch/arm/mach-hi3xxx/Kconfig
  create mode 100644 arch/arm/mach-hi3xxx/Makefile
  create mode 100644 arch/arm/mach-hi3xxx/core.h
  create mode 100644 arch/arm/mach-hi3xxx/hi3xxx.c
  create mode 100644 arch/arm/mach-hi3xxx/hotplug.c
  create mode 100644 arch/arm/mach-hi3xxx/platsmp.c
