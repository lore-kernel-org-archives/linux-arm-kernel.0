From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Tue, 17 May 2016 10:54:45 -0400
Subject: [PATCHv6 3/8] dma-mapping: add dma_{map,unmap}_resource
In-Reply-To: <1462812247-3414-4-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1462812247-3414-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <1462812247-3414-4-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Message-ID: <20160517145445.GE4074@char.us.oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>  
> -In some circumstances dma_map_single() and dma_map_page() will fail to create
> -a mapping. A driver can check for these errors by testing the returned
> -DMA address with dma_mapping_error(). A non-zero return value means the mapping
> -could not be created and the driver should take appropriate action (e.g.
> -reduce current DMA mapping usage or delay and try again later).
> +In some circumstances dma_map_single(), dma_map_page() and dma_map_resource()
> +will fail to create a mapping. A driver can check for these errors by testing
> +the returned DMA address with dma_mapping_error(). A non-zero return value
> +means the mapping could not be created and the driver should take appropriate
> +action (e.g. reduce current DMA mapping usage or delay and try again later).

This looks like it belongs to another patch?
