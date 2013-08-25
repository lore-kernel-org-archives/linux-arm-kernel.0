From: vinod.koul@intel.com (Vinod Koul)
Date: Sun, 25 Aug 2013 16:24:25 +0530
Subject: [patch] dmaengine: ste_dma40: off by one in d40_of_probe()
In-Reply-To: <20130823092343.GF31293@elgon.mountain>
References: <20130823092343.GF31293@elgon.mountain>
Message-ID: <20130825105425.GA2748@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 23, 2013 at 12:23:43PM +0300, Dan Carpenter wrote:
> If "num_disabled" is equal to STEDMA40_MAX_PHYS (32) then we would write
> one space beyond the end of the pdata->disable_channels[] array.
Applied, thanks

~Vinod
