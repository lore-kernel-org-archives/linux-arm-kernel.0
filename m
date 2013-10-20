From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 20 Oct 2013 15:24:41 -0400
Subject: [PATCH v2 00/27] Armada 370/XP NAND support
In-Reply-To: <20131020195049.7e683d0f@skate>
References: <1382137374-21251-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131019063535.GC20157@1wt.eu>
 <20131019142549.GO22434@titan.lakedaemon.net>
 <20131019162158.GA3044@localhost> <20131020195049.7e683d0f@skate>
Message-ID: <20131020192441.GC15169@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 20, 2013 at 07:50:49PM +0200, Thomas Petazzoni wrote:
> Dear Ezequiel Garcia,
> 
> On Sat, 19 Oct 2013 13:21:59 -0300, Ezequiel Garcia wrote:
> 
> > > > I strongly believe that all the information above is very valuable and
> > > > that it's a shame to lose it in a cover message. It would definitely
> > > > make sense to have this in a doc file.
> > > 
> > > Agreed.  Great work Ezequiel!  Let's capture this in Documentation/.
> > > 
> > 
> > Wait a second!
> > 
> >   $ ls Documentation/mtd/ | wc -l
> >   1
> > 
> > Isn't documenting deprecated? ...
> > 
> > Just kiddin'! I'll add this and the other cover to Documentation/
> > so typos and english fixes are welcome!
> 
> I certainly agree this documentation should be kept, but I'm wondering
> if keeping it as a comment inside the driver doesn't make more sense.

That's a _long_ comment...

> This document is really more about specific implementation details, and
> the next person looking at the driver is not very likely to search such
> details in Documentation/, in my opinion.

A succinct comment in the code pointing to the Documentation/ should be
sufficient.

thx,

Jason.
