From: tony@atomide.com (Tony Lindgren)
Date: Wed, 21 Sep 2011 08:24:00 -0700
Subject: [PATCH 00/10] hwspinlock-next
In-Reply-To: <20110920234515.GA16276@kroah.com>
References: <1315846025-11453-1-git-send-email-ohad@wizery.com>
	<CAK=Wgbam6u1bq8fG+oMUhxfWH1g3dU7q+VhPWFEZOLgFMV_3vQ@mail.gmail.com>
	<20110920231340.GT18894@atomide.com>
	<20110920234515.GA16276@kroah.com>
Message-ID: <20110921152359.GD2937@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Greg KH <greg@kroah.com> [110921 07:27]:
> On Tue, Sep 20, 2011 at 04:13:40PM -0700, Tony Lindgren wrote:
> > * Ohad Ben-Cohen <ohad@wizery.com> [110920 01:34]:
> > > On Mon, Sep 12, 2011 at 7:46 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> > > 
> > > I'm wondering how hwspinlock updates like this should go upstream.
> > > 
> > > The first hwspinlock batch was picked by Tony, because it involved a
> > > bulk of OMAP changes.
> > > 
> > > Hwspinlock isn't OMAP-specific anymore though (we gained support for
> > > STE's u8500) and the vast majority of changes are in drivers/. We're
> > > still very much ARM-related, though this may change too at some point
> > > (c6x has a similar "hardware semaphore" peripheral like the u8500
> > > does).
> > > 
> > > Tony, if you're still willing to pick up these updates I'd be happy to
> > > send you pull requests of course.
> > 
> > I'd prefer for Greg to take these as these are drivers.
> 
> What, am I the catch-all for drivers these days?
> 
> Oh, right, it looks like I am :)
> 
> > If he's not taking it at this point based on it being ARM only,
> > I can take it then.
> 
> Please do, I don't even have the ability to build them here, as I don't
> have an arm cross-compiler on this travel laptop.

OK so you're off the hook then :) Now we still need to sort out the
remaining options posted by Arnd.

Tony
