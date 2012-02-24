From: timur@freescale.com (Timur Tabi)
Date: Fri, 24 Feb 2012 17:14:12 -0600
Subject: [PATCH 0/6] ASoC: a few cleanups on sound/soc/fsl
In-Reply-To: <20120224232148.GA24268@S2101-09.ap.freescale.net>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
 <20120224140200.GH5450@opensource.wolfsonmicro.com>
 <20120224142342.GA16659@S2101-09.ap.freescale.net>
 <20120224141705.GJ5450@opensource.wolfsonmicro.com>
 <20120224232148.GA24268@S2101-09.ap.freescale.net>
Message-ID: <4F4819C4.5040709@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:
>> > That doesn't seem to be related to my point?  I'm asking you to not
>> > reply to an old version of your patch series in order to post a new
>> > version of it, just post the new version.

> This is the first version of this series.

I think there's a communication breakdown.  Shawn, take a look at this:

http://mailman.alsa-project.org/pipermail/alsa-devel/2012-February/thread.html

Search for "[alsa-devel] [PATCH 0/6] ASoC: a few cleanups on sound/soc/fsl".

You'll see that this email is indented, because it was posted to the
mailing list AS A REPLY to "[alsa-devel] [PATCH 1/4] ASoC: imx: let
SND_MXC_SOC_FIQ select FIQ".  That's because it has this line in the
message header:

In-Reply-To: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>

This is what Mark is talking about.  He wants new patch sets to be posted
NOT as replies to other patch sets.

-- 
Timur Tabi
Linux kernel developer at Freescale
