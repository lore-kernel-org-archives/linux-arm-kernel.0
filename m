From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Wed, 17 Feb 2010 16:07:52 +0900
Subject: PL-330 DMA driver
In-Reply-To: <1b68c6791002162150wb8fbae8ya1e5b3c0a56b7fad@mail.gmail.com>
References: <1b68c6791002162150wb8fbae8ya1e5b3c0a56b7fad@mail.gmail.com>
Message-ID: <4B7B95C8.5070400@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/17/2010 2:50 PM, jassi brar wrote:
> Hello,
> 
>   Many Samsung SoCs have PL-330 as the DMA controller and the driver
> is missing in the mainline.
> 
> A few months ago, Joonyoung Shim of Samsung, attempted the driver for PL-330
> based on the DMA API(drivers/dma/), but the patches weren't accepted.
> Perhaps the driver should go into arch/arm/common/ ? Or inconspicuously
> into arch/arm/plat-s3cxxxx/ ?
> 

First we need a decision about we use which dma api. I think it's better 
we use the DMA API, but i agree about using s3c dma api for
compatibility of the existing s3c dma api too.

> Could maintainers please suggest what is the best place for the PL330
> controller driver?
> 
> Regards
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
