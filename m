From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 9 Feb 2016 09:04:29 +0530
Subject: [PATCH v7 9/9] spi: rockchip: modify DMA max burst to 1
In-Reply-To: <1453460812-8498-10-git-send-email-wxt@rock-chips.com>
References: <1453460812-8498-1-git-send-email-wxt@rock-chips.com>
 <1453460812-8498-10-git-send-email-wxt@rock-chips.com>
Message-ID: <20160209033428.GJ19598@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 22, 2016 at 07:06:52PM +0800, Caesar Wang wrote:
> From: Addy Ke <addy.ke@rock-chips.com>
> 
> Generic dma controller on Rockchips' platform cannot support
> DMAFLUSHP instruction which make dma to flush the req of non-aligned
> or non-multiple of what we need. That will cause an unrecoverable
> dma bus error. The saftest way is to set dma max burst to 1.

Applied, thanks

-- 
~Vinod
