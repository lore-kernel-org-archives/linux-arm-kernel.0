From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 24 Jun 2013 21:21:29 +0800
Subject: [PATCH] ARM: i.MX27: Typo fix
In-Reply-To: <1371994835-3482-1-git-send-email-shc_work@mail.ru>
References: <1371994835-3482-1-git-send-email-shc_work@mail.ru>
Message-ID: <20130624132127.GE30747@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 23, 2013 at 05:40:35PM +0400, Alexander Shiyan wrote:
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Applied, thanks.

Shawn

> ---
>  arch/arm/mach-imx/mx27.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/mx27.h b/arch/arm/mach-imx/mx27.h
> index e074616..8a65f19 100644
> --- a/arch/arm/mach-imx/mx27.h
> +++ b/arch/arm/mach-imx/mx27.h
> @@ -135,7 +135,7 @@
>  #define MX27_INT_GPT4		(NR_IRQS_LEGACY + 4)
>  #define MX27_INT_RTIC		(NR_IRQS_LEGACY + 5)
>  #define MX27_INT_CSPI3		(NR_IRQS_LEGACY + 6)
> -#define MX27_INT_SDHC		(NR_IRQS_LEGACY + 7)
> +#define MX27_INT_MSHC		(NR_IRQS_LEGACY + 7)
>  #define MX27_INT_GPIO		(NR_IRQS_LEGACY + 8)
>  #define MX27_INT_SDHC3		(NR_IRQS_LEGACY + 9)
>  #define MX27_INT_SDHC2		(NR_IRQS_LEGACY + 10)
> -- 
> 1.8.1.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
