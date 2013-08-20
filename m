From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 20 Aug 2013 11:50:15 +0800
Subject: [GIT PULL] pull request to 3.12 for hi3xxx
In-Reply-To: <CAN1soZzRmZyC38i8gCJL20ebRZPH0fd+DC7aFqnWbu=NfnYCzg@mail.gmail.com>
References: <CAN1soZzRmZyC38i8gCJL20ebRZPH0fd+DC7aFqnWbu=NfnYCzg@mail.gmail.com>
Message-ID: <CAN1soZwcrsQmaV4vERtpzgQy23yRKFe8Gd4nmob18G+PzPP4Aw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 20, 2013 at 11:44 AM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> Hi all,
>
> Please help to merge hi3xxx from pxa git tree.
>
> Regards
> Haojian
>
>
> The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:
>
>   Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/hzhuang1/linux.git tags/hi3xxx
>
> for you to fetch changes up to a9b42411245867a3730cd15982f79191b70cc8c0:
>
>   ARM: hi3xxx: support hi3716-dkb board (2013-08-20 11:11:23 +0800)
>
> ----------------------------------------------------------------
> enable Hisilicon Hi3xxx
>
> ----------------------------------------------------------------
> Haojian Zhuang (4):
>       ARM: hi3xxx: add board support with device tree
>       ARM: dts: enable hi4511 with device tree
>       ARM: config: enable hi3xxx in multi_v7_defconfig
>       ARM: config: add defconfig for Hi3xxx
>
> Zhangfei Gao (3):
>       ARM: hi3xxx: add smp support
>       ARM: hi3xxx: add hotplug support
>       ARM: hi3xxx: support hi3716-dkb board
>
>  Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt |   57 +++
>  arch/arm/Kconfig                                              |    2 +
>  arch/arm/Makefile                                             |    1 +
>  arch/arm/boot/dts/Makefile                                    |    1 +
>  arch/arm/boot/dts/hi3620.dtsi                                 | 1671
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/hi3716-dkb.dts                              |   37 ++
>  arch/arm/boot/dts/hi3716.dtsi                                 |  275
> +++++++++++++
>  arch/arm/boot/dts/hi4511.dts                                  |  648
> +++++++++++++++++++++++++++++++
>  arch/arm/configs/hi3xxx_defconfig                             |   56 +++
>  arch/arm/configs/multi_v7_defconfig                           |    1 +
>  arch/arm/mach-hi3xxx/Kconfig                                  |   14 +
>  arch/arm/mach-hi3xxx/Makefile                                 |    7 +
>  arch/arm/mach-hi3xxx/core.h                                   |   19 +
>  arch/arm/mach-hi3xxx/hi3xxx.c                                 |   43 +++
>  arch/arm/mach-hi3xxx/hotplug.c                                |  154 ++++++++
>  arch/arm/mach-hi3xxx/platsmp.c                                |   48 +++
>  arch/arm/mach-hi3xxx/system.c                                 |   64 +++
>  17 files changed, 3098 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
>  create mode 100644 arch/arm/boot/dts/hi3620.dtsi
>  create mode 100644 arch/arm/boot/dts/hi3716-dkb.dts
>  create mode 100644 arch/arm/boot/dts/hi3716.dtsi
>  create mode 100644 arch/arm/boot/dts/hi4511.dts
>  create mode 100644 arch/arm/configs/hi3xxx_defconfig
>  create mode 100644 arch/arm/mach-hi3xxx/Kconfig
>  create mode 100644 arch/arm/mach-hi3xxx/Makefile
>  create mode 100644 arch/arm/mach-hi3xxx/core.h
>  create mode 100644 arch/arm/mach-hi3xxx/hi3xxx.c
>  create mode 100644 arch/arm/mach-hi3xxx/hotplug.c
>  create mode 100644 arch/arm/mach-hi3xxx/platsmp.c
>  create mode 100644 arch/arm/mach-hi3xxx/system.c

Forget to loop mailing list.

Regards
Haojian
