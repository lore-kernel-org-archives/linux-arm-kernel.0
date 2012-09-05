From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 5 Sep 2012 09:40:03 +0800
Subject: [PATCH] mxs/dma: Enlarge the CCW descriptor area to 4 pages
In-Reply-To: <1346731465-6301-1-git-send-email-marex@denx.de>
References: <1346731465-6301-1-git-send-email-marex@denx.de>
Message-ID: <20120905014000.GP2362@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 04, 2012 at 06:04:25AM +0200, Marek Vasut wrote:
> In case of a large SPI flash, the amount of DMA descriptors
> available to the DMA driver is not large enough anymore. For
> example 8MB SPI flash now needs 129 descriptors to be transfered
> in one long read. There are currently 53 descriptors available in
> one PAGE_SIZE-big block. Enlarge the allocated descriptor area to
> four PAGE_SIZE blocks to fulfill such requirements.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Dan Williams <djbw@fb.com>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

Vinod (copied) is the primary maintainer and collecting dma patches now.
