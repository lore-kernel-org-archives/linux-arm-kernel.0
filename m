From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 25 Jun 2011 10:33:49 +0200
Subject: [PATCH] ARM: mach-mx5/mx53_ard: Add missing definition
In-Reply-To: <1308938870-3062-1-git-send-email-festevam@gmail.com>
References: <1308938870-3062-1-git-send-email-festevam@gmail.com>
Message-ID: <20110625083349.GA6588@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Fri, Jun 24, 2011 at 03:07:50PM -0300, Fabio Estevam wrote:
> commit 9203d59 (ARM:mach-mx5/mx53_ard: Add I2C2 and I2C3 support) missed to include
> the define for ARD_I2CPORTEXP_B.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/mach-mx5/board-mx53_ard.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/board-mx53_ard.c b/arch/arm/mach-mx5/board-mx53_ard.c
> index 70ae25e..b94ddeb 100644
> --- a/arch/arm/mach-mx5/board-mx53_ard.c
> +++ b/arch/arm/mach-mx5/board-mx53_ard.c
> @@ -38,6 +38,7 @@
>  #define ARD_ETHERNET_INT_B	IMX_GPIO_NR(2, 31)
>  #define ARD_SD1_CD		IMX_GPIO_NR(1, 1)
>  #define ARD_SD1_WP		IMX_GPIO_NR(1, 9)
> +#define ARD_I2CPORTEXP_B        IMX_GPIO_NR(2, 3)
The other ARD symbols are indented with tabs, you used spaces.  Care to
redo this to be consistent?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
