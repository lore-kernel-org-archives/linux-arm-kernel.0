From: vinod.koul@intel.com (Vinod Koul)
Date: Sun, 11 Mar 2018 20:34:23 +0530
Subject: [PATCH v3] dmaengine: mv_xor_v2: Fix clock resource by adding a
 register clock
In-Reply-To: <20180307154010.10430-1-gregory.clement@bootlin.com>
References: <20180307154010.10430-1-gregory.clement@bootlin.com>
Message-ID: <20180311150423.GC15443@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 07, 2018 at 04:40:10PM +0100, Gregory CLEMENT wrote:
> On the CP110 components which are present on the Armada 7K/8K SoC we need
> to explicitly enable the clock for the registers. However it is not
> needed for the AP8xx component, that's why this clock is optional.
> 
> With this patch both clock have now a name, but in order to be backward
> compatible, the name of the first clock is not used. It allows to still
> use this clock with a device tree using the old binding.

Applied, thanks

-- 
~Vinod
