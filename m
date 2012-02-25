From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 25 Feb 2012 08:03:20 +0800
Subject: [PATCH 0/6] ASoC: a few cleanups on sound/soc/fsl
In-Reply-To: <4F4819C4.5040709@freescale.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
 <20120224140200.GH5450@opensource.wolfsonmicro.com>
 <20120224142342.GA16659@S2101-09.ap.freescale.net>
 <20120224141705.GJ5450@opensource.wolfsonmicro.com>
 <20120224232148.GA24268@S2101-09.ap.freescale.net>
 <4F4819C4.5040709@freescale.com>
Message-ID: <20120225000319.GC24268@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2012 at 05:14:12PM -0600, Timur Tabi wrote:
> Shawn Guo wrote:
> >> > That doesn't seem to be related to my point?  I'm asking you to not
> >> > reply to an old version of your patch series in order to post a new
> >> > version of it, just post the new version.
> 
> > This is the first version of this series.
> 
> I think there's a communication breakdown.  Shawn, take a look at this:
> 
> http://mailman.alsa-project.org/pipermail/alsa-devel/2012-February/thread.html
> 
> Search for "[alsa-devel] [PATCH 0/6] ASoC: a few cleanups on sound/soc/fsl".
> 
> You'll see that this email is indented, because it was posted to the
> mailing list AS A REPLY to "[alsa-devel] [PATCH 1/4] ASoC: imx: let
> SND_MXC_SOC_FIQ select FIQ".  That's because it has this line in the
> message header:
> 
> In-Reply-To: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
> 
> This is what Mark is talking about.  He wants new patch sets to be posted
> NOT as replies to other patch sets.
> 
Yes, I did something wrong.  But my point is the following patches
should belong to one big series.  They can not be applied separately.

[PATCH 1/4] ASoC: imx: let SND_MXC_SOC_FIQ select FIQ
[PATCH 2/4] ASoC: imx: move SND_SOC_AC97_BUS selection down to machine driver
[PATCH 3/4] ASoC: imx: initialize dma_params burstsize just in imx-ssi
[PATCH 4/4] ASoC: imx: separate imx-pcm bits from imx-ssi driver
[PATCH 0/4] ASoC: merge imx into fsl
[PATCH 0/6] ASoC: a few cleanups on sound/soc/fsl

-- 
Regards,
Shawn
