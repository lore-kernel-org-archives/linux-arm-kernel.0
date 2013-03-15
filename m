From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 15 Mar 2013 16:22:30 +0800
Subject: [GIT PULL][for 3.10] pull request from hi3xxx branch in pxa git tree
Message-ID: <CAN1soZwU34C8K1eShDU4hY5-39AWEg2Sb=mBopMHX9+zg6KVqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd & Olof,

Please help to pull armsoc/hi3xxx branch from pxa git tree. Since
these patches are
relied on Rob's sp804 implementation. I submitted all of them into my
git tree too.

Best Regards
Haojian

The following changes since commit 1fba3b8045179da806d6b647b811e8441d5e31f1:

  ARM: versatile: enable DT based timer init (2013-03-13 21:33:05 -0500)

are available in the git repository at:

  git://github.com/hzhuang1/linux.git armsoc/hi3xxx

for you to fetch changes up to 91cebb3009587c1f3e6a50e6ec0793c64db47615:

  ARM: config: append arch hi3xxx into multi defconfig (2013-03-15
16:05:39 +0800)

----------------------------------------------------------------
Haojian Zhuang (5):
      ARM: debug: support debug ll on hisilicon soc
      clk: hi3xxx: add clock support
      ARM: hi3xxx: add board support with device tree
      ARM: hi3xxx: enable hi4511 with device tree
      ARM: config: append arch hi3xxx into multi defconfig

 Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt |   10 +
 Documentation/devicetree/bindings/clock/hisilicon.txt         |   73 +++++
 arch/arm/Kconfig                                              |    2 +
 arch/arm/Kconfig.debug                                        |   15 ++
 arch/arm/Makefile                                             |    1 +
 arch/arm/boot/dts/Makefile                                    |    1 +
 arch/arm/boot/dts/hi3620.dtsi                                 | 1155
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/hi4511.dts                                  |  738
++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/configs/multi_v7_defconfig                           |    1 +
 arch/arm/include/debug/hisilicon.S                            |   30 +++
 arch/arm/mach-hi3xxx/Kconfig                                  |   13 +
 arch/arm/mach-hi3xxx/Makefile                                 |    5 +
 arch/arm/mach-hi3xxx/hi3xxx.c                                 |   45 ++++
 drivers/clk/Makefile                                          |    1 +
 drivers/clk/clk-hi3xxx.c                                      |  643
++++++++++++++++++++++++++++++++++++++++++++
 15 files changed, 2733 insertions(+)
 create mode 100644
Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
 create mode 100644 Documentation/devicetree/bindings/clock/hisilicon.txt
 create mode 100644 arch/arm/boot/dts/hi3620.dtsi
 create mode 100644 arch/arm/boot/dts/hi4511.dts
 create mode 100644 arch/arm/include/debug/hisilicon.S
 create mode 100644 arch/arm/mach-hi3xxx/Kconfig
 create mode 100644 arch/arm/mach-hi3xxx/Makefile
 create mode 100644 arch/arm/mach-hi3xxx/hi3xxx.c
 create mode 100644 drivers/clk/clk-hi3xxx.c
