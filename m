From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 8 Jan 2010 16:18:38 +0000
Subject: [alsa-devel] [PATCH 1/3] ASoC: Add a new imx-ssi sound driver
In-Reply-To: <eedb5540912180618w53e24c6ahe1d47d410e1a91e8@mail.gmail.com>
References: <1259163666-30344-1-git-send-email-s.hauer@pengutronix.de>
	<1259163666-30344-2-git-send-email-s.hauer@pengutronix.de>
	<20091125155807.GD12750@rakim.wolfsonmicro.main>
	<eedb5540911300840p230fc57fh3fd5c8453b0e1f73@mail.gmail.com>
	<eedb5540911300909vf042b39l44e06b432351b@mail.gmail.com>
	<20091201154920.GW27548@pengutronix.de>
	<eedb5540912180618w53e24c6ahe1d47d410e1a91e8@mail.gmail.com>
Message-ID: <20100108161837.GD10128@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2009 at 03:18:50PM +0100, javier Martin wrote:

> I don't wanna delay the entering of this driver to mainline. It is clear
> that it is cleaner and more generic than mine. And, what we really care, it
> works for our board.

> If you have any inconvenience with my requirement I could just ack the patch
> and maybe we could add support for it later.

It would be really good to see this merged.  I've been taking a closer
look at the driver while trying to get audio working on my i.MX31ADS and
did a few updates (which I still don't have working, though I suspect
the audmux or iomux rather than the driver).  I'll post the updates
shortly, and if people are happy I'd like to merge this stuff together
with removing the old code.
