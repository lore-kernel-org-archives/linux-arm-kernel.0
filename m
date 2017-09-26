From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 26 Sep 2017 23:04:35 +0530
Subject: [PATCH v2 4/5] dmaengine: zynqmp_ps_pcie: Adding PS PCIe
 platform DMA driver
In-Reply-To: <1504873388-29195-6-git-send-email-vjonnal@xilinx.com>
References: <1504873388-29195-1-git-send-email-vjonnal@xilinx.com>
 <1504873388-29195-6-git-send-email-vjonnal@xilinx.com>
Message-ID: <20170926173435.GS30097@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 08, 2017 at 05:53:07PM +0530, Ravi Shankar Jonnalagadda wrote:
> Platform driver handles transactions for PCIe EP DMA and Root DMA
> 
> Signed-off-by: Ravi Shankar Jonnalagadda <vjonnal@xilinx.com>
> Signed-off-by: RaviKiran Gummaluri <rgummal@xilinx.com>
> ---
>  drivers/dma/xilinx/ps_pcie_platform.c | 3055 +++++++++++++++++++++++++++++++++

I dont want to loose my sanity trying to review a 3k patch. If you don't put
an effort to make your code easier to review, I dont want to see this...

Nacked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
