From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 20 Dec 2010 20:56:02 +0100
Subject: [Patch 0/0] Add Epit clocks to the iMx25.
In-Reply-To: <BLU0-SMTP512CFC79B1E0DAC0A8EEB8B8190@phx.gbl>
References: <BLU0-SMTP512CFC79B1E0DAC0A8EEB8B8190@phx.gbl>
Message-ID: <20101220195601.GB14221@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 20, 2010 at 01:47:56PM -0500, Bill Pringlemeir wrote:
> 
> Allow use of 'epit.0' and 'epit.1' to set clock source on the iMx25
> platform for associated timers.
> 
> Signed-off-by: Bill Pringlemeir <bpringle@sympatico.ca>
> 

Content-Description: Updates for EPIT clocks.
> diff --git a/arch/arm/mach-mx25/clock.c b/arch/arm/mach-mx25/clock.c
> index 40c7cc4..c1446d2 100644
> --- a/arch/arm/mach-mx25/clock.c
> +++ b/arch/arm/mach-mx25/clock.c
In Sascha's tree this file doesn't exist anymore, so he will probably
ask you to rework your patch to change arch/arm/mach-imx/clock-imx25.c
instead.

(Or maybe he will ask you to wait until it is switched to Jeremy's
common clk approach.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
