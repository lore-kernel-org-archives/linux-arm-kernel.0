From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 19 Dec 2009 21:18:17 +0100
Subject: [PATCH 2/4] mfd: mc13783: When probing, unlock the mc13783
	before subsystems initialisation.
In-Reply-To: <1261152746.3356.72.camel@climbing-alby>
References: <1260808880.2022.98.camel@climbing-alby>
	<1260810776.2022.130.camel@climbing-alby>
	<1260811085.2022.135.camel@climbing-alby>
	<1261152746.3356.72.camel@climbing-alby>
Message-ID: <20091219201816.GA28742@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Dec 18, 2009 at 05:12:26PM +0100, Alberto Panizzo wrote:
> Ping :)
> 
> PATCH 1 & 2 are fixes that can go to .33
I don't like patch 1.  I'd prefer that drivers touching
MC13783_REG_POWER_MISCELLANEOUS are aware of the bit in question and
wouldn't rely on mc13783-core.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
