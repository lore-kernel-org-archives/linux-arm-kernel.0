From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 22 Jun 2012 13:30:13 +0100
Subject: [RFC 0/3] Add cyclic DMA support to OMAP DMA engine driver
In-Reply-To: <20120622085911.GA19026@n2100.arm.linux.org.uk>
References: <20120622085911.GA19026@n2100.arm.linux.org.uk>
Message-ID: <20120622123013.GA7586@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 22, 2012 at 09:59:11AM +0100, Russell King - ARM Linux wrote:

> As v3.5-rc is horribly broken on my OMAP platforms, I've had to back out
> all the sound/soc/omap changes from the last merge window to test this,
> inspite of Peter Ujfalusi maintaining that there is nothing wrong.  I
> can't get working audio support on the OMAP4430SDP any other way.

Do you have any details on what's wrong here?  I've not seen any
upstream reports but there's been precious little upstream work there so
it should be simple to identify which changes caused the breakage and
just drop them.  There's been no public reports...

> I am planning no further work on this until OMAP ASoC support gets fixed;
> due to Peter and my plans this summer, this is likely to be late July/
> August time.

That's sounding like 3.5 is likely to go out work broken audio.
