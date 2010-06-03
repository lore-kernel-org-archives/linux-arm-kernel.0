From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 3 Jun 2010 17:52:53 +0100
Subject: [alsa-devel] [PATCH v2 1/4] imx-ssi.c: add new choices to
	platform configuration
In-Reply-To: <20100603081926.GT26820@pengutronix.de>
References: <1274950737-26498-1-git-send-email-eric@eukrea.com>
	<20100601180527.GC10031@sirena.org.uk>
	<20100603081926.GT26820@pengutronix.de>
Message-ID: <20100603165252.GD2762@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 03, 2010 at 10:19:26AM +0200, Sascha Hauer wrote:
> On Tue, Jun 01, 2010 at 07:05:28PM +0100, Mark Brown wrote:

> > Sascha, any comments on the first couple of patches here?

> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Applied both, though I had to hand edit the Makefile and Kconfig for the
machine driver - not sure what it was generated against but it didn't
seem terribly mainline.
