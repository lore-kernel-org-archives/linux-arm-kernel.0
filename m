From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 7 Sep 2012 11:36:13 +0100
Subject: [PATCH] DMA: get current descriptor data transfer count
In-Reply-To: <E8F7C03B253D5640818937FAAE6B175C39CD07B5@penmbx02>
References: <E8F7C03B253D5640818937FAAE6B175C39CD07B5@penmbx02>
Message-ID: <20120907103613.GE13739@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 07, 2012 at 10:00:44AM +0000, Song, Elen wrote:
> 
> when data transfer by dma, we could know how many data transfered in one descriptor read DMAC_CTRLAx's btsize bit to get dma transfer size in this case, we could know how many data have been transfered even transaction timeout
> 
> Signed-off-by: Elen Song <elen.song@atmel.com>

NAK, please use the established API for this.
