From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 18 Jun 2015 14:59:18 +0200
Subject: [PATCH] clk: at91: add generated clock driver
In-Reply-To: <1434614090.2385.19.camel@x220>
References: <1434547409-12232-1-git-send-email-nicolas.ferre@atmel.com>
 <1434611556.2385.8.camel@x220> <20150618093344.7d486e97@bbrezillon>
 <55827606.7020908@atmel.com> <1434614090.2385.19.camel@x220>
Message-ID: <20150618125918.GC27492@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/06/2015 at 09:54:50 +0200, Paul Bolle wrote :
> > I'd like though that this matter of fact doesn't block this piece of
> > code from being reviewed or even better merged in order to ease this new
> > SoC landing...
> 
> The other side of that is that the sama5d2 might never make it, or take
> very long to make it, into mainline. And this would then end up being
> yet another chunk of code adding no value to mainline.
> 

Come on Paul, you prefer the current situation were each vendor have
there tree and when support for an SoC lands in mainline it is already
deprecated?

You have one vendor here, trying to get support for its SoC even before
the silicon is available. Intel is always cited as being a good player
in the linux community for doing exactly that. They even have to remove
support for a CPU that was never manufactured...
The main difference here is that we are no longer doinc everything in
mach-xxx so we have to get the driver part mainlined and this requires
synchronization. I really belive that you can't blame Nicolas to get the
drivers first then the SoC in.

Also, Atmel has a good track record and their SocS are almost fully
supported in mainline, you can trust that sama5d2 support is going to
land there soon.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
