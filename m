From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 21 Nov 2013 13:11:03 +0100
Subject: [PATCH] ARM: exynos_defconfig: increase CONFIG_NR_CPUS value to 8
In-Reply-To: <1511364.Pd4tSi34z7@amdc1032>
References: <1511364.Pd4tSi34z7@amdc1032>
Message-ID: <3699555.ZHO9r7FOJe@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bart,

On Thursday 21 of November 2013 13:06:06 Bartlomiej Zolnierkiewicz wrote:
> Current CONFIG_NR_CPUS value (2) is too small for:
> - EXYNOS4412 (4 cores)
> - EXYNOS5440 (4 cores)
> - EXYNOS5410 (8 cores)
> - EXYNOS5420 (8 cores)
> 
> Set CONFIG_NR_CPUS to 8 so it is correct for all currently
> supported SoCs.
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/configs/exynos_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Definitely a change we want to have.

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
