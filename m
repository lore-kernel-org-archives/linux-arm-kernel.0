From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 6 Jul 2011 10:37:37 -0400 (EDT)
Subject: [Linaro-mm-sig] [PATCH 6/8] drivers: add Contiguous Memory
	Allocator
In-Reply-To: <20110706142345.GC8286@n2100.arm.linux.org.uk>
References: <1309851710-3828-1-git-send-email-m.szyprowski@samsung.com>
	<20110705113345.GA8286@n2100.arm.linux.org.uk>
	<006301cc3be4$daab1850$900148f0$%szyprowski@samsung.com>
	<201107061609.29996.arnd@arndb.de>
	<20110706142345.GC8286@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1107061034200.14596@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 Jul 2011, Russell King - ARM Linux wrote:

> Another issue is that when a platform has restricted DMA regions,
> they typically don't fall into the highmem zone.  As the dmabounce
> code allocates from the DMA coherent allocator to provide it with
> guaranteed DMA-able memory, that would be rather inconvenient.

Do we encounter this in practice i.e. do those platforms requiring large 
contiguous allocations motivating this work have such DMA restrictions?


Nicolas
