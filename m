From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 13 Jun 2017 14:35:38 +0200
Subject: [PATCH 01/44] firmware/ivc: use dma_mapping_error
In-Reply-To: <20170608132609.32662-2-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
 <20170608132609.32662-2-hch@lst.de>
Message-ID: <20170613123538.GB16758@ulmo.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 08, 2017 at 03:25:26PM +0200, Christoph Hellwig wrote:
> DMA_ERROR_CODE is not supposed to be used by drivers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/firmware/tegra/ivc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170613/55b3a252/attachment.sig>
