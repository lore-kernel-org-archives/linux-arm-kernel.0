From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 18 Jun 2013 18:18:38 +0900
Subject: [PATCH v2 32/38] [media] exynos4-is: Remove check for
 SOC_EXYNOS4412
In-Reply-To: <1371486863-12398-33-git-send-email-t.figa@samsung.com>
References: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
 <1371486863-12398-33-git-send-email-t.figa@samsung.com>
Message-ID: <1b9b01ce6c04$d0f37c10$72da7430$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:
> 
> Since SOC_EXYNOS4412 Kconfig symbol has been removed, it is enough to
> check for SOC_EXYNOS4212 for both SoCs from Exynos4x12 series.
> 
> Cc: linux-media at vger.kernel.org
> Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/media/platform/exynos4-is/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/exynos4-is/Kconfig
> b/drivers/media/platform/exynos4-is/Kconfig
> index 004fd0b..0d4fd5c 100644
> --- a/drivers/media/platform/exynos4-is/Kconfig
> +++ b/drivers/media/platform/exynos4-is/Kconfig
> @@ -33,7 +33,7 @@ config VIDEO_S5P_MIPI_CSIS
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called s5p-csis.
> 
> -if SOC_EXYNOS4212 || SOC_EXYNOS4412 || SOC_EXYNOS5250
> +if SOC_EXYNOS4212 || SOC_EXYNOS5250
> 
>  config VIDEO_EXYNOS_FIMC_LITE
>  	tristate "EXYNOS FIMC-LITE camera interface driver"
> --
> 1.8.2.1

NAK, the reason is same with my comments on 30th patch.

- Kukjin
