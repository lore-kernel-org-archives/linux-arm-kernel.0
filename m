From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 10 Mar 2011 18:56:40 +0900
Subject: [PATCH v2] ARM: S5P: Add platform helpers for camera GPIO
	configuration
In-Reply-To: <1299683859-9242-1-git-send-email-s.nawrocki@samsung.com>
References: <01c701cbd975$c7dcd2d0$57967870$%kim@samsung.com>
	<1299683859-9242-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <008a01cbdf09$76c5b800$64512800$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sylwester Nawrocki wrote:
> 
> Add functions for configuration of the parallel camera
> bus pins on S5PV210 and Exynos4 SoC.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> 
> Hello,
> 
> this is a corrected version of platform helpers for the peripheral
> parallel camera bus configuration in S5PV210 and Exynos4 SoCs.
> 
> Changes since v1:
> - Renamed files: camera.h/camport.h, setup-camera.c/setup-fimc.c
> - Replaced "camif" with "fimc" in function and data type names
> - Removed driver strength setup (it turned out than only the clock
>   source pin needed maximum driver strength on the test boards,
>   so I've moved its configuration to the board code)
> 
> 
> Regards,
> Sylwester Nawrocki
> ---
>  arch/arm/mach-exynos4/Kconfig            |    5 +++
>  arch/arm/mach-exynos4/Makefile           |    1 +
>  arch/arm/mach-exynos4/setup-fimc.c       |   44
> ++++++++++++++++++++++++++++++
>  arch/arm/mach-s5pv210/Kconfig            |    5 +++
>  arch/arm/mach-s5pv210/Makefile           |    1 +
>  arch/arm/mach-s5pv210/setup-fimc.c       |   43
> +++++++++++++++++++++++++++++
>  arch/arm/plat-s5p/include/plat/camport.h |   28 +++++++++++++++++++
>  7 files changed, 127 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-exynos4/setup-fimc.c
>  create mode 100644 arch/arm/mach-s5pv210/setup-fimc.c
>  create mode 100644 arch/arm/plat-s5p/include/plat/camport.h
> 
(snip)

Looks ok to me, will apply :)
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
