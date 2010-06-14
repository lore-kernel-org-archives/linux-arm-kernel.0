From: jamie@shareable.org (Jamie Lokier)
Date: Mon, 14 Jun 2010 17:33:24 +0100
Subject: Request review of device tree documentation
In-Reply-To: <AANLkTilZuMKzFN1hD1k4Q067jSkryPuWA2bhW0Y3GJTg@mail.gmail.com>
References: <1276339684.1962.186.camel@pasglop>
	<4C13B618.1030006@firmworks.com>
	<1276383132.1962.195.camel@pasglop>
	<AANLkTimRV8u3gDNCAIlROJoPcKs7jFwj2na3ZDFOg3O0@mail.gmail.com>
	<4C146F18.9030008@firmworks.com>
	<AANLkTikls3hjXOmKFqG2D_9GaJSjOXNuuRXPlanAjo5E@mail.gmail.com>
	<20100614124438.GF9323@yookeroo>
	<alpine.LFD.2.00.1006141044510.13427@xanadu.home>
	<20100614160201.GD9550@shareable.org>
	<AANLkTilZuMKzFN1hD1k4Q067jSkryPuWA2bhW0Y3GJTg@mail.gmail.com>
Message-ID: <20100614163324.GG9550@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant Likely wrote:
> > Like initrd, some people will find they need to compile it in to the
> > kernel image to fit some bootloader they can't change, or daren't risk
> > changing in already rolled out devices that they want to update to a
> > DT-using kernel.
> 
> Yes, I fully expect that.  Fortunately the situation is better than it
> was with powerpc.  Since the machine id is being retained, a
> DT-enabled kernel can continue to support non-DT systems.  There will
> not be a flag day to cut everything over to a new boot interface.

That's excellent, thank you.  I was a bit unsure about how that was going.

-- Jamie
