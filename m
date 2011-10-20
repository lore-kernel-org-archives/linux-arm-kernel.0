From: rnayak@ti.com (Rajendra Nayak)
Date: Thu, 20 Oct 2011 17:40:54 +0530
Subject: [PATCH v2 3/5] regulator: helper routine to extract
	regulator_init_data
In-Reply-To: <20111020094140.GK18713@sirena.org.uk>
References: <1318263578-7407-4-git-send-email-rnayak@ti.com>
	<20111016145536.GA29885@S2100-06.ap.freescale.net>
	<4E9BAC4D.3010402@ti.com>
	<20111018115836.GC30703@S2100-06.ap.freescale.net>
	<20111018160046.GD28501@opensource.wolfsonmicro.com>
	<20111019053354.GB31162@S2100-06.ap.freescale.net>
	<20111019144734.GI18713@sirena.org.uk>
	<20111019150448.GB32007@S2100-06.ap.freescale.net>
	<20111019151031.GA4275@opensource.wolfsonmicro.com>
	<4E9F9892.9070007@ti.com> <20111020094140.GK18713@sirena.org.uk>
Message-ID: <4EA00FCE.4010807@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> We can always start off just completely omitting the data and then see
> how we go from there.  If we only cover 50% of users that's still 50%
> more than are currently covered with device tree right now and it means
> we can then spin round and look at the bits that are hard again without
> review fatigue on the bits that are easy.

Ok, will drop the problematic bindings for now and repost.
