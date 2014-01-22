From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 22 Jan 2014 09:49:44 +0800
Subject: [GIT PULL]ARM: sirf: machine update for 3.14
In-Reply-To: <CAGsJ_4z2NRZxqUAyKSX+ksDbkO4j3=ggzMHH2=GDyG2fphGjww@mail.gmail.com>
References: <CAGsJ_4z2NRZxqUAyKSX+ksDbkO4j3=ggzMHH2=GDyG2fphGjww@mail.gmail.com>
Message-ID: <CAGsJ_4zs7Vcb-Zd4Ds9bAecMdJDonQv1zDJU2=cMk9ecqp5DsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof/Kevin,
this series was missed?

-barry

2014/1/15 Barry Song <21cnbao@gmail.com>:
> Hi Kevin/Olof,
>
> The following changes since commit 374b105797c3d4f29c685f3be535c35f5689b30e:
>
>   Linux 3.13-rc3 (2013-12-06 09:34:04 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/baohua/linux.git
> tags/sirf-soc-for-3.14
>
> for you to fetch changes up to dbd1b42baa6ec8082bce6eec37de5e1b46aff19c:
>
>   ARM: prima2: make sirfsoc_init_late function static (2014-01-15
> 10:42:26 +0800)
>
> ----------------------------------------------------------------
> ARM: sirf: machine update for 3.14
>
> Among them:
>  - ARM: prima2: move to generic reset controller driver framework
>  - MAINTAINERS: ARM: SiRF: use regex patterns to involve all SiRF drivers
>  - ARM: prima2: make sirfsoc_init_late function static
>
> ----------------------------------------------------------------
> Barry Song (3):
>       ARM: prima2: move to generic reset controller driver framework
>       MAINTAINERS: ARM: SiRF: use regex patterns to involve all SiRF drivers
>       ARM: prima2: make sirfsoc_init_late function static
>
>  .../devicetree/bindings/reset/sirf,rstc.txt        |   42 +++++++++
>  MAINTAINERS                                        |    9 +-
>  arch/arm/boot/dts/atlas6.dtsi                      |    3 +-
>  arch/arm/boot/dts/marco.dtsi                       |    3 +-
>  arch/arm/boot/dts/prima2.dtsi                      |    3 +-
>  arch/arm/mach-prima2/Kconfig                       |    1 +
>  arch/arm/mach-prima2/common.c                      |    2 +-
>  arch/arm/mach-prima2/rstc.c                        |   93 +++++++++++++-------
>  8 files changed, 110 insertions(+), 46 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/reset/sirf,rstc.txt
>
> -barry
