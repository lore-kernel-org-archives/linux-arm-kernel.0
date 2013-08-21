From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 21 Aug 2013 16:25:37 +0800
Subject: [GIT PULL v2] pull request to 3.12 for hi3xxx
Message-ID: <CAN1soZz6WWDVwTE5eFOXuQHAPoOGajHaNhFzJBLZh5Gwj_u9ZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 21, 2013 at 5:52 AM, Kevin Hilman <khilman@linaro.org> wrote:
> Hello Haojian,
>
> Haojian Zhuang <haojian.zhuang@gmail.com> writes:
>
>> Hi all,
>>
>> Please help to merge hi3xxx from pxa git tree.
>>
>
> Thanks for sending the pull request to to arm at kernel.org, but please be
> sure to *also* send it to the linux-arm-kernel mailing list.
>
> Thanks,
>
> Kevin
>

Hi Kevin,

Now I update this pull request since I drop the support of Hi3716 DKB.

Regards
Haojian

The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:

  Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hzhuang1/linux.git tags/hi3xxx

for you to fetch changes up to 16817f182c15ee140650fccb1241c1c794ff201a:

  ARM: hi3xxx: add hotplug support (2013-08-20 11:10:54 +0800)

----------------------------------------------------------------
support hi3xxx SoC

----------------------------------------------------------------
Haojian Zhuang (4):
      ARM: hi3xxx: add board support with device tree
      ARM: dts: enable hi4511 with device tree
      ARM: config: enable hi3xxx in multi_v7_defconfig
      ARM: config: add defconfig for Hi3xxx

Zhangfei Gao (2):
      ARM: hi3xxx: add smp support
      ARM: hi3xxx: add hotplug support

 Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt |   57 +++
 arch/arm/Kconfig                                              |    2 +
 arch/arm/Makefile                                             |    1 +
 arch/arm/boot/dts/Makefile                                    |    1 +
 arch/arm/boot/dts/hi3620.dtsi                                 | 1671
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/hi4511.dts                                  |  648
+++++++++++++++++++++++++++++++
 arch/arm/configs/hi3xxx_defconfig                             |   56 +++
 arch/arm/configs/multi_v7_defconfig                           |    1 +
 arch/arm/mach-hi3xxx/Kconfig                                  |   14 +
 arch/arm/mach-hi3xxx/Makefile                                 |    7 +
 arch/arm/mach-hi3xxx/core.h                                   |   19 +
 arch/arm/mach-hi3xxx/hi3xxx.c                                 |   42 ++
 arch/arm/mach-hi3xxx/hotplug.c                                |  154 ++++++++
 arch/arm/mach-hi3xxx/platsmp.c                                |   48 +++
 arch/arm/mach-hi3xxx/system.c                                 |   64 +++
 15 files changed, 2785 insertions(+)
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
 create mode 100644 arch/arm/mach-hi3xxx/system.c
