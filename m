From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 20 Oct 2011 20:56:38 +0100
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
Message-ID: <20111020195638.GA17384@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2011 at 10:05:34AM -0700, Tony Lindgren wrote:

> Right, but in addition the board specific integration variables still
> need to be passed somehow to the driver.

I'm not sure you're aware of what the regulator bindings that are being
discussed are - they're entirely board specific.  The discussion was
about how to handle certain parts of the feature set Linux currently
has.
