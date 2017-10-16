From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 16 Oct 2017 12:32:17 +0530
Subject: [PATCH v4 07/11] dmaengine: sun6i: Retrieve channel count/max
 request from devicetree
In-Reply-To: <6277478a-601a-48b0-8e1f-1d309049d4f4@rwthex-w2-a.rwth-ad.de>
References: <20170928014928.2272-1-stefan.bruens@rwth-aachen.de>
 <6277478a-601a-48b0-8e1f-1d309049d4f4@rwthex-w2-a.rwth-ad.de>
Message-ID: <20171016070217.GO30097@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 28, 2017 at 03:49:24AM +0200, Stefan Br?ns wrote:
> To avoid introduction of a new compatible for each small SoC/DMA controller
> variation, move the definition of the channel count to the devicetree.
> 
> The number of vchans is no longer explicit, but limited by the highest
> port/DMA request number. The result is a slight overallocation for SoCs
> with a sparse port mapping.

This doesnt apply for me, please check

-- 
~Vinod
