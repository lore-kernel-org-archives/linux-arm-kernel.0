From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 05 Oct 2011 19:01:10 -0400 (EDT)
Subject: [PATCH 4/4] ARM: OMAP: Map SRAM later on with ioremap_exec()
In-Reply-To: <20111005221320.GE6324@atomide.com>
References: <20111005004339.26980.31149.stgit@kaulin.local>
	<20111005004546.26980.31836.stgit@kaulin.local>
	<alpine.LFD.2.02.1110042107230.9106@xanadu.home>
	<20111005221320.GE6324@atomide.com>
Message-ID: <alpine.LFD.2.02.1110051900230.9106@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 5 Oct 2011, Tony Lindgren wrote:

> * Nicolas Pitre <nico@fluxnic.net> [111004 17:34]:
> > On Tue, 4 Oct 2011, Tony Lindgren wrote:
> > 
> > > This allows us to remove omap hacks for map_io.
> > > 
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > 
> > Nice cleanup.
> > 
> > Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> This one needed minor changes for the omap1 omap_sram_init
> call. Updated patch below, still assuming I have your ack
> for this one too.

Sure.


Nicolas
