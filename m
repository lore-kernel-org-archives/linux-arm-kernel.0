From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 22 Jul 2013 19:00:44 +0200
Subject: [PATCH] irqchip: exynos: cleanup non-DT stuff in exynos-combiner
In-Reply-To: <027401ce81d3$ad706570$08513050$%kim@samsung.com>
References: <027401ce81d3$ad706570$08513050$%kim@samsung.com>
Message-ID: <8556897.hUyIfVfH2g@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 of July 2013 12:22:14 Kukjin Kim wrote:
> For EXYNOS SoCs, only can support for DT so removes non-DT stuff
> in exynos-combiner.
> 
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  drivers/irqchip/exynos-combiner.c |   44
> +------------------------------------ 1 file changed, 1 insertion(+), 43
> deletions(-)

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
