From: horms@verge.net.au (Simon Horman)
Date: Fri, 27 Sep 2013 13:55:06 +0900
Subject: [PATCH v2 2/2] ARM: shmobile: Marzen: enable DMA for SDHI0
In-Reply-To: <201308252147.27210.sergei.shtylyov@cogentembedded.com>
References: <201308252143.33458.sergei.shtylyov@cogentembedded.com>
 <201308252147.27210.sergei.shtylyov@cogentembedded.com>
Message-ID: <20130927045506.GB23732@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 25, 2013 at 09:47:26PM +0400, Sergei Shtylyov wrote:
> From: Max Filippov <max.filippov@cogentembedded.com>
> 
> Pass HPB-DMA slave IDs in the SDHI0 platform data to enable DMA in the SDHI
> driver.
> 
> Signed-off-by: Max Filippov <max.filippov@cogentembedded.com>
> [Sergei: removed #include <mach/dma.h>]
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Thanks, queued up for v3.13.

Please send along a defconfig update as you mentioned you would yesterday.

Thanks.
