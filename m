From: tony@atomide.com (Tony Lindgren)
Date: Tue, 23 Aug 2011 09:54:31 +0300
Subject: [PATCH 1/5] OMAP2xxx: HWMOD: fix DSS opt clocks
In-Reply-To: <20110823065255.GN4996@atomide.com>
References: <20110821053355.20198.23847.stgit@dusk>
	<20110821054227.20198.80273.stgit@dusk>
	<20110823065255.GN4996@atomide.com>
Message-ID: <20110823065430.GO4996@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [110823 09:20]:
> * Paul Walmsley <paul@pwsan.com> [110821 08:11]:
> > From: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > 
> > Set HWMOD_CONTROL_OPT_CLKS_IN_RESET for dss_core to allow DSS reset
> > properly.
> 
> Can you please add what this fixes so this can be justified as a fix?
>  
> > Add missing ick opt-clock for rfbi. Rfbi uses the ick to calculate
> > timings.
> 
> Here too.
>  
> > Fix the venc iclk and fclk.
> 
> And here.

Looks like the comments for the whole series should be improved
so it's clear to everybody what issues these fix and what caused
the breakage.

Tony
