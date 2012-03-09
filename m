From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 09 Mar 2012 07:33:15 -0800
Subject: [GIT PULL] Samsung Cleanup EXYNOS clock for v3.4
In-Reply-To: <CAJ0PZbQebwvFrmXWn=-m7YH3Ri7t2fvm+E_EKZ45rD7cAyo2UA@mail.gmail.com>
References: <22926872.16671331267895327.JavaMail.weblogic@epml04>
 <CAJ0PZbQebwvFrmXWn=-m7YH3Ri7t2fvm+E_EKZ45rD7cAyo2UA@mail.gmail.com>
Message-ID: <4F5A22BB.2080808@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/12 23:06, MyungJoo Ham wrote:
> 2012/3/9 ???<myungjoo.ham@samsung.com>:

[...]

> 
> Hello, Kgene
> 
> I've rebased the branch that was pull-requested to Kgene based on this branch.
> 

OK, thanks. Let me apply this series on top of new cleanup-exynos-clock.

> http://git.infradead.org/users/kmpark/linux-samsung/shortlog/refs/heads/devfreq-for-samsung
> 
> 
> The following changes since commit e01127814c640f6cd06a5c06731c6d1ee8c45101:
> 
>    PM / devfreq: update the name of EXYNOS clock register (2012-03-07
> 03:25:31 -0800)
> 
> are available in the git repository at:
>    git://git.infradead.org / users/kmpark/linux-samsung devfreq-for-samsung
> 
> MyungJoo Ham (4):
>        ARM: EXYNOS4: Add DMC1, allow PPMU access for DMC.
>        ARM: EXYNOS4: Add clock register addresses for Exynos4x12 bus
> devfreq driver
>        ARM Exynos4210-Nuri: support Exynos4210-bus Devfreq driver.
>        PM / devfreq: update the name of EXYNOS clock registers that were omitted.
> 
>   arch/arm/mach-exynos/common.c                  |    7 +++-
>   arch/arm/mach-exynos/include/mach/map.h        |    1 +
>   arch/arm/mach-exynos/include/mach/regs-clock.h |   42 ++++++++++++++++++++++++
>   arch/arm/mach-exynos/mach-nuri.c               |   11 ++++--
>   drivers/devfreq/exynos4_bus.c                  |    6 ++--
>   5 files changed, 60 insertions(+), 7 deletions(-)
> 

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
