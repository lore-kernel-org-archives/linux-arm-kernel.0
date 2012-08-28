From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 28 Aug 2012 20:18:50 +0530
Subject: [PATCH 1/3] ARM: EXYNOS: Use EXYNOS4210_GPEx instead of
 EXYNOS4_GPEx
In-Reply-To: <14029212.D3MKvQZpbq@amdc1227>
References: <4648723.rWnut7F0uJ@amdc1227>
	<14029212.D3MKvQZpbq@amdc1227>
Message-ID: <CAJuYYwQWzUaAhBqzf--kVN39GnhsYJMzH6ew6yDf-JCFaA--cQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 August 2012 15:36, Tomasz Figa <t.figa@samsung.com> wrote:
> The GPEx gpios are specific to Exynos4210 and do not exist on Exynos4x12.
> Redefine them to use the exact SoC name.
>
> Based on "ARM: EXYYNOS: Use EXYNOS4210_GPEx instead of EXYNOS4_GPEx" by
> Joonyoung Shim, see:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-May/100738.html
>
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> ---
>  arch/arm/mach-exynos/include/mach/gpio.h   | 32 +++++++++++++++---------------
>  arch/arm/mach-exynos/mach-nuri.c           | 16 +++++++--------
>  arch/arm/mach-exynos/mach-origen.c         |  6 +++---
>  arch/arm/mach-exynos/mach-trats.c          |  4 ++--
>  arch/arm/mach-exynos/mach-universal_c210.c | 32 +++++++++++++++---------------
>  arch/arm/mach-exynos/setup-fimc.c          |  4 ++--
>  drivers/gpio/gpio-samsung.c                | 20 +++++++++----------
>  7 files changed, 57 insertions(+), 57 deletions(-)

Reviewed-by: Thomas Abraham <thomas.abraham@linaro.org>

[...]
