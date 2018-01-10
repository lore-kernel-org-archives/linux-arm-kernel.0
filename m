From: hch@lst.de (Christoph Hellwig)
Date: Wed, 10 Jan 2018 16:26:17 +0100
Subject: [PATCH 11/33] dma-mapping: move swiotlb arch helpers to a new
 header
In-Reply-To: <3721b4ba-0685-255e-06b9-6e60678a1a92@arm.com>
References: <20180110080027.13879-1-hch@lst.de>
 <20180110080027.13879-12-hch@lst.de>
 <3721b4ba-0685-255e-06b9-6e60678a1a92@arm.com>
Message-ID: <20180110152617.GB17790@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 10, 2018 at 02:56:01PM +0000, Robin Murphy wrote:
> I took a look at these, and it seems their phys_to_dma() usage is doing the 
> thing which we subsequently formalised as dma_map_resource(). I've had a 
> crack at a quick patch to update the CESA driver; qcom_nandc looks slightly 
> more complex in that the changes probably need to span the BAM dmaengine 
> driver as well.

Sounds great, although probably something for the next merge window.

In the meantime does this patch looks good to you?
