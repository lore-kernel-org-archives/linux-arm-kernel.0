From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 21 Jun 2014 00:09:55 +0200 (CEST)
Subject: [PATCH] irqchip: brcmstb-l2: Level-2 interrupts are edge sensitive
In-Reply-To: <CAGVrzcbpS0tJtkH5vkGRSteV5NU2CzNNkQ43_26XySFqJMAK5A@mail.gmail.com>
References: <1402337102-19428-1-git-send-email-f.fainelli@gmail.com>
 <CAGVrzcZmakEpNW=vGtsb+OmzU_J4hJNoM1sUAoYNsaju_YzGwQ@mail.gmail.com>
 <CAGVrzcbpS0tJtkH5vkGRSteV5NU2CzNNkQ43_26XySFqJMAK5A@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1406202357280.5170@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Jun 2014, Florian Fainelli wrote:
> 2014-06-12 12:13 GMT-07:00 Florian Fainelli <f.fainelli@gmail.com>:
> > 2014-06-09 11:05 GMT-07:00 Florian Fainelli <f.fainelli@gmail.com>:
> >> The driver was configuring the interrupt handler for the Level-2
> >> interrupts to be "level" triggered while they are in fact "edge"
> >> triggered. Fix this by using the correct handler.
> >>
> >> Reported-by: Brian Norris <computersforpeace@gmail.com>
> >> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> >
> > Jason, Thomas, this driver just got merged into 3.16-rc0, can you
> > carry this fix such that it gets into a future 3.16-rc? Thanks!
> 
> Ping! I want to make sure this gets into a next 3.16-rc pull request.
> Andrew, can you take that one if neither Thomas nor Andrew respond in
> a timely manner?

So Andrew should take it if neither Thomas nor Andrew respond. I'm
curious how that works out.

Dude, keep calm. Timely manner?

For something you brought yourself into the merge window and does not
bring the world to a grinding halt like a nasty NULL pointer
dereference in the scheduler?

I have no problem with a polite reminder as stuff falls down the
cracks occassionaly, but please keep the proportions right. The only
user of the code YOU wreckaged has a bugfix already, so what's the
problem whether this hits rc2 or rc3?

Thanks,

	tglx
