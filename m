From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 18 Mar 2015 15:48:54 +0100
Subject: [PATCH] spi: trigger trace event for message-done before
 mesg->complete
In-Reply-To: <20150318135854.GI2869@sirena.org.uk>
References: <1426674448-8246-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150318113635.GB2869@sirena.org.uk>
 <20150318133226.GR10068@pengutronix.de>
 <20150318135854.GI2869@sirena.org.uk>
Message-ID: <20150318144854.GS10068@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 18, 2015 at 01:58:54PM +0000, Mark Brown wrote:
> On Wed, Mar 18, 2015 at 02:32:26PM +0100, Uwe Kleine-K?nig wrote:
> > On Wed, Mar 18, 2015 at 11:36:35AM +0000, Mark Brown wrote:
> 
> > > Applied, thanks.  I'm a bit suspicious that the changelog talks only
> > > about spidev though...
> 
> > That's my workflow. Maybe the important thing here is also that I use
> > -rt?!
> 
> My point here is that the analysis of the issue shouldn't depend on
> spidev in particular, if you need to call out the specific driver you're
> working with that's an alarm sign that it's doing something weird and
> perhaps the problem is with the driver.
This just happens to be the driver I saw the problem with. Don't have
another spi device on that bus to cross check with other drivers. I
wouldn't be too concerned here.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
