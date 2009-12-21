From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Dec 2009 23:35:08 +0000
Subject: [PATCH] ARM: dmabounce: fix build
In-Reply-To: <4B2DDDD7.9030500@compulab.co.il>
References: <4B2DDDD7.9030500@compulab.co.il>
Message-ID: <20091221233508.GB28541@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 20, 2009 at 10:18:31AM +0200, Mike Rapoport wrote:
> Commit f74f7e57ae9fa12b2951ae62ce3557799b318399 (ARM: use
> flush_kernel_dcache_area() for dmabounce) has broken dmabounce build:
> 
>   CC      arch/arm/common/dmabounce.o
> arch/arm/common/dmabounce.c: In function 'unmap_single':
> arch/arm/common/dmabounce.c:315: error: implicit declaration of function '__cpuc_flush_kernel_dcache_area'
> make[2]: *** [arch/arm/common/dmabounce.o] Error 1
> 
> Fix it.
> 
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>

Ok, can you submit this to the patch system please?  Thanks.
