From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 27 Jan 2012 10:34:10 +0900
Subject: [PATCH 0/6] ARM: SAMSUNG: Board updates and minor fixes
In-Reply-To: <1327501407-1927-1-git-send-email-s.nawrocki@samsung.com>
References: <1327501407-1927-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <016901ccdc93$c79a8e80$56cfab80$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sylwester Nawrocki wrote:
> 
> The following patch series adds S5K6AAFX sensor support on Nuri and
> UNIVERSAL_C210 boards. It also includes minor correction for the I2C
> controller setup and the M-5MOLS sensor.
> 
> 
> Sylwester Nawrocki (6):
>   ARM: SAMSUNG: Increase virtual framebuffer size on Universal C210 board
>   ARM: SAMSUNG: Add support for S5K6AAFX image sensor on Universal C210
> board
>   ARM: SAMSUNG: Add support for S5K6AAFX camera on Nuri board
>   ARM: SAMSUNG: Correct framebuffer window size on Nuri board
>   ARM: SAMSUNG: Correct M-5MOLS sensor clock frequency on Nuri board
>   ARM: SAMSUNG: Fix platform data setup for I2C adapter 0
> 
>  arch/arm/mach-exynos/Kconfig               |    2 +
>  arch/arm/mach-exynos/mach-nuri.c           |   73
++++++++++++++++++++++++--
>  arch/arm/mach-exynos/mach-universal_c210.c |   78
> ++++++++++++++++++++++++++--
>  arch/arm/plat-samsung/devs.c               |    4 +-
>  4 files changed, 147 insertions(+), 10 deletions(-)
> 
> --
> 1.7.8.3

OK, looks good to me, will apply in my v3.3-samsung-fixes-2 for 6/6 and
next/board-samsung for others.

And I'm not sure some board updates are for fix now so if required, please
let me know.

Plus, I looked at some wrong alignment(tab and white space?) in your
patches, so if you don't mind, let me fix it when I apply.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
