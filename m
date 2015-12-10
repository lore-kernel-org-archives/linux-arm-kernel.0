From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 10 Dec 2015 09:49:04 +0530
Subject: [PATCH 1/1] dmaengine: at_xdmac: fix at_xdmac_prep_dma_memcpy()
In-Reply-To: <eec3de73336bf67938fab83951c04b33b7dfba49.1449500175.git.cyrille.pitchen@atmel.com>
References: <eec3de73336bf67938fab83951c04b33b7dfba49.1449500175.git.cyrille.pitchen@atmel.com>
Message-ID: <20151210041904.GP1854@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 07, 2015 at 03:58:56PM +0100, Cyrille Pitchen wrote:
> This patch fixes at_xdmac_prep_dma_memcpy(). Indeed the data width field
> of the Channel Configuration register was not updated properly in the
> loop: the bits of the dwidth field were not cleared before adding their
> new value.

Applied, thanks

-- 
~Vinod
