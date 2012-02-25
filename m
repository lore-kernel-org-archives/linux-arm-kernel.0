From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 25 Feb 2012 08:09:15 +0800
Subject: [PATCH 6/6] ASoC: fsl: check property 'compatible' for the
 machine name
In-Reply-To: <4F47BB0D.9080905@freescale.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-7-git-send-email-shawn.guo@linaro.org>
 <20120224141207.GI5450@opensource.wolfsonmicro.com>
 <4F47BB0D.9080905@freescale.com>
Message-ID: <20120225000913.GE24268@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2012 at 10:30:05AM -0600, Timur Tabi wrote:
> Mark Brown wrote:
> > The ARM machines really shouldn't be using the bindings that PowerPC is
> > using for the machine as they conflate the machine driver with the SSI
> > binding.  The idiom for new systems is that machine drivers should be
> > first class devices in the device tree referencing the SSI and CODEC.
> 
> Where is this documented?
> 
Documentation/devicetree/bindings/sound/tegra*, I guess.

-- 
Regards,
Shawn
