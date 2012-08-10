From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 10 Aug 2012 07:12:00 +0200
Subject: [PATCH] ARM: imx/iomux-v3: allow pad_list to be const
In-Reply-To: <20120810032217.GF19617@S2101-09.ap.freescale.net>
References: <1344527835-32567-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20120810032217.GF19617@S2101-09.ap.freescale.net>
Message-ID: <20120810051200.GI25520@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

On Fri, Aug 10, 2012 at 11:22:20AM +0800, Shawn Guo wrote:
> On Thu, Aug 09, 2012 at 05:57:15PM +0200, Uwe Kleine-K?nig wrote:
> > Also fix all machine files to make use of it and while at it also make
> > the pad lists __init_const.
> > 
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > ---
> > Hello,
> > 
> > well, iomux-v3 is dying so I don't know how welcome this patch is.
> > 
> For me, it's not so welcomed at this point, as I have seen it's
> patching a bunch of imx5 board files that are scheduled for removal
> for this cycle.
I can resend with the respective board files dropped when your changes
hit next.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
