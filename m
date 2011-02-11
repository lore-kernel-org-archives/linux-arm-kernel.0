From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 11 Feb 2011 11:24:59 +0100
Subject: [PATCH 1/2] arm: mx50_rdp: add fec support
In-Reply-To: <1297419731-16441-1-git-send-email-richard.zhao@freescale.com>
References: <1297419731-16441-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <20110211102459.GG27982@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 11, 2011 at 06:22:10PM +0800, Richard Zhao wrote:
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> 
> diff --git a/arch/arm/mach-mx5/board-mx50_rdp.c b/arch/arm/mach-mx5/board-mx50_rdp.c
> index dedf7f2..505513c 100644
> --- a/arch/arm/mach-mx5/board-mx50_rdp.c
> +++ b/arch/arm/mach-mx5/board-mx50_rdp.c
> @@ -40,6 +40,9 @@
>  #define FEC_EN		IMX_GPIO_NR(6, 23)
>  #define FEC_RESET_B	IMX_GPIO_NR(4, 12)
>  
> +#define FEC_EN		IMX_GPIO_NR(6, 23)
> +#define FEC_RESET_B	IMX_GPIO_NR(4, 12)
> +
I think this is a left-over of a rebase.  The #defines are already
present and they alone don't justify saying "add fec support".

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
