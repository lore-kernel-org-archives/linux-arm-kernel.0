From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 25 Feb 2012 10:17:58 +0000
Subject: [PATCH 0/6] ASoC: a few cleanups on sound/soc/fsl
In-Reply-To: <4F483BB8.7030706@freescale.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
 <20120224140200.GH5450@opensource.wolfsonmicro.com>
 <20120224142342.GA16659@S2101-09.ap.freescale.net>
 <20120224141705.GJ5450@opensource.wolfsonmicro.com>
 <20120224232148.GA24268@S2101-09.ap.freescale.net>
 <4F4819C4.5040709@freescale.com>
 <20120225000319.GC24268@S2101-09.ap.freescale.net>
 <4F483BB8.7030706@freescale.com>
Message-ID: <20120225101758.GJ22562@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 25, 2012 at 01:39:05AM +0000, Tabi Timur-B04825 wrote:
> Shawn Guo wrote:
> > Yes, I did something wrong.  But my point is the following patches
> > should belong to one big series.  They can not be applied separately.
> >
> > [PATCH 1/4] ASoC: imx: let SND_MXC_SOC_FIQ select FIQ
> > [PATCH 2/4] ASoC: imx: move SND_SOC_AC97_BUS selection down to machine driver
> > [PATCH 3/4] ASoC: imx: initialize dma_params burstsize just in imx-ssi
> > [PATCH 4/4] ASoC: imx: separate imx-pcm bits from imx-ssi driver
> > [PATCH 0/4] ASoC: merge imx into fsl
> > [PATCH 0/6] ASoC: a few cleanups on sound/soc/fsl
> 
> That's not what Mark is talking about.  You somehow posted patch 0/6 as a 
> reply to the *previous* patchset, so the two patchsets were merged into 
> one email thread.

Sorry, you and Mark are not listening to Shawn.  Even worse, you're
telling Shawn that what he's trying to explain to you is not the point
when it is actually the whole point.

The "[PATCH 0/6] ASoC: a few cleanups on sound/soc/fsl" was posted as a
follow-up to "[PATCH 1/4] ASoC: imx: let SND_MXC_SOC_FIQ select FIQ".

So, the "*previous* patchset" _was_ "[PATCH 1/4] ASoC: imx: let
SND_MXC_SOC_FIQ select FIQ" and not some other random patch set.  That
is a fundamental fact, which can't be argued.  Anyone can verify it, and
it can be verified by checking the email headers.
