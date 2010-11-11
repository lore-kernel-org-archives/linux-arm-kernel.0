From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 11 Nov 2010 16:18:35 +0000
Subject: [PATCH] [ARM] dove: add support for CM-A510 machine.
In-Reply-To: <4CDBCC78.20003@compulab.co.il>
References: <1286436985-24224-1-git-send-email-kostyas@compulab.co.il>
	<4CB5629A.8040306@compulab.co.il>
	<20101110131838.GA25666@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1011101611110.13911@xanadu.home>
	<4CDBCC78.20003@compulab.co.il>
Message-ID: <20101111161835.GA16589@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 11, 2010 at 12:59:04PM +0200, Mike Rapoport wrote:
> On 11/10/10 23:12, Nicolas Pitre wrote:
> > On Wed, 10 Nov 2010, Russell King - ARM Linux wrote:
> > 
> >> On Wed, Oct 13, 2010 at 09:41:14AM +0200, Mike Rapoport wrote:
> >>> Hi Russell,
> >>> Shell we send it to your patch system?
> >>
> >> I've no idea what to do about this.  I can find no entry in MAINTAINERS
> >> for anyone who looks after Marvell Dove, so I assume it's another bit
> >> of orphaned code.
> >>
> >> It seems that it started off being looked after by Nico, and now that
> >> Nico has moved on to pastures new, it's (presumably) maintainer-less.
> > 
> > I still gather Orion/Kirkwood/Dove patches sent my way and give them a 
> > quick sanity check.
> 
> Russell, Nicolas,
> I'm little bit confused now. Should the Dove patches go to the patch tracking
> system or through Nicolas orion tree?

I have no idea - I was surprised that you were asking me about Dove
stuff as I've never had anything to do with Dove.

Looking at Dove's history, it has been looked after by Nicolas, so it's
up to Nicolas to declare what his intention is, and sort out replacement
maintainers if he doesn't want to look after it anymore.  In any case,
the missing MAINTAINERS entry needs fixing to indicate who should accept
patches for it, or whether mach-dove is orphaned.
