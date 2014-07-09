From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 9 Jul 2014 09:25:53 +0200
Subject: [PATCH] Removes FIXME message in usb.c
In-Reply-To: <1404871119-4324-1-git-send-email-xerofoify@gmail.com>
References: <1404871119-4324-1-git-send-email-xerofoify@gmail.com>
Message-ID: <20140709072553.GJ7827@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 08, 2014 at 09:58:39PM -0400, Nicholas Krause wrote:
> This patch removes a fixme message in this file:wq for setting the usb 2
:wq?

> speed on the board to the correct level. We need to depend on the
> bootloader for doing this as the wires may be shared for the other
> things on the board with the usb chipset.
> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
>  arch/arm/mach-omap1/usb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap1/usb.c b/arch/arm/mach-omap1/usb.c
> index 4118db5..172245a 100644
> --- a/arch/arm/mach-omap1/usb.c
> +++ b/arch/arm/mach-omap1/usb.c
> @@ -505,7 +505,7 @@ static u32 __init omap1_usb2_init(unsigned nwires, unsigned alt_pingroup)
>  		omap_cfg_reg(W5_USB2_SE0);
>  		if (nwires != 3)
>  			omap_cfg_reg(Y5_USB2_RCV);
> -		// FIXME omap_cfg_reg(USB2_SPEED);
> +		/* Depend on boatloader for USB speed to be stated for board */
bootloader?

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
