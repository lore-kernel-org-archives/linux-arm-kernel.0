From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 12 May 2010 23:43:45 +0100
Subject: [PATCH] h1940: framebuffer configuration fix
In-Reply-To: <20100512232029.a5ce9d0f.ms@sk.2-ch.org>
References: <20100512232029.a5ce9d0f.ms@sk.2-ch.org>
Message-ID: <20100512224345.GK6684@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 12, 2010 at 11:20:29PM +0400, Mike Solovyev wrote:
> Seems like a typo, wrong setup leads to broken image on ipaq screen.

arnaud, any comments here?
 
> Signed-off-by: Mike Solovyev <ms@sk.2-ch.org>
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> ---
>  arch/arm/mach-s3c2410/mach-h1940.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6/arch/arm/mach-s3c2410/mach-h1940.c
> ===================================================================
> --- linux-2.6.orig/arch/arm/mach-s3c2410/mach-h1940.c
> +++ linux-2.6/arch/arm/mach-s3c2410/mach-h1940.c
> @@ -162,8 +162,8 @@ static struct s3c2410fb_display h1940_lc
>  	.xres =		240,
>  	.yres =		320,
>  	.bpp =		16,
> -	.left_margin =	20,
> -	.right_margin =	8,
> +	.left_margin =	8,
> +	.right_margin =	20,
>  	.hsync_len =	4,
>  	.upper_margin =	8,
>  	.lower_margin = 7,
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
