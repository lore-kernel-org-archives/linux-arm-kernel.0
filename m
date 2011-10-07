From: tony@atomide.com (Tony Lindgren)
Date: Fri, 7 Oct 2011 11:27:54 -0700
Subject: [PATCH 1/4] ARM: Add __arm_ioremap_exec for mapping external
	memory as MT_MEMORY
In-Reply-To: <4E8F42D4.7030502@ti.com>
References: <20111005004539.26980.52409.stgit@kaulin.local>
	<alpine.LFD.2.02.1110042059110.9106@xanadu.home>
	<20111005220619.GC6324@atomide.com> <4E8E9EE8.8010106@ti.com>
	<20111007144349.GE6324@atomide.com> <4E8F14A6.5050402@ti.com>
	<20111007151116.GI6324@atomide.com> <4E8F395B.9070203@ti.com>
	<20111007181621.GJ6324@atomide.com> <4E8F42D4.7030502@ti.com>
Message-ID: <20111007182754.GK6324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [111007 10:46]:
> On Friday 07 October 2011 11:46 PM, Tony Lindgren wrote:
> 
> > I assume now you can add the mapping to io.c instead? If so,
> > then it's easier to apply the patches whatever way makes more
> > sense.
> > 
> io.c change I took as you suggested. The below change on top
> of it. I just updated PM branch with this change.
> 
> Thanks for the tip. The errata code looks bit more clean
> now. :)

OK thanks!

Tony
