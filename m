From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 23 Aug 2011 00:54:52 -0600 (MDT)
Subject: [PATCH 1/5] OMAP2xxx: HWMOD: fix DSS opt clocks
In-Reply-To: <20110823065255.GN4996@atomide.com>
References: <20110821053355.20198.23847.stgit@dusk>
	<20110821054227.20198.80273.stgit@dusk>
	<20110823065255.GN4996@atomide.com>
Message-ID: <alpine.DEB.2.00.1108230054250.28226@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomi,

On Tue, 23 Aug 2011, Tony Lindgren wrote:

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

Could you please update the patch changelogs per Tony's request?

thanks,

- Paul
