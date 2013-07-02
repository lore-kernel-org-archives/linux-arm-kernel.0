From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 2 Jul 2013 09:33:37 -0400
Subject: [RFC] Add .dts file for Netgear ReadyNAS 102
In-Reply-To: <20130702151407.01680d21@skate>
References: <87fvvzfh70.fsf@natisbad.org>
 <20130702124639.GI19937@titan.lakedaemon.net>
 <20130702151407.01680d21@skate>
Message-ID: <20130702133337.GA17110@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On Tue, Jul 02, 2013 at 03:14:07PM +0200, Thomas Petazzoni wrote:
> On Tue, 2 Jul 2013 08:46:39 -0400, Jason Cooper wrote:
> > > In the end, the main missing part is the NAND but I guess this is the
> > > same for all Aramda 370/XP boards and this is not a big issue as it is
> > > still possible to interact w/ it via u-boot and install a set of
> > > uImage/uInitramfs that way. 
> > 
> > What's the big blocker for this?  Once this is done, debian should be
> > able to add support for this board.  After all, upgrading the kernel and
> > initrd from userspace is a desirable option.
> 
> The big blocker is that no-one has written  the driver for it. It is
> still on our (Free Electrons) TODO-list, but not as a top-priority item
> for the moment.

Ok.

> Ezequiel had started to do some preliminary cleanup work on the
> pxa3xx-nand driver, with the ultimate goal of making it support Armada
> 370/XP (because the IP in the Armada 370/XP is apparently an evolution
> of the PXA3xx NAND controller), but our priorities shifted to those
> other topics. We will back on it some day, but I can't say when at the
> moment.

Is this under contract?  If so, I don't want to take it from you.  If it
isn't, perhaps Ezequiel and Arnaud could mind-meld?

thx,

Jason.
