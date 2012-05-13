From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 13 May 2012 11:33:14 +0100
Subject: [GIT PULL] Adopt pinctrl support for imx and mxs drivers
In-Reply-To: <20120512021726.GC17875@S2101-09.ap.freescale.net>
References: <20120512021726.GC17875@S2101-09.ap.freescale.net>
Message-ID: <20120513103314.GB706@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 12, 2012 at 10:17:28AM +0800, Shawn Guo wrote:

> I copied subsystem maintainers here in case they see problem to have
> their patches go through arm-soc.

Not quite successful there...

>       ASoC: mxs-saif: adopt pinctrl support

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

This is much more the workflow we normally use for this sort of stuff -
minimal, split out topic branches rather than a single branch with a
whole raft of dependencies on different subsystems.  We shouldn't be
doing complex staging through arm-soc, if that becomes the norm then we
really should have a tree where that sort of thing happens for the
kernel at large rather than using arm-soc.
