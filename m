From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 1 Dec 2011 20:19:35 +0800
Subject: [PATCH] mx28: LRADC macro rename
In-Reply-To: <1322667807-8097-1-git-send-email-rusko.peter@prolan.hu>
References: <1322667807-8097-1-git-send-email-rusko.peter@prolan.hu>
Message-ID: <20111201121934.GI711@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 30, 2011 at 04:43:27PM +0100, Peter Rusko wrote:
> It's a correction of two macro names, renaming them from IRADC to LRADC.
> 
> Signed-off-by: Peter Rusko <rusko.peter@prolan.hu>
> ---

Applied, thanks.

I added the prefix 'ARM: ' to the patch subject to make it consistent
with one of the most common pattern of ARM patch subject.

-- 
Regards,
Shawn

>  arch/arm/mach-mxs/include/mach/mx28.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/include/mach/mx28.h b/arch/arm/mach-mxs/include/mach/mx28.h
> index 75d8611..30c7990 100644
> --- a/arch/arm/mach-mxs/include/mach/mx28.h
> +++ b/arch/arm/mach-mxs/include/mach/mx28.h
> @@ -104,8 +104,8 @@
>  #define MX28_INT_CAN1			9
>  #define MX28_INT_LRADC_TOUCH		10
>  #define MX28_INT_HSADC			13
> -#define MX28_INT_IRADC_THRESH0		14
> -#define MX28_INT_IRADC_THRESH1		15
> +#define MX28_INT_LRADC_THRESH0		14
> +#define MX28_INT_LRADC_THRESH1		15
>  #define MX28_INT_LRADC_CH0		16
>  #define MX28_INT_LRADC_CH1		17
>  #define MX28_INT_LRADC_CH2		18
> -- 
> 1.7.5.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
