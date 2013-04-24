From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 24 Apr 2013 09:55:07 +0100
Subject: [PATCH 17/32] dmaengine: ste_dma40: Remove redundant argument
 from d40_phy_cfg()
In-Reply-To: <20130422093423.GD24632@intel.com>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-18-git-send-email-lee.jones@linaro.org>
 <20130422093423.GD24632@intel.com>
Message-ID: <20130424085507.GK17416@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +	if ((cfg->dir ==  STEDMA40_PERIPH_TO_MEM) ||
> > +	    (cfg->dir == STEDMA40_PERIPH_TO_PERIPH)) {
> Why would you need your own direction defines, I see that there is not much
> diff between these and what dmaengine defines, so perhpas you could use
> those?

Same with these ones, subsequent patch?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
