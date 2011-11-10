From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 10 Nov 2011 08:54:46 +0100
Subject: [PATCH v2] ARM: mx28evk: Simplify GPIO requests for
 mx28evk_fec_reset
In-Reply-To: <20111109214603.GA6316@pengutronix.de>
References: <1320870998-6200-1-git-send-email-festevam@gmail.com>
 <20111109214603.GA6316@pengutronix.de>
Message-ID: <20111110075446.GR16886@pengutronix.de>
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

/me not. See my comments to v1.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
