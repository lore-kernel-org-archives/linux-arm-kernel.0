From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 21 Jul 2011 21:05:36 +0200
Subject: [PATCH] iMX28: Fix emi_ddr_open pinmux
In-Reply-To: <1311264490-5485-1-git-send-email-marek.vasut@gmail.com>
References: <1311264490-5485-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <20110721190536.GC16561@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2011 at 06:08:10PM +0200, Marek Vasut wrote:
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> ---
>  arch/arm/mach-mxs/include/mach/iomux-mx28.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/include/mach/iomux-mx28.h b/arch/arm/mach-mxs/include/mach/iomux-mx28.h
> index f50fefd..1a95ecd 100644
> --- a/arch/arm/mach-mxs/include/mach/iomux-mx28.h
> +++ b/arch/arm/mach-mxs/include/mach/iomux-mx28.h
> @@ -203,7 +203,7 @@
>  #define MX28_PAD_EMI_WEN__EMI_WEN			MXS_IOMUX_PAD_NAKED(6, 21, PAD_MUXSEL_0)
>  #define MX28_PAD_EMI_CE0N__EMI_CE0N			MXS_IOMUX_PAD_NAKED(6, 22, PAD_MUXSEL_0)
>  #define MX28_PAD_EMI_CE1N__EMI_CE1N			MXS_IOMUX_PAD_NAKED(6, 23, PAD_MUXSEL_0)
> -#define MX28_PAD_EMI_CKE__EMI_CKE			MXS_IOMUX_PAD_NAKED(6, 24, PAD_MUXSEL_0)
> +#define MX28_PAD_EMI_CKE__EMI_CKE			MXS_IOMUX_PAD_NAKED(6, 26, PAD_MUXSEL_0)
In my version of the i.MX28 Reference Manual (Rev. 1, 2010) pin24 is
correct. So if you're still convinced that 26 is correct you should point
out in the commit log that the Reference Manual is wrong and why you're
convinced it really is.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
