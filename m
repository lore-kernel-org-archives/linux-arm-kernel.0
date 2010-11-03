From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 3 Nov 2010 22:21:55 +0100
Subject: [PATCH v2] mx51_3ds: Add esdhc support
In-Reply-To: <895982.34875.qm@web51003.mail.re2.yahoo.com>
References: <895982.34875.qm@web51003.mail.re2.yahoo.com>
Message-ID: <20101103212155.GE11176@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 03, 2010 at 01:53:44PM -0700, Fabio Estevam wrote:
> Add support for esdhc on mx51_3ds board.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/mach-mx5/Kconfig          |    1 +
>  arch/arm/mach-mx5/board-mx51_3ds.c |    1 +
>  2 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
> index b03d68e..74468e3 100644
> --- a/arch/arm/mach-mx5/Kconfig
> +++ b/arch/arm/mach-mx5/Kconfig
> @@ -25,6 +25,7 @@ config MACH_MX51_3DS
>  	select IMX_HAVE_PLATFORM_IMX_UART
>  	select IMX_HAVE_PLATFORM_SPI_IMX
>  	select MXC_DEBUG_BOARD
> +	select IMX_HAVE_PLATFORM_ESDHC
if you order these alphabetically you can get my ack.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
