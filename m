From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 21 Oct 2009 13:27:09 +0100
Subject: [PATCH] serial/atmel_serial: Fix another fallout of the change
	to BUILD_BUG_ON
In-Reply-To: <20091013082447.GA3194@pengutronix.de>
References: <1255417680-25609-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20091013092644.72c78334@hskinnemoen-d830>
	<20091013082447.GA3194@pengutronix.de>
Message-ID: <20091021122709.GA332@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 13, 2009 at 10:24:47AM +0200, Uwe Kleine-K?nig wrote:
> Hello Andrew,
> 
> On Tue, Oct 13, 2009 at 09:26:44AM +0200, Haavard Skinnemoen wrote:
> > Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:
> > > Commit 8c87df457cb5 fixed BUILD_BUG_ON with the result that some
> > > expressions (e.g. "not really constant" ones) result in a build failure.
> > > 
> > > Some of these were fixed in 8c87df457cb5, but not serial/atmel_serial.
> > 
> > This patch fixes the same issue:
> > 
> > http://lkml.org/lkml/2009/10/6/305
> Can you please take this and add my Ack?
> 
> If you cannot find it anymore in your inbox, you can get it from
> http://article.gmane.org/gmane.linux.kernel/898575/raw

So what's happening with this?
