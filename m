From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 18 Sep 2015 15:14:18 +0100
Subject: Recent GIC v1 patch
In-Reply-To: <55FC18A4.2080205@free.fr>
References: <55FAE26A.9040609@free.fr> <55FAEB4D.30306@arm.com>
 <55FAF6E1.7020107@free.fr> <55FAFD3E.7010006@arm.com>
 <55FBD6F4.8030905@free.fr> <20150918120851.6f9fb306@arm.com>
 <yw1xbnczub0y.fsf@unicorn.mansr.com> <55FC18A4.2080205@free.fr>
Message-ID: <20150918151418.4c0ed401@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Sep 2015 15:59:00 +0200
Mason <slash.tmp@free.fr> wrote:

> On 18/09/2015 15:12, M?ns Rullg?rd wrote:
> 
> > Marc Zyngier wrote:
> > 
> >> No idea so far. The only thing I can immediately spot is a missing pair
> >> of chained_irq_{enter,exit} in tangox_irq_handler, but I can't imagine
> >> this having a terminal effect on the system.
> > 
> > Fixed in the tangox tree on github.
> 
> Oh boy! Oh boy! Oh boy!
> 
> That did the trick. Just when I was about to give up...
> 
> Marc, I'm sending you an e-hug. Mans, you have my eternal gratitude.

Thanks, but I prefer cheese! ;-)

	M.
-- 
Jazz is not dead. It just smells funny.
