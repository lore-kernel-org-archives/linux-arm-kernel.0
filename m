From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 19 Apr 2011 11:49:50 +0200
Subject: [patch 27/29] arm: Cleanup the irq namespace
In-Reply-To: <20110328170653.348149801@linutronix.de>
References: <20110328170219.059141076@linutronix.de>
	<20110328170653.348149801@linutronix.de>
Message-ID: <20110419094950.GN31131@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 28, 2011 at 05:12:36PM -0000, Thomas Gleixner wrote:
> Convert to the new function names. Automated with coccinelle.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> [...]
>  arch/arm/plat-mxc/3ds_debugboard.c             |    8 ++--
>  arch/arm/plat-mxc/avic.c                       |    4 +-
>  arch/arm/plat-mxc/gpio.c                       |   24 +++++++------
>  arch/arm/plat-mxc/irq-common.c                 |    4 +-
>  arch/arm/plat-mxc/tzic.c                       |    4 +-
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
for your changes to arch/arm/plat-mxc.

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
