From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Mar 2013 15:02:24 +0000
Subject: [PATCH v2 4/4] dmaengine: dw_dmac: simplify master selection
In-Reply-To: <1364309637-25860-5-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1364309637-25860-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1364309637-25860-5-git-send-email-andriy.shevchenko@linux.intel.com>
Message-ID: <201303261502.24982.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 March 2013, Andy Shevchenko wrote:
> 
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The patch to add the common DMA binding added a dummy dw_dma_slave
> structure into the dw_dma_chan structure in order to configure the
> masters correctly. It turns out that this can be simplified if we
> pick the DMA masters in the dwc_alloc_chan_resources function instead
> and save them in the dw_dma_chan structure directly.
> 
> This could be simplified further once all users that today use
> dw_dma_slave for configuration get converted to device tree based
> setup instead.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-arm-kernel at lists.infradead.org

Acked-by: Arnd Bergmann <arnd@arndb.de>
