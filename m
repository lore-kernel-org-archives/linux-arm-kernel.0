From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Oct 2011 15:57:41 +0200
Subject: [PATCH] ARM: omap2+: stub out omap*_volt_data
In-Reply-To: <87ipnwhepq.fsf@ti.com>
References: <1397689.kebELtC4N3@wuerfel> <87ipnwhepq.fsf@ti.com>
Message-ID: <201110111557.41396.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 10 October 2011, Kevin Hilman wrote:
> > I got this build error only now after pulling in the latest omap series, but
> > I cannot tell what caused it. It's also not clear to me if this is the correct
> > solution. Please ack or provide a better fix.
> 
> This code was merged for v2.6.39, so not sure why this error is only
> showing up for you now.  I just tried a !CONFIG_PM_OPP build on v2.6.39
> and get the same errors, so it's been lingering.
> 
> Maybe you haven't had a randconfig that disabled CONFIG_PM_OPP before?

I don't know. The best explanation is that this is a very unlikely case.
I've done many thousand randconfig builds now and have not seen it before.

Of course, since the output of randconfig is random, it could indeed just
be a coincidence.

> Anyways, the fix is fine with me.

Thanks,

	Arnd
