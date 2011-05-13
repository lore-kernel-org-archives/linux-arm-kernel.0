From: tony@atomide.com (Tony Lindgren)
Date: Fri, 13 May 2011 06:28:03 -0700
Subject: [PATCH] ARM: Make sure appended device tree data won't overlap
	kernel BSS
In-Reply-To: <alpine.LFD.2.00.1105131507150.5787@xanadu.home>
References: <20110429135334.GR5126@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104291509540.24613@xanadu.home>
	<20110504072317.GU2092@atomide.com>
	<alpine.LFD.2.00.1105040936040.24613@xanadu.home>
	<20110509111929.GA11410@atomide.com>
	<20110509144949.GE30958@atomide.com>
	<20110512125952.GN31483@atomide.com>
	<alpine.LFD.2.00.1105130930330.2762@xanadu.home>
	<20110513112120.GO31483@atomide.com>
	<alpine.LFD.2.00.1105131507150.5787@xanadu.home>
Message-ID: <20110513132802.GU31483@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolas Pitre <nico@fluxnic.net> [110513 06:06]:
> On Fri, 13 May 2011, Tony Lindgren wrote:
> > 
> > OK, no problem. Got those cleanup patches available somewhere?
> 
> They,re available in branch 'zImage_fixes' of git://git.linaro.org/people/nico/linux
> and in RMK's devel-stable branch as well.

OK, in that case I already did the rebase last night so the
version I posted should apply. I think the original append
patch applied without modifications.

Regards,

Tony
