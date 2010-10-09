From: airlied@gmail.com (Dave Airlie)
Date: Sat, 9 Oct 2010 21:43:50 +1000
Subject: [PATCH] ARM: allow, but warn, when issuing ioremap() on RAM
In-Reply-To: <201010091311.26335.arnd@arndb.de>
References: <1286444662-16843-1-git-send-email-felipe.contreras@gmail.com>
	<20101009092127.GB20975@n2100.arm.linux.org.uk>
	<AANLkTimtdV8THgnQL1RxaqLzCUwO27AZSMPi=UtgpML7@mail.gmail.com>
	<201010091311.26335.arnd@arndb.de>
Message-ID: <AANLkTikdxSQD+9UY70PtCPMgnrovx-dWjrrPJ0AZyG4X@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> The few drivers that may be hit by this are typically in drivers/staging
> exactly because issues like this have not been fixed yet.
>
> We should probably just fix the non-staging drivers that are hit by
> this now and declare the issue done.
>
> When you say that "many drivers broken", can you list the ones you know
> about? It would probably help resolve this the right way.

I'm guessing some closed source graphics drivers for ARM do all kinds
of wrong crap, and Nokia use them a lot, and nobody wants to tell the
closed vendors to change their drivers because it costs money.

Dave.
