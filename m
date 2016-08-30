From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 30 Aug 2016 21:28:28 +0530
Subject: [PATCH 4/8] dmaengine: sa11x0: unexport sa11x0_dma_filter_fn and
 clean up
In-Reply-To: <E1beKho-0001H5-TA@rmk-PC.armlinux.org.uk>
References: <20160829112540.GF1041@n2100.armlinux.org.uk>
 <E1beKho-0001H5-TA@rmk-PC.armlinux.org.uk>
Message-ID: <20160830155828.GJ9355@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2016 at 12:26:20PM +0100, Russell King wrote:
> As we now have no users of sa11x0_dma_filter_fn() in the tree, we can
> unexport this function, and remove the now unused header file.

Acked-by: Vinod Koul <vinod.koul@intel.com>


-- 
~Vinod
