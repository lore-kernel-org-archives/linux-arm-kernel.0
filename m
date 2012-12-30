From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sun, 30 Dec 2012 11:54:42 +0530
Subject: [PATCH 1/1] arm :omap :DMA: fix a bug on reserving the omap SDMA
 channels
In-Reply-To: <1356813800-4705-1-git-send-email-ahemaily@gmail.com>
References: <1356813800-4705-1-git-send-email-ahemaily@gmail.com>
Message-ID: <50DFDE2A.3070800@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

$subject
s/arm:omap/ARM: OMAP:

On Sunday 30 December 2012 02:13 AM, ahemaily at gmail.com wrote:
> From: ahemaily <ahemaily@gmail.com>
>
> The variable  dma_lch_count  used for comparison  (omap_dma_reserve_channels <= dma_lch_count)
> before it initialized to the value from omap_dma_dev_attr : d->lch_count.
s/it/it is

> I change the place of dma_lch_count initialization to be before the comparison.
>
s/I change the place of dma_lch_count initialization to be before the 
comparison./ Initialize dma_lch_count before it is being used for 
comparison.

> Signed-off-by: Abdelrahman Hemaily <ahemaily@gmail.com>
> ---
Change looks good to my eyes o.w

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
