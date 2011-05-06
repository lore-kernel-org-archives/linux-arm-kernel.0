From: ithamar.adema@team-embedded.nl (Ithamar R. Adema)
Date: Fri, 06 May 2011 16:13:26 +0200
Subject: [RFC] What is the preferred way to share ADC unit between
	hwmon and input(ts) drivers?
In-Reply-To: <4DC3FB15.5090307@cam.ac.uk>
References: <4DB4C252.30005@emcraft.com>
	<20110425110230.GD4768@sirena.org.uk>  <4DC3FB15.5090307@cam.ac.uk>
Message-ID: <1304691206.2256.55.camel@team-embedded-2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-05-06 at 14:43 +0100, Jonathan Cameron wrote:
> The touch screen element should definitely be in input though so
> you will need a solution to the problem of shared registers.

Would it be worth considering generalizing the model that s3c uses[1]
for adc? I've reused that for at least two other platforms already,
though not mainlined (yet).

It could make for a good /drivers/adc/ base IMHO. Any opinions?

Regards,

Ithamar.

[1]:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/arm/plat-samsung/adc.c
