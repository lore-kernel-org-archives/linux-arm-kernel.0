From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 10 Aug 2010 14:21:29 +0100
Subject: [PATCH 8/8] ASoC i.MX: switch to new DMA api
In-Reply-To: <1281344743-2029-9-git-send-email-s.hauer@pengutronix.de>
References: <1281344743-2029-1-git-send-email-s.hauer@pengutronix.de>
	<1281344743-2029-9-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20100810132128.GC4020@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 09, 2010 at 11:05:43AM +0200, Sascha Hauer wrote:
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

So, this is a little hard to read but overall this looks OK.  The one
thing I'd expect to see added is an implementation of delay() that
includes the buffer in the SDMA controller.

Please always CC maintainers on patches.  Even if you don't want to CC
the list for some reason CCing the maintainers is still very helpful.
