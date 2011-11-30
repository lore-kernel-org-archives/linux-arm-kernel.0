From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 30 Nov 2011 14:26:22 +0100
Subject: [PATCH v2] net: fec: Select the FEC driver by default for i.MX
 SoCs
In-Reply-To: <20111130132536.GD26618@pengutronix.de>
References: <1322652717-2685-1-git-send-email-fabio.estevam@freescale.com>
 <20111130132536.GD26618@pengutronix.de>
Message-ID: <20111130132622.GE26618@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 30, 2011 at 02:25:36PM +0100, Uwe Kleine-K?nig wrote:
> On Wed, Nov 30, 2011 at 09:31:57AM -0200, Fabio Estevam wrote:
> > Let the FEC driver be built by default.
> > 
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> Just one small nitpick below. Other than that:
> 
> Suggested-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

ah, and maybe point out the breaking commit in the log.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
