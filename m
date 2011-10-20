From: tony@atomide.com (Tony Lindgren)
Date: Thu, 20 Oct 2011 10:22:19 -0700
Subject: [PATCH v2 3/5] regulator: helper routine to extract
	regulator_init_data
In-Reply-To: <20111020170534.GC31337@atomide.com>
References: <20111018160046.GD28501@opensource.wolfsonmicro.com>
	<20111019053354.GB31162@S2100-06.ap.freescale.net>
	<20111019144734.GI18713@sirena.org.uk>
	<20111019150448.GB32007@S2100-06.ap.freescale.net>
	<20111019151031.GA4275@opensource.wolfsonmicro.com>
	<4E9F9892.9070007@ti.com> <20111020094140.GK18713@sirena.org.uk>
	<20111020162743.GB31337@atomide.com>
	<20111020164006.GA10155@sirena.org.uk>
	<20111020170534.GC31337@atomide.com>
Message-ID: <20111020172218.GE31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [111020 09:31]:
> 
> That's where a DT entry specific configuration string might be the best
> option as it still allows describing the hardware using DT standards,
> while also allowing board specific configuration too.

Hmm, actually, can't we just pass the board specific configuration in
the board specific .dts file and then it gets merged in with the
arch independent DT node?

Regards,

Tony
