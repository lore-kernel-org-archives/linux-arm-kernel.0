From: mathieu.desnoyers@efficios.com (Mathieu Desnoyers)
Date: Sat, 1 May 2010 15:45:45 -0400
Subject: [RFC PATCH] create generic alignment api (v5)
In-Reply-To: <20100501192915.GD27062@shisha.kicks-ass.net>
References: <20100328012247.GA17763@Krystal> <20100328154029.GA21061@localhost>
	<20100329000900.GB27379@Krystal>
	<20100501183544.GC27062@shisha.kicks-ass.net>
	<20100501191045.GA16710@Krystal>
	<20100501192915.GD27062@shisha.kicks-ass.net>
Message-ID: <20100501194545.GA17271@Krystal>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Alexander Shishkin (virtuoso at slind.org) wrote:
> On Sat, May 01, 2010 at 03:10:45 -0400, Mathieu Desnoyers wrote:
> > * Alexander Shishkin (virtuoso at slind.org) wrote:
> > > On Sun, Mar 28, 2010 at 08:09:00 -0400, Mathieu Desnoyers wrote:
> > > > Rather than re-doing the "alignment on a type size" trick all over again at
> > > > different levels, import the "ltt_align" from LTTng into kernel.h and make this
> > > > available to everyone. Renaming to:
> > > > 
> > > > - object_align()
> > > > - object_align_floor()
> > > > - offset_align()
> > > > - offset_align_floor()
> > > 
> > > Do you plan to have this integrated to the mainline? I'd like to use one of
> > > these in my next version of the __xchg patch. So, do you need any help or
> > > feedback or whatnot with this one?
> > 
> > Given that no one seems to oppose to this patch, I think I'll just re-submit it
> > as-is for real this time.
> 
> Sorry, a short explanation: it has to be a separate header file in order to be of
> use to me, since I need those in system.h, which gets included implicitly through
> bitops.h earlier in kernel.h.
> 
> So I took the liberty to hack up a v6 of this patch.

Yep, I'm ok with this change.

Thanks,

Mathieu

> 
> Regards,
> --
> Alex

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
