From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 14 Nov 2014 21:37:10 +0100
Subject: [PATCH] MAINTAINERS: add pattern for respective device tree
 files to Armada entry
In-Reply-To: <20141114201036.GH2001@lunn.ch>
References: <1415994009-3548-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20141114201036.GH2001@lunn.ch>
Message-ID: <20141114203710.GR27002@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andrew,

On Fri, Nov 14, 2014 at 09:10:36PM +0100, Andrew Lunn wrote:
> On Fri, Nov 14, 2014 at 08:40:09PM +0100, Uwe Kleine-K?nig wrote:
> > This makes it more likely that changes to these files are addressed to the
> > right maintainers.
> > 
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 60b1163dba28..282e5427209c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1136,6 +1136,7 @@ M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> >  L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> >  S:	Maintained
> >  F:	arch/arm/mach-mvebu/
> > +F:	arch/arm/boot/dts/armada-*
> 
> Hi Uwe
> 
> Maybe also add kirkwood-* and dove-*
The maintainer entry is called "ARM/Marvell Armada 370 and Armada XP SOC
support". I think adding the correct dts files to the correct maintainer
section is hard to get right for me as I'm not that deep into Marvell
stuff. Maybe some of you want to pick up this topic and reshuffle in a
correct way, e.g. by just merging all mvebu platforms in MAINTAINERS?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
