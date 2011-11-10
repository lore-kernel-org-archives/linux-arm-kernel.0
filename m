From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 10 Nov 2011 07:54:38 +0100
Subject: [PATCH v2] ARM: mx28evk: Simplify GPIO requests for
 mx28evk_fec_reset
In-Reply-To: <20111109214603.GA6316@pengutronix.de>
References: <1320870998-6200-1-git-send-email-festevam@gmail.com>
 <20111109214603.GA6316@pengutronix.de>
Message-ID: <20111110065438.GI13122@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 09, 2011 at 10:46:03PM +0100, Wolfram Sang wrote:
> On Wed, Nov 09, 2011 at 06:36:38PM -0200, Fabio Estevam wrote:
> > From: Fabio Estevam <fabio.estevam@freescale.com>
> > 
> > Simplify GPIO requests inside mx28evk_fec_reset by using gpio_request_array.
> > 
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Like it: Acked-by: Wolfram Sang <w.sang@pengutronix.de>
/me to.

Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
