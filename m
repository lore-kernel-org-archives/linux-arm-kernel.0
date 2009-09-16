From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 16 Sep 2009 01:58:17 +0100
Subject: [PATCH] s3c64xx: Fix S3C64XX_CLKDIV0_ARM_MASK value
In-Reply-To: <1253061316-15939-1-git-send-email-kgene@samsung.com>
References: <1253061316-15939-1-git-send-email-kgene@samsung.com>
Message-ID: <20090916005817.GG24720@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2009 at 09:35:16AM +0900, Kukjin Kim wrote:
> From: Kukjin Kim <kgene.kim@samsung.com>
> 
> The value of S3C64XX_CLKDIV0_ARM_MASK is wrong. This patch fixes
> this values, S3C6400_CLKDIV0_ARM_MASK and S3C6410_CLKDIV0_ARM_MASK.

Would have been better worded as:

Fix the values of S3C6400_CLKDIV0_ARM_MASK and S3C6410_CLKDIV0_ARM_MASK.
 
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>

Real email address, ie kgene.kim at samsung.com in signoff.

> ---
>  arch/arm/plat-s3c64xx/include/plat/regs-clock.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-s3c64xx/include/plat/regs-clock.h b/arch/arm/plat-s3c64xx/include/plat/regs-clock.h
> index a8777a7..ff46e7f 100644
> --- a/arch/arm/plat-s3c64xx/include/plat/regs-clock.h
> +++ b/arch/arm/plat-s3c64xx/include/plat/regs-clock.h
> @@ -51,8 +51,8 @@
>  #define S3C6400_CLKDIV0_HCLK_SHIFT	(8)
>  #define S3C6400_CLKDIV0_MPLL_MASK	(0x1 << 4)
>  #define S3C6400_CLKDIV0_MPLL_SHIFT	(4)
> -#define S3C6400_CLKDIV0_ARM_MASK	(0x3 << 0)
> -#define S3C6410_CLKDIV0_ARM_MASK	(0x7 << 0)
> +#define S3C6400_CLKDIV0_ARM_MASK	(0x7 << 0)
> +#define S3C6410_CLKDIV0_ARM_MASK	(0xf << 0)
>  #define S3C6400_CLKDIV0_ARM_SHIFT	(0)
>  
>  /* CLKDIV1 */
> -- 
> 1.5.3.4
> 

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20090916/0737da83/attachment.sig>
