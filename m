From: ithamar.adema@team-embedded.nl (Ithamar R. Adema)
Date: Fri, 06 May 2011 17:21:14 +0200
Subject: [RFC] What is the preferred way to share ADC unit between
	hwmon and input(ts) drivers?
In-Reply-To: <20110506142316.GP23729@opensource.wolfsonmicro.com>
References: <4DB4C252.30005@emcraft.com>
	<20110425110230.GD4768@sirena.org.uk> <4DC3FB15.5090307@cam.ac.uk>
	<1304691206.2256.55.camel@team-embedded-2>
	<20110506142316.GP23729@opensource.wolfsonmicro.com>
Message-ID: <1304695274.2256.57.camel@team-embedded-2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-05-06 at 15:23 +0100, Mark Brown wrote:
> I'd have expected that this stuff should be able to fit into IIO and
> that it would be able to be used by in-kernel users. 

My bad, I misread IIO for something else. After a quick glance at the
IIO patches I fully agree it would be a much better solution.

Sorry for the noise...

Ithamar.
