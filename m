From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 6 May 2011 15:23:16 +0100
Subject: [RFC] What is the preferred way to share ADC unit between
	hwmon and input(ts) drivers?
In-Reply-To: <1304691206.2256.55.camel@team-embedded-2>
References: <4DB4C252.30005@emcraft.com> <20110425110230.GD4768@sirena.org.uk>
	<4DC3FB15.5090307@cam.ac.uk>
	<1304691206.2256.55.camel@team-embedded-2>
Message-ID: <20110506142316.GP23729@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 06, 2011 at 04:13:26PM +0200, Ithamar R. Adema wrote:

> Would it be worth considering generalizing the model that s3c uses[1]
> for adc? I've reused that for at least two other platforms already,
> though not mainlined (yet).

> It could make for a good /drivers/adc/ base IMHO. Any opinions?

I'd have expected that this stuff should be able to fit into IIO and
that it would be able to be used by in-kernel users.
