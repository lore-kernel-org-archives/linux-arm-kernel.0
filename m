From: mathieu.desnoyers@efficios.com (Mathieu Desnoyers)
Date: Fri, 6 Aug 2010 10:48:01 -0400
Subject: [patch 01/20] Create generic alignment API (v8)
In-Reply-To: <20100806114114.GH28519@shisha.kicks-ass.net>
References: <20100709225727.312232266@efficios.com>
	<20100709225814.855827624@efficios.com>
	<20100806114114.GH28519@shisha.kicks-ass.net>
Message-ID: <20100806144801.GA5523@Krystal>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Alexander Shishkin (virtuoso at slind.org) wrote:
> On Fri, Jul 09, 2010 at 06:57:28 -0400, Mathieu Desnoyers wrote:
> > Rather than re-doing the "alignment on a type size" trick all over again at
> > different levels, import the "ltt_align" from LTTng into kernel.h and make this
> > available to everyone. Renaming to:
> > 
> > - object_align()
> > - object_align_floor()
> > - offset_align()
> > - offset_align_floor()
> 
> I was just wondering if this patch makes any progress anywhere?

I'm using it in my generic ring buffer code (I'm posting it as part of the
patchset). This ring buffer has only been posted in RFC-stages so far.

Other than that, there has been no objection. So the first user of this patch
that gets merged will probably bring the patch alongside with it.

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
