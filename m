From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 31 Jul 2012 16:46:51 +0100
Subject: [alsa-devel] [PATCH 1/1] ASoC: sgtl5000: enable VAG_POWER for
 LINE_IN
In-Reply-To: <20120728143957.GJ2128@S2101-09.ap.freescale.net>
References: <1343387922-25227-1-git-send-email-b29396@freescale.com>
 <20120728143957.GJ2128@S2101-09.ap.freescale.net>
Message-ID: <20120731154651.GC19974@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 28, 2012 at 10:39:59PM +0800, Shawn Guo wrote:
> On Fri, Jul 27, 2012 at 07:18:42PM +0800, Dong Aisheng wrote:

> > LINE_IN also needs VAG_POWER on or we may hear noise when directly
> > route LINE_IN to Headphone Mux.

> The following is what I see from sgtl5000 data sheet about VAG_POWER.

>   VAG is the internal voltage reference for the ADC and DAC.

> Are you seeing any info that requires VAG_POWER in route of LINE_IN to
> Headphone Mux?  Or it's only a result from your testing?

Given the name I rather suspect that's a datasheet error and the same
reference is used by other bits of the chip.  Just guessing, though.
