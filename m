From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 02 Mar 2013 22:23:40 +0000
Subject: [PATCH v2 3/4] spi: s3c64xx: add dma maxburst size initialization
In-Reply-To: <001b01ce10d3$e9f78620$bde69260$%kim@samsung.com>
References: <001b01ce10d3$e9f78620$bde69260$%kim@samsung.com>
Message-ID: <20130302222340.6C4E13E2499@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 22 Feb 2013 17:09:18 +0900, Boojin Kim <boojin.kim@samsung.com> wrote:
> This patch adds dma maxburst size initialization.
> The maxburst should be set by MODE_CFGn.DMA_TYPE,
> because the pl330 dma driver supports burst mode.
> 
> Signed-off-by: Hyeonkook Kim <hk619.kim@samsung.com>

Applied, thanks.

g.
