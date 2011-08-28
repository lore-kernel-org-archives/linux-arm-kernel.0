From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 28 Aug 2011 08:08:20 +0200
Subject: [PATCHv3 0/9] macb: add support for Cadence GEM
In-Reply-To: <20110823093453.GJ2796@pulham.picochip.com>
References: <1312881411-2376-1-git-send-email-jamie@jamieiles.com>
	<20110809145940.GP22213@game.jcrosoft.org>
	<20110823093453.GJ2796@pulham.picochip.com>
Message-ID: <20110828060820.GB20128@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:34 Tue 23 Aug     , Jamie Iles wrote:
> Hi Jean-Christoph,
> 
> On Tue, Aug 09, 2011 at 04:59:40PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > On 10:16 Tue 09 Aug     , Jamie Iles wrote:
> > > This is largely a repost of the series I posted back in March.  The only changes
> > > since then are rebasing onto 3.1-rc1 and changing the gem conditionals from a
> > > boolean in the macb structure to an inline helper as requested by
> > > Jean-Christophe.
> > > 
> > > This has been run-tested on picoxcell and compile tested for all AT91 platforms
> > > but I couldn't get a working cross compiler for avr32.
> > > 
> > > All patches are available in a git branch at
> > > 
> > > 	git://github.com/jamieiles/linux-2.6-ji.git macb-gem
> > > 
> > looks good except few comments
> > 
> > I'll test it later this week
> 
> Have you had chance to test this series?  I'd like to get it into Arnd's 
> tree and into next for a bit so we can get it into the next release if 
> possible.

I'm back from travelling

I've test it on usb-a9g20 with boot over nfs

work

Tested-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
