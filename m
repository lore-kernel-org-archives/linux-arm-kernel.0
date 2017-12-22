From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 22 Dec 2017 17:48:17 +0530
Subject: [PATCH] dmaengine: ti-dma-crossbar: Fix event mapping for
 TPCC_EVT_MUX_60_63
In-Reply-To: <20171219105116.24335-1-peter.ujfalusi@ti.com>
References: <20171219105116.24335-1-peter.ujfalusi@ti.com>
Message-ID: <20171222121817.GV18649@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 19, 2017 at 12:51:16PM +0200, Peter Ujfalusi wrote:
> From: Vignesh R <vigneshr@ti.com>
> 
> Register layout of a typical TPCC_EVT_MUX_M_N register is such that the
> lowest numbered event is at the lowest byte address and highest numbered
> event at highest byte address. But TPCC_EVT_MUX_60_63 register layout is
> different,  in that the lowest numbered event is at the highest address
> and highest numbered event is at the lowest address. Therefore, modify
> ti_am335x_xbar_write() to handle TPCC_EVT_MUX_60_63 register
> accordingly.

Applied, thanks

-- 
~Vinod
