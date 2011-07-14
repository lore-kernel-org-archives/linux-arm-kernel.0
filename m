From: tony@atomide.com (Tony Lindgren)
Date: Thu, 14 Jul 2011 00:47:10 -0700
Subject: [PATCH 1/3] ARM: OMAP4: Add pcm049 to Kconfig/Makefile
In-Reply-To: <20110714072708.GK5783@atomide.com>
References: <1310119464-3514-1-git-send-email-j.weitzel@phytec.de>
	<1310119464-3514-2-git-send-email-j.weitzel@phytec.de>
	<4E16EECF.7030102@mvista.com> <20110708115521.GA5783@atomide.com>
	<20110708115842.GJ4820@legolas.emea.dhcp.ti.com>
	<20110714072708.GK5783@atomide.com>
Message-ID: <20110714074710.GM5783@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [110714 00:22]:
> * Felipe Balbi <balbi@ti.com> [110708 04:53]:
> > 
> > Are you or are you not taking now board files ? We have one which was
> > left out due to a comment from Russell stating that no new board-files
> > would be accepted until the move to device tree was completed [1]

For the mcop changes, that should be updated against current devel-board
for the irq/timer/init_early changes. Then I can add that to testing-board
too.

Tony
 
> > [1] http://marc.info/?t=130199607500006&r=1&w=2
