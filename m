From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 6 Sep 2010 11:13:21 +0100
Subject: Colibri PXA320 Power management question
In-Reply-To: <4C7FC606.20904@compulab.co.il>
References: <AANLkTik_6ziPZwV9EuZwE4SMtJoc10JrBZZ_-mmsuy5a@mail.gmail.com>
	<20100902142203.GA8381@sirena.org.uk>
	<4C7FB7B5.2010301@compulab.co.il>
	<20100902152705.GC5809@rakim.wolfsonmicro.main>
	<4C7FC606.20904@compulab.co.il>
Message-ID: <20100906101320.GD10367@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 02, 2010 at 06:43:02PM +0300, Mike Rapoport wrote:
> Mark Brown wrote:

> >Yes, exactly - what I'm saying is that Linux is set up to use cpufreq
> >rather than rely on the built in stuff.

> There's no contradiction here. The PXA3XX cpufreq implementation
> could trigger automatic voltage scaling.

That'd be slightly entertaining, though, since IIRC the hardware
implementation isn't really set up for being constrained - it doesn't
expect to be cooperating with software governors.
