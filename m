From: broonie@kernel.org (Mark Brown)
Date: Wed, 18 Mar 2015 13:58:54 +0000
Subject: [PATCH] spi: trigger trace event for message-done before
 mesg->complete
In-Reply-To: <20150318133226.GR10068@pengutronix.de>
References: <1426674448-8246-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150318113635.GB2869@sirena.org.uk>
 <20150318133226.GR10068@pengutronix.de>
Message-ID: <20150318135854.GI2869@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 18, 2015 at 02:32:26PM +0100, Uwe Kleine-K?nig wrote:
> On Wed, Mar 18, 2015 at 11:36:35AM +0000, Mark Brown wrote:

> > Applied, thanks.  I'm a bit suspicious that the changelog talks only
> > about spidev though...

> That's my workflow. Maybe the important thing here is also that I use
> -rt?!

My point here is that the analysis of the issue shouldn't depend on
spidev in particular, if you need to call out the specific driver you're
working with that's an alarm sign that it's doing something weird and
perhaps the problem is with the driver.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150318/0c57f72d/attachment.sig>
