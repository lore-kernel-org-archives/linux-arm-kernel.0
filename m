From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 5 Sep 2011 15:32:44 -0400 (EDT)
Subject: [PATCH 0/3] patches to allow DTB to be appended to the ARM zImage
In-Reply-To: <20110905154335.GH1903@atomide.com>
References: <1307858800-16712-1-git-send-email-nicolas.pitre@linaro.org>
	<BANLkTik_hH9tZ5MMbOYzhZwLFTFQyJyfRg@mail.gmail.com>
	<alpine.LFD.2.00.1106131640370.2142@xanadu.home>
	<20110905154335.GH1903@atomide.com>
Message-ID: <alpine.LFD.2.00.1109051528520.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 5 Sep 2011, Tony Lindgren wrote:

> * Nicolas Pitre <nicolas.pitre@linaro.org> [110613 13:41]:
> > On Sun, 12 Jun 2011, Grant Likely wrote:
> > 
> > > On Sun, Jun 12, 2011 at 12:06 AM, Nicolas Pitre
> > > <nicolas.pitre@linaro.org> wrote:
> > > > This is a resend of those patches with fixups after the latest changes
> > > > in mainline.
> > > >
> > > > [PATCH 1/3] ARM: zImage: ensure it is always a multiple of 64 bits in size
> > > > This one is new and trivial.
> > > >
> > > > [PATCH 2/3] ARM: zImage: Allow the appending of a device tree binary
> > > > Mostly John Bonesio's version with some adjustments and cleanups.
> > > >
> > > > [PATCH 3/3] ARM: zImage: make sure appended DTB doesn't get overwritten by kernel .bss
> > > > New, simpler alternative to Tony Lindgren's version.
> > > 
> > > I've gone ahead and added the series to devicetree/test for anyone who
> > > want to play with it.
> > 
> > I've published those patches with all the latest fixes and ACKs here:
> > 
> > 	git://git.linaro.org/people/nico/linux.git zImage_DTB_append
> 
> Ping, any news on getting these merged?

I should come around to it once my current memory.h cleanup work is in 
shape. This might depend on some new Kbuild facility from Arnaud Lacombe 
I've yet to test.


Nicolas
