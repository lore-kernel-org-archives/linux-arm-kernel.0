From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Fri, 08 Mar 2013 15:19:45 +0200
Subject: [PATCH 07/12] mtd: gpmi: move to use generic DMA helper
In-Reply-To: <1361978748-25281-8-git-send-email-shawn.guo@linaro.org>
References: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
 <1361978748-25281-8-git-send-email-shawn.guo@linaro.org>
Message-ID: <1362748785.5101.4.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-02-27 at 23:25 +0800, Shawn Guo wrote:
> With the generic DMA device tree helper supported by mxs-dma driver,
> client devices only need to call dma_request_slave_channel() for
> requesting a DMA channel from dmaengine.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Artem Bityutskiy <dedekind1@gmail.com>
> Cc: linux-mtd at lists.infradead.org

It looks like this ne is rather independent and can go via the MTD tree.
So pushed this one to l2-mtd.git - let me know if I am confused. Thanks!

-- 
Best Regards,
Artem Bityutskiy
