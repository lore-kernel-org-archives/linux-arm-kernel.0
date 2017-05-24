From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 24 May 2017 09:45:06 +0530
Subject: [PATCH 1/5 v2] ARM/dma: pl08x: pass reasonable memcpy settings
In-Reply-To: <20170520214254.21541-1-linus.walleij@linaro.org>
References: <20170520214254.21541-1-linus.walleij@linaro.org>
Message-ID: <20170524041506.GW15061@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 20, 2017 at 11:42:50PM +0200, Linus Walleij wrote:
> We cannot use bits from configuration registers as API between
> platforms and driver like this, abstract it out to two enums
> and mimic the stuff passed as device tree data.
> 
> This is done to make it possible for the driver to generate the
> ccfg word on-the-fly so we can support more PL08x derivatives.

Applied, thanks

-- 
~Vinod
