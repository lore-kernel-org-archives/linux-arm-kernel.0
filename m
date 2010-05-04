From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 5 May 2010 01:45:24 +0200
Subject: How to allocate a new machine type?
In-Reply-To: <i2ge7bd23c31005041517k33229b87g7f974d6642995706@mail.gmail.com>
References: <x2xe7bd23c31005041432k6c846fc2p90afbd8ec370d3df@mail.gmail.com>
	<20100504215328.GK30601@n2100.arm.linux.org.uk>
	<i2ge7bd23c31005041517k33229b87g7f974d6642995706@mail.gmail.com>
Message-ID: <201005050145.24273.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne St 5. kv?tna 2010 00:17:48 Corbin Simpson napsal(a):
> On Tue, May 4, 2010 at 2:53 PM, Russell King - ARM Linux
> 
> <linux@arm.linux.org.uk> wrote:
> > On Tue, May 04, 2010 at 02:32:15PM -0700, Corbin Simpson wrote:
> >> So, I noticed that there's a Pollux entry, POLLUX_WIZ (1950), in the
> >> mach-types list already. Does anybody know if that covers all Pollux
> >> devices, or just the Wiz? Also, what do I have to do to allocate a new
> >> type?
> > 
> > It's for "GamePark Holdings GP2X Wiz".  So it seems its only for the Wiz.
> > 
> >   Machine name:     GamePark Holdings GP2X Wiz
> >   Web site:         http://www.gp2xwiz.com/
> >   Description:      The GP2X Wiz is a handheld video game machine using
> > the MagicEyes Pollux SoC.
> > 
> > For information on machines, including registering new ones, etc, see
> > the bottom of Documentation/arm/README in the kernel tree.
> 
> Russell,
> 
> Thank you for the quick reply. Type 2028 appears to be the Didj,
> allocated by one of the OpenWiz guys. I will use that.
> 
> While the merge window is still open, is it kosher to send patches to
> this list for upstream? I have a few patches that don't rely on the
> arch-lf1000/arch-pollux code that I'd like to unload. I know that I'm
> new to this part of the kernel, but I think I'm learning quickly.
> 
> ~ C.
This is the right list for arm-related stuff. If it's for other parts of kernel, 
check linux/MAINTAINERS . Also, if you are uncertain about some patches, be sure 
to post them and get a feedback.

Cheers
