From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 2 Jul 2013 09:44:21 -0400
Subject: [RFC] Add .dts file for Netgear ReadyNAS 102
In-Reply-To: <20130702153825.139a93a5@skate>
References: <87fvvzfh70.fsf@natisbad.org>
 <20130702124639.GI19937@titan.lakedaemon.net>
 <20130702151407.01680d21@skate>
 <20130702133337.GA17110@titan.lakedaemon.net>
 <20130702153825.139a93a5@skate>
Message-ID: <20130702134421.GC17110@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 02, 2013 at 03:38:25PM +0200, Thomas Petazzoni wrote:
> Dear Jason Cooper,
> 
> On Tue, 2 Jul 2013 09:33:37 -0400, Jason Cooper wrote:
> 
> > > The big blocker is that no-one has written  the driver for it. It is
> > > still on our (Free Electrons) TODO-list, but not as a top-priority item
> > > for the moment.
> > 
> > Ok.
> > 
> > > Ezequiel had started to do some preliminary cleanup work on the
> > > pxa3xx-nand driver, with the ultimate goal of making it support Armada
> > > 370/XP (because the IP in the Armada 370/XP is apparently an evolution
> > > of the PXA3xx NAND controller), but our priorities shifted to those
> > > other topics. We will back on it some day, but I can't say when at the
> > > moment.
> > 
> > Is this under contract?  If so, I don't want to take it from you.  If it
> > isn't, perhaps Ezequiel and Arnaud could mind-meld?
> 
> The big problem is that the Armada 370 and Armada XP datasheets are
> still only available under NDA, so it's quite hard for someone to step
> up and do this, without access to those datasheets.

bummer.

> It used to be on our TODO-list, but isn't any longer, and I have no
> informations about when it will re-appear on our TODO-list at this
> point.

So, Arnaud, how do you feel about tackling the nand driver based on the
sources you have and the pointers above?

thx,

Jason.
