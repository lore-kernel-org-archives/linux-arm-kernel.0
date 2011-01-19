From: jhnikula@gmail.com (Jarkko Nikula)
Date: Wed, 19 Jan 2011 15:43:39 +0200
Subject: State of LDP3430 platform
In-Reply-To: <alpine.DEB.2.00.1101181234130.13225@utopia.booyaka.com>
References: <20101206125526.GC31777@n2100.arm.linux.org.uk>
	<20101206181913.GH8345@atomide.com>
	<alpine.DEB.2.00.1012061125400.13430@utopia.booyaka.com>
	<20101207083720.GB18336@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1012071745120.13430@utopia.booyaka.com>
	<alpine.DEB.2.00.1012072012000.13430@utopia.booyaka.com>
	<20110115000301.GT4957@atomide.com>
	<alpine.DEB.2.00.1101151237240.32245@utopia.booyaka.com>
	<20110115233744.GA18159@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1101152028580.13225@utopia.booyaka.com>
	<4D3309F9.8090900@gmail.com>
	<alpine.DEB.2.00.1101181234130.13225@utopia.booyaka.com>
Message-ID: <20110119154339.9f20759b.jhnikula@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Jan 2011 12:36:26 -0700 (MST)
Paul Walmsley <paul@pwsan.com> wrote:

> This is due to the recent ARM init_sched_clock() changes and the late
> initialization of the counter_32k clock source.  More information here:
> 
>    http://marc.info/?l=linux-omap&m=129513468605208&w=2
> 
> Fix by initializing the counter_32k clocksource during the machine timer
> initialization.
> 
> Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Tested-by: Thomas Weber <weber@corscience.de>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
Thanks Paul. My tested-by is late as this in already in your pull
request but wanted to comment that this makes the mainline working on
omap3 after commit 211baa7
"ARM: sched_clock: allow init_sched_clock() to be called early"

-- 
Jarkko
