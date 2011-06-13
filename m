From: tony@atomide.com (Tony Lindgren)
Date: Mon, 13 Jun 2011 02:51:42 -0700
Subject: [PATCH 0/3] patches to allow DTB to be appended to the ARM zImage
In-Reply-To: <alpine.LFD.2.00.1106121454510.2142@xanadu.home>
References: <1307858800-16712-1-git-send-email-nicolas.pitre@linaro.org>
	<20110612112219.GD16318@ibawizard.net>
	<20110612115820.GF10283@n2100.arm.linux.org.uk>
	<201106121615.24059.arnd@arndb.de>
	<20110612145751.GA4013@ponder.secretlab.ca>
	<20110612151931.GK10283@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1106121145570.2142@xanadu.home>
	<20110612155940.GM10283@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1106121454510.2142@xanadu.home>
Message-ID: <20110613095142.GA10951@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolas Pitre <nicolas.pitre@linaro.org> [110612 11:55]:
> On Sun, 12 Jun 2011, Russell King - ARM Linux wrote:
> 
> > I don't see this as a sustainable way forward.  If we're going to move a
> > particular SoC over to DT, we need to move the entire SoC over.  We can't
> > do this half-heartedly.
> > 
> > And that means we _must_ deal with accepting ATAGs from existing boot
> > loaders, with that information taking precidence over the DT blob
> > supplied with the kernel.
> 
> Well... OK.  Let's see how this can be accommodated with the existing 
> patch floating around doing that.

I agree that we need to parse the user configurable ATAGs to support
existing hardware properly. Otherwise we have edit the .dts for each board
to change the user configurable things, which is not nice for distros.

Regards,

Tony
