From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 31 Mar 2010 02:26:21 +0100
Subject: [PATCH 1/4] ARM: S3C6410: Define clk_src2 register
In-Reply-To: <1268115034-5998-1-git-send-email-jassisinghbrar@gmail.com>
References: <1268115034-5998-1-git-send-email-jassisinghbrar@gmail.com>
Message-ID: <20100331012621.GP31126@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 09, 2010 at 03:10:31PM +0900, jassisinghbrar at gmail.com wrote:
> From: Jassi Brar <jassi.brar@samsung.com>
> 
> Define S3C6410 specific register - CLK_SRC2

Will sort out a new -next series before the end of the week.
 
> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
> ---
>  arch/arm/mach-s3c64xx/include/mach/regs-clock.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/include/mach/regs-clock.h b/arch/arm/mach-s3c64xx/include/mach/regs-clock.h
> index 3ef6274..0114eb0 100644
> --- a/arch/arm/mach-s3c64xx/include/mach/regs-clock.h
> +++ b/arch/arm/mach-s3c64xx/include/mach/regs-clock.h
> @@ -33,6 +33,7 @@
>  #define S3C_PCLK_GATE		S3C_CLKREG(0x34)
>  #define S3C_SCLK_GATE		S3C_CLKREG(0x38)
>  #define S3C_MEM0_GATE		S3C_CLKREG(0x3C)
> +#define S3C6410_CLK_SRC2	S3C_CLKREG(0x10C)
>  
>  /* CLKDIV0 */
>  #define S3C6400_CLKDIV0_PCLK_MASK	(0xf << 12)
> -- 
> 1.6.2.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
