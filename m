From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 20 Oct 2011 20:57:34 +0100
Subject: [PATCH v2 3/5] regulator: helper routine to extract
	regulator_init_data
In-Reply-To: <20111020172218.GE31337@atomide.com>
References: <20111019053354.GB31162@S2100-06.ap.freescale.net>
	<20111019144734.GI18713@sirena.org.uk>
	<20111019150448.GB32007@S2100-06.ap.freescale.net>
	<20111019151031.GA4275@opensource.wolfsonmicro.com>
	<4E9F9892.9070007@ti.com> <20111020094140.GK18713@sirena.org.uk>
	<20111020162743.GB31337@atomide.com>
	<20111020164006.GA10155@sirena.org.uk>
	<20111020170534.GC31337@atomide.com>
	<20111020172218.GE31337@atomide.com>
Message-ID: <20111020195734.GB17384@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2011 at 10:22:19AM -0700, Tony Lindgren wrote:

> Hmm, actually, can't we just pass the board specific configuration in
> the board specific .dts file and then it gets merged in with the
> arch independent DT node?

I don't understand what an "arch independent DT node" would be?
