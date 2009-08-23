From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 23 Aug 2009 18:03:59 +0100
Subject: [alsa-devel] [RFC][PATCH 1/3 v2] ARM: OMAP: DMA: Add support
	for DMA channel self linking on OMAP1510
In-Reply-To: <200908231756.13016.jkrzyszt@tis.icnet.pl>
References: <200908101050.02530.jkrzyszt@tis.icnet.pl>
	<200908231756.13016.jkrzyszt@tis.icnet.pl>
Message-ID: <20090823170359.GA3488@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 23, 2009 at 05:56:12PM +0200, Janusz Krzysztofik wrote:

> I know it's not very fair to change the patch after others that depend on it
> have already been applied, but I hope there will be no problems with accepting
> the way I have reimplemented it. In any case, I'll appreciate any comments or
> suggestions.

It's not that it's not fair, at this point it's not possible - please
make any changes you feel are required against current ASoC.  The patch
has been applied for a little while now and is buried quite deep in the
already published history.
