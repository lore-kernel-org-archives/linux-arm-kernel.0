From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 9 Dec 2010 09:32:37 +0100
Subject: [PATCH v2 14/15] ARM: mxs: Add initial mx28evk support
In-Reply-To: <AANLkTiny2P3RobZfq_G_OPHu_SLjZ2w9CFhU7HgL3VPx@mail.gmail.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291739523-25077-11-git-send-email-shawn.guo@freescale.com>
	<20101208202822.GD17441@pengutronix.de>
	<AANLkTiny2P3RobZfq_G_OPHu_SLjZ2w9CFhU7HgL3VPx@mail.gmail.com>
Message-ID: <20101209083237.GO17441@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shwan,

On Thu, Dec 09, 2010 at 03:04:37PM +0800, Shawn Guo wrote:
> 2010/12/9 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > On Wed, Dec 08, 2010 at 12:32:02AM +0800, Shawn Guo wrote:
> >> +static iomux_cfg_t mx28evk_pads[] = {
> > This can be const and __initconst, ditto for mx23evk
> >
> With u64 iomux_cfg_t changes, I'm afraid the suggestion becomes invalid.
Really? Why?

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
