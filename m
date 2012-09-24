From: jon-hunter@ti.com (Jon Hunter)
Date: Mon, 24 Sep 2012 16:43:49 -0500
Subject: [PATCH V3 0/8] ARM: OMAP4: Add PMU Support
In-Reply-To: <alpine.DEB.2.00.1209201714260.12583@utopia.booyaka.com>
References: <1347290626-21164-1-git-send-email-jon-hunter@ti.com>
 <alpine.DEB.2.00.1209201714260.12583@utopia.booyaka.com>
Message-ID: <5060D415.1040603@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 09/20/2012 12:17 PM, Paul Walmsley wrote:
> 
> Hi Jon, Will, Ming, et al.,
> 
> Have queued most of these for 3.7 with the exception of the OMAP4430 
> CTI-related patches (which look to me like 3.8 material) and the PM 
> runtime suspend/resume patch (which looks to me like 3.7-rc material) -- 
> assuming this series makes it in for 3.7 ... 
> 
> Apologies in advance if I broke something else in the process.

Looks good. Nothing you broke, but I just posted one fix for PMU
interrupts on OMAP2/3 [1]. With this PMU on Tony's master branch is
working fine on OMAP2420 and OMAP3430. I have also verified that PMU is
working on OMAP4460 too.

Cheers
Jon

[1] http://article.gmane.org/gmane.linux.ports.arm.omap/85294
