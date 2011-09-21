From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 21 Sep 2011 20:52:14 +0900
Subject: [PATCH v3 0/4] ARM: Samsung: Add board setup for M-5MOLS and
	NOON010PC30 camera sensors
In-Reply-To: <1316453441-13525-1-git-send-email-s.nawrocki@samsung.com>
References: <1316453441-13525-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <004601cc7854$e7e9ffc0$b7bdff40$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sylwester Nawrocki wrote:
> 
> Hello,
> 
> the following change set adds board setup code for NOOON01PC30 sensor on
> GONI
> and M-5MOLS on UNIVERSAL_C210 board.
> Some clocks are modified in line with latest FIMC driver modifications for
v3.2.
> 
> Changes since previous version:
>  - improved error handling, switched to gpio_request_array()
>  - created against git://github.com/kgene/linux-samsung.git for-next
> 
Thanks for your re-submitting :)

> Sylwester Nawrocki (4):
>   ARM: S5PV210: Rename sclk_cam clocks for FIMC media driver
>   ARM: S5PV210: Add support for NOON010PC30 sensor on GONI board
>   ARM: EXYNOS4: Rename sclk_cam clocks for FIMC driver
>   ARM: S5PV210: UNIVERSAL_C210: Add support for M-5MOLS image sensor
> 
>  arch/arm/mach-exynos4/Kconfig               |    3 +
>  arch/arm/mach-exynos4/clock.c               |    6 +-
>  arch/arm/mach-exynos4/mach-universal_c210.c |  206
> +++++++++++++++++++++++++-
>  arch/arm/mach-s5pv210/Kconfig               |    1 +
>  arch/arm/mach-s5pv210/clock.c               |    6 +-
>  arch/arm/mach-s5pv210/mach-goni.c           |   53 +++++++
>  6 files changed, 259 insertions(+), 16 deletions(-)
> --
> 1.7.6.3
> 
> The patches can be pulled from
git://git.infradead.org/users/kmpark/linux-2.6-
> samsung,
> branch samsung-board-camera.
> 
Looks ok to me, will apply.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
