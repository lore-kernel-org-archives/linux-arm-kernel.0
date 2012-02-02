From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 2 Feb 2012 11:40:48 -0700 (MST)
Subject: [PATCH 0/2] ARM: OMAP2+: PM: code consolidation for 3.4
In-Reply-To: <87ty39cc7s.fsf@ti.com>
References: <20120202093600.12509.35052.stgit@dusk> <87ty39cc7s.fsf@ti.com>
Message-ID: <alpine.DEB.2.00.1202021140060.586@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2 Feb 2012, Kevin Hilman wrote:

> Paul Walmsley <paul@pwsan.com> writes:
> 
> > Suspend + UART wakeup was tested on OMAP44xx BeagleBoard.  
> 
> I assume you meant Panda board?

Yep

> > On the OMAP35xx Beagleboard here, v3.3-rc2 doesn't seem to wake up
> > from suspend correctly with or without these patches, so I've only
> > boot-tested them on that platform.
> 
> I also tested idle & suspend + UART wakeup on 3430/n900, 3530/Overo.
> 
> Will add these to my cleanup queue for v3.4[1] after adding a Tested-by
> from Santosh.

Great.  Do you know what the deal is with suspend on 34xx?  I enabled 
ttyO2 wakeup and entered suspend, but serial traffic doesn't bring it out?


- Paul
