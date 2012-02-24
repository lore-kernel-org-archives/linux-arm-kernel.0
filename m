From: timur@freescale.com (Timur Tabi)
Date: Fri, 24 Feb 2012 10:30:05 -0600
Subject: [PATCH 6/6] ASoC: fsl: check property 'compatible' for the machine
 name
In-Reply-To: <20120224141207.GI5450@opensource.wolfsonmicro.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-7-git-send-email-shawn.guo@linaro.org>
 <20120224141207.GI5450@opensource.wolfsonmicro.com>
Message-ID: <4F47BB0D.9080905@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> The ARM machines really shouldn't be using the bindings that PowerPC is
> using for the machine as they conflate the machine driver with the SSI
> binding.  The idiom for new systems is that machine drivers should be
> first class devices in the device tree referencing the SSI and CODEC.

Where is this documented?

I don't remember participating in the discussion for this new binding.

> The current bindings should be preserved for existing systems of course.

There's no reason we can't update the PowerPC device trees.

-- 
Timur Tabi
Linux kernel developer at Freescale
