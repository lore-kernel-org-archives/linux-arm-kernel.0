From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 17 Dec 2009 10:32:53 +0100
Subject: [PATCH 09/20] imx/mx1: rename files defining a machine to
	mach-$mach.c
In-Reply-To: <Pine.LNX.4.64.0912162151260.5283@axis700.grange>
References: <1260990002-24168-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-3-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-5-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-6-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-7-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-8-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-9-git-send-email-u.kleine-koenig@pengutronix.de>
	<Pine.LNX.4.64.0912162151260.5283@axis700.grange>
Message-ID: <20091217093253.GA19548@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Guennadi,

On Wed, Dec 16, 2009 at 09:58:41PM +0100, Guennadi Liakhovetski wrote:
> On Wed, 16 Dec 2009, Uwe Kleine-K?nig wrote:
> 
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
> > Cc: Darius Augulis <augulis.darius@gmail.com>
> > Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
> > ---
> >  arch/arm/mach-mx1/Makefile       |    4 +-
> >  arch/arm/mach-mx1/mach-mx1ads.c  |  165 ++++++++++++++++++++++++++++++++++++++
> >  arch/arm/mach-mx1/mach-scb9328.c |  158 ++++++++++++++++++++++++++++++++++++
> >  arch/arm/mach-mx1/mx1ads.c       |  165 --------------------------------------
> >  arch/arm/mach-mx1/scb9328.c      |  158 ------------------------------------
> >  5 files changed, 325 insertions(+), 325 deletions(-)
> >  create mode 100644 arch/arm/mach-mx1/mach-mx1ads.c
> >  create mode 100644 arch/arm/mach-mx1/mach-scb9328.c
> >  delete mode 100644 arch/arm/mach-mx1/mx1ads.c
> >  delete mode 100644 arch/arm/mach-mx1/scb9328.c
> 
> TBH, I don't understand why I was cc'ed on this one, and in general your 
I just used scripts/get_maintainer.pl

> CC lists seem to be a bit over-populated, but if you do like such rename 
> patches to be reviewed, it is better to use the "-M" option to "git 
> format-patch" (maybe also "-C" and even "--find-copies-harder") to save 
> reviewers the work of comparing the deleted and the new files.
I thought that, too after I got the first mail from mailman that the
patches are too big.  Sorry.  You might want to check

	http://git.pengutronix.de/?p=ukl/linux-2.6.git;a=commitdiff;h=00ca84183405791397a2c7bf6da09cd11892ed1e;hp=872865ea03f0a60ba1014f3f4d14bd047ff9696b

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
