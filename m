From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 Jul 2011 17:38:22 +0200
Subject: [GIT PULL] arm-soc: last minute arm/davinci fixes for 3.0
In-Reply-To: <20110719145133.GA28651@trinity.fluff.org>
References: <201107191606.26837.arnd@arndb.de>
	<20110719145133.GA28651@trinity.fluff.org>
Message-ID: <201107191738.22695.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 July 2011, Ben Dooks wrote:
> > Ido Yariv (1):
> >       arm: davinci: Fix low level gpio irq handlers' argument
> > 
> > Jon Povey (1):
> >       davinci: DM365 EVM: fix video input mux bits
> > 
> > Todd Poynor (1):
> >       ARM: davinci: Check for NULL return from irq_alloc_generic_chip
> 
> any chance we could get a standardisation on the prefix for the
> commit messages please?

That sounds like a good idea for the future. My preference would
be yet another style, 'arm/davinci: ...', but that is not as
common on ARM today as it is on other architectures.

Statistically, 'ARM: davinci: ...' is the most common style today
across ARM platforms, followed by 'davinci: ...'. If nobody has
strong objections, I'll ask people to do the former in the future,
but I won't make it a requirement until there is a very strong
bias towards that style.

	Arnd
