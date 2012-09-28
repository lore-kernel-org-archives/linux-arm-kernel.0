From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 28 Sep 2012 15:59:49 +0100
Subject: [GIT PULL] MOP500 Audio patches due for ASoC
In-Reply-To: <20120928123743.GE30869@opensource.wolfsonmicro.com>
References: <1348142956-1872-1-git-send-email-lee.jones@linaro.org>
 <20120920125618.GP17666@opensource.wolfsonmicro.com>
 <20120927150119.GD1176@gmail.com>
 <20120928123743.GE30869@opensource.wolfsonmicro.com>
Message-ID: <20120928145949.GA20786@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 28 Sep 2012, Mark Brown wrote:

> On Thu, Sep 27, 2012 at 04:01:19PM +0100, Lee Jones wrote:
> 
> > Is there any reason why the following patches didn't make it into -next?
> 
> > ASoC: codecs: Enable AB8500 CODEC for Device Tree
> > ASoC: Ux500: Enable ux500 MSP driver for Device Tree
> 
> They appear to be there, there's certainly no reason why they'd be any
> different to the rest of the series.

Okay, I see what's happened. When I rebased the patches I had in my local
delta git just reapplied the commits instead of throwing them out. I can
confirm that the patches above have been applied to -next after all.

Thanks again,
Lee 

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
