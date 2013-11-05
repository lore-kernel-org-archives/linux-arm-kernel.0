From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 5 Nov 2013 12:40:33 +0100
Subject: [PATCH 0/3] v7-M support using MULTIPLATFORM
In-Reply-To: <20131104082513.GG14892@pengutronix.de>
References: <1380534577-15076-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <alpine.LFD.2.03.1310032143190.3023@syhkavp.arg>
 <20131104082513.GG14892@pengutronix.de>
Message-ID: <201311051240.34212.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 November 2013, Uwe Kleine-K?nig wrote:
> Hello Nicolas,
> 
> On Thu, Oct 03, 2013 at 09:46:42PM -0400, Nicolas Pitre wrote:
> > On Fri, 4 Oct 2013, Russell King - ARM Linux wrote:
> > 
> > > On Fri, Oct 04, 2013 at 12:28:01AM +0200, Uwe Kleine-K?nig wrote:
> > > > Right, but do we agree that it should be possible to create an XIP image
> > > > for i.MX6? If so: You currently cannot, because i.MX6 isn't configurable
> > > > without MULTIPLATFORM. Also in the times before MULTIPLATFORM XIP was
> > > > special.
> > > 
> > > That's one of the consequences of pushing to multiplatform support - XIP
> > > has fallen by the way side as a result of this effort (it was discussed
> > > previously) and we had decided that almost no one uses it anymore and it
> > > would not be part of the multiplatform stuff.  It was only really used
> > > by very few SA11x0 and PXA platforms anyway.
> > 
> > Semantically, MULTIPLATFORM is incompatible with XIP as well as NOMMU.
> > 
> > So if a platform exists only when MULTIPLATFORM is selected, preventing 
> > it from being configured as NOMMU or XIP then something is broken with 
> > MULTIPLATFORM.
> Is this an Ack for patch 1 in this series?

Uwe, have you seen that patch that Jonathan Austin was working on to reorganize
the platform selection for multiplatform? I don't know if he has gotten around
the time to post it on the mailing list, if not he can probably follow up here.

	Arnd
