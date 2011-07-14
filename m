From: tony@atomide.com (Tony Lindgren)
Date: Thu, 14 Jul 2011 00:27:08 -0700
Subject: [PATCH 1/3] ARM: OMAP4: Add pcm049 to Kconfig/Makefile
In-Reply-To: <20110708115842.GJ4820@legolas.emea.dhcp.ti.com>
References: <1310119464-3514-1-git-send-email-j.weitzel@phytec.de>
	<1310119464-3514-2-git-send-email-j.weitzel@phytec.de>
	<4E16EECF.7030102@mvista.com> <20110708115521.GA5783@atomide.com>
	<20110708115842.GJ4820@legolas.emea.dhcp.ti.com>
Message-ID: <20110714072708.GK5783@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [110708 04:53]:
> 
> Are you or are you not taking now board files ? We have one which was
> left out due to a comment from Russell stating that no new board-files
> would be accepted until the move to device tree was completed [1]

Well looking at the cumulative diffstats, adding these board files
with about total of 1000 lines of addition would push our diffstat to
positive side. And that's not a good sign of code coalescing.

So I'll carry the board files in testing-board until we have device tree
working and won't need those.

Alternatively if somebody combines beagle variants to use board-beagle-common.c
and board-panda-common.c then adding new boards would have minimal impact
and would probably make device tree conversion of these boards easier
too.

Regards,

Tony

 
> [1] http://marc.info/?t=130199607500006&r=1&w=2
