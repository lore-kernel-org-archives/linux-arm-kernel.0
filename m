From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 22 Apr 2013 11:18:33 +0100
Subject: [PATCH 17/32] dmaengine: ste_dma40: Remove redundant argument
 from d40_phy_cfg()
In-Reply-To: <20130422093423.GD24632@intel.com>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-18-git-send-email-lee.jones@linaro.org>
 <20130422093423.GD24632@intel.com>
Message-ID: <20130422101833.GI3432@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +	if ((cfg->dir ==  STEDMA40_PERIPH_TO_MEM) ||
> > +	    (cfg->dir == STEDMA40_PERIPH_TO_PERIPH)) {
> Why would you need your own direction defines, I see that there is not much
> diff between these and what dmaengine defines, so perhpas you could use
> those?

I agree. I'll speak to the STE folk.

For this (and other) patch(es), I'll continue to use the STEDMA40 ones
though. Converting everything over to the generic defines should be a
subsequent patch-set IMHO.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
