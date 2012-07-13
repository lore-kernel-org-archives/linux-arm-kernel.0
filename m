From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 13 Jul 2012 20:28:18 +0900
Subject: [PATCH 0/2] ARM: exynos: Enable TMU support in exynos platforms
In-Reply-To: <1342084543-8302-1-git-send-email-amit.daniel@samsung.com>
References: <1342084543-8302-1-git-send-email-amit.daniel@samsung.com>
Message-ID: <117e01cd60ea$99f24e60$cdd6eb20$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Amit Daniel Kachhap wrote:
> 
> These TMU enablement patches are needed for exynos4 and exynos5 TMU
> driver patches sent earlier. The link for those are
> http://www.spinics.net/lists/lm-sensors/msg35858.html.
> 
How was going on above patches? I can't see them you said in linux-next now,
it means if I apply this series in my tree, problem will be happened :(

Note1: I've seen Rafael's updating exynos4_tmu patch which is using struct
dev_pm_ops for pm and applied by Guenter.

Note2: would be helpful if you could do adding me in Cc of exynos tmu
patches...

> Also patch 1 depends on combiner dt node patch sent by Thomas Abraham.
> (http://www.spinics.net/lists/arm-kernel/msg184129.html)
> 
Already in my tree.

> This patchset is based Samsung Maintainer's tree,
> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git for-
> next
> 
OK.

> Amit Daniel Kachhap (2):
>   ARM: exynos4: Add devicetree node for TMU driver
>   ARM: exynos5: Add devicetree node for TMU driver
> 
>  arch/arm/boot/dts/exynos4210.dtsi        |    7 +++++++
>  arch/arm/boot/dts/exynos5250.dtsi        |    6 ++++++
>  arch/arm/mach-exynos/clock-exynos4.c     |    5 +++++
>  arch/arm/mach-exynos/clock-exynos5.c     |    5 +++++
>  arch/arm/mach-exynos/include/mach/irqs.h |    3 +++
>  arch/arm/mach-exynos/include/mach/map.h  |    3 +++
>  arch/arm/mach-exynos/mach-exynos4-dt.c   |    2 ++
>  arch/arm/mach-exynos/mach-exynos5-dt.c   |    2 ++
>  8 files changed, 33 insertions(+), 0 deletions(-)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
