From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 8 Jan 2018 16:25:15 +0530
Subject: [PATCH v2 2/4] dmaengine: xilinx_dma: properly configure the SG
 mode bit in the driver for cdma
In-Reply-To: <1514961731-1916-3-git-send-email-appanad@xilinx.com>
References: <1514961731-1916-1-git-send-email-appanad@xilinx.com>
 <1514961731-1916-3-git-send-email-appanad@xilinx.com>
Message-ID: <20180108105515.GG18649@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 03, 2018 at 12:12:09PM +0530, Kedareswara rao Appana wrote:
> If the hardware is configured for Scatter Gather(SG) mode,
> and hardware is idle, in the control register SG mode bit
> must be set to a 0 then back to 1 by the software, to force
> the CDMA SG engine to use a new value written to the CURDESC_PNTR
> register, failure to do so could result errors from the dmaengine.

Applied 2-4, thanks

-- 
~Vinod
