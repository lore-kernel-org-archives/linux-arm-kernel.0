From: tony@atomide.com (Tony Lindgren)
Date: Tue, 18 Jan 2011 15:21:03 -0800
Subject: [PATCH] omap1: Fix booting for 15xx and 730 with
	omap1_defconfig (Re: State of LDP3430 platform)
In-Reply-To: <20110118223536.GT4957@atomide.com>
References: <alpine.DEB.2.00.1012071745120.13430@utopia.booyaka.com>
	<alpine.DEB.2.00.1012072012000.13430@utopia.booyaka.com>
	<20110115000301.GT4957@atomide.com>
	<alpine.DEB.2.00.1101151237240.32245@utopia.booyaka.com>
	<20110115233744.GA18159@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1101152028580.13225@utopia.booyaka.com>
	<4D3309F9.8090900@gmail.com>
	<alpine.DEB.2.00.1101181234130.13225@utopia.booyaka.com>
	<20110118222613.GS4957@atomide.com>
	<20110118223536.GT4957@atomide.com>
Message-ID: <20110118232102.GU4957@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [110118 14:34]:
> For omap15xx and 730 we need to use the MPU timer
> as the 32K timer is not available. For omap16xx
> we want to use the 32K timer because of PM. Fix this
> by allowing to build in both timers.

This still needs one more patch to deal with the
sched_clock for MPU timer..

Tony
