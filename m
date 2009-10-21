From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 21 Oct 2009 15:56:53 +0200
Subject: [PATCH] serial/atmel_serial: Fix another fallout of the change
	to BUILD_BUG_ON
In-Reply-To: <20091021122709.GA332@n2100.arm.linux.org.uk>
References: <1255417680-25609-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20091013092644.72c78334@hskinnemoen-d830>
	<20091013082447.GA3194@pengutronix.de>
	<20091021122709.GA332@n2100.arm.linux.org.uk>
Message-ID: <20091021135653.GA2064@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Oct 21, 2009 at 01:27:09PM +0100, Russell King - ARM Linux wrote:
> On Tue, Oct 13, 2009 at 10:24:47AM +0200, Uwe Kleine-K?nig wrote:
> > Hello Andrew,
> > 
> > On Tue, Oct 13, 2009 at 09:26:44AM +0200, Haavard Skinnemoen wrote:
> > > Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:
> > > > Commit 8c87df457cb5 fixed BUILD_BUG_ON with the result that some
> > > > expressions (e.g. "not really constant" ones) result in a build failure.
> > > > 
> > > > Some of these were fixed in 8c87df457cb5, but not serial/atmel_serial.
> > > 
> > > This patch fixes the same issue:
> > > 
> > > http://lkml.org/lkml/2009/10/6/305
> > Can you please take this and add my Ack?
> > 
> > If you cannot find it anymore in your inbox, you can get it from
> > http://article.gmane.org/gmane.linux.kernel/898575/raw
> 
> So what's happening with this?
The patch by Haavard Skinnemoen is in -mm as

	atmel_serial-fix-bad-build_bug_on-usage.patch

.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
