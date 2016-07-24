From: vinod.koul@intel.com (Vinod Koul)
Date: Sun, 24 Jul 2016 11:55:46 +0530
Subject: [PATCH] dmaengine: zynqmp_dma: add missing MODULE_LICENSE
In-Reply-To: <20160719084422.3304865-1-arnd@arndb.de>
References: <20160719084422.3304865-1-arnd@arndb.de>
Message-ID: <20160724062545.GX9681@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2016 at 10:43:49AM +0200, Arnd Bergmann wrote:
> We get a warning about the missing MODULE_LICENSE tag for this newly
> added driver module:
> 
> WARNING: modpost: missing MODULE_LICENSE() in drivers/dma/xilinx/zynqmp_dma.o
> see include/linux/module.h for more information
> 
> This adds a "GPL" license, matching the "version 2 or later" information in
> the comment at the start of the file.

Applied, thanks

-- 
~Vinod
