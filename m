From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 2 Jul 2013 15:38:25 +0200
Subject: [RFC] Add .dts file for Netgear ReadyNAS 102
In-Reply-To: <20130702133337.GA17110@titan.lakedaemon.net>
References: <87fvvzfh70.fsf@natisbad.org>
 <20130702124639.GI19937@titan.lakedaemon.net>
 <20130702151407.01680d21@skate>
 <20130702133337.GA17110@titan.lakedaemon.net>
Message-ID: <20130702153825.139a93a5@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Tue, 2 Jul 2013 09:33:37 -0400, Jason Cooper wrote:

> > The big blocker is that no-one has written  the driver for it. It is
> > still on our (Free Electrons) TODO-list, but not as a top-priority item
> > for the moment.
> 
> Ok.
> 
> > Ezequiel had started to do some preliminary cleanup work on the
> > pxa3xx-nand driver, with the ultimate goal of making it support Armada
> > 370/XP (because the IP in the Armada 370/XP is apparently an evolution
> > of the PXA3xx NAND controller), but our priorities shifted to those
> > other topics. We will back on it some day, but I can't say when at the
> > moment.
> 
> Is this under contract?  If so, I don't want to take it from you.  If it
> isn't, perhaps Ezequiel and Arnaud could mind-meld?

The big problem is that the Armada 370 and Armada XP datasheets are
still only available under NDA, so it's quite hard for someone to step
up and do this, without access to those datasheets.

It used to be on our TODO-list, but isn't any longer, and I have no
informations about when it will re-appear on our TODO-list at this
point.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
