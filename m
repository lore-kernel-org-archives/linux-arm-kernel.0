From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 29 Nov 2011 14:06:07 +0800
Subject: [PATCH] arm: mx23: recognise stmp378x as mx23
In-Reply-To: <1322303955-9225-1-git-send-email-w.sang@pengutronix.de>
References: <1322303955-9225-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <20111129060606.GD19754@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 26, 2011 at 11:39:14AM +0100, Wolfram Sang wrote:
> Adding the machine_is_* line was forgotten when converting mach-stmp378x to
> mach-mxs.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> ---

Applied, thanks.

I added 'Cc: stable at kernel.org'.  Please let me know if you do not
think it's necessary.

Regards,
Shawn

>  arch/arm/mach-mxs/include/mach/mxs.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/include/mach/mxs.h b/arch/arm/mach-mxs/include/mach/mxs.h
> index 0d2d2b4..bde5f66 100644
> --- a/arch/arm/mach-mxs/include/mach/mxs.h
> +++ b/arch/arm/mach-mxs/include/mach/mxs.h
> @@ -30,6 +30,7 @@
>   */
>  #define cpu_is_mx23()		(					\
>  		machine_is_mx23evk() ||					\
> +		machine_is_stmp378x() ||				\
>  		0)
>  #define cpu_is_mx28()		(					\
>  		machine_is_mx28evk() ||					\
> -- 
> 1.7.7.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
