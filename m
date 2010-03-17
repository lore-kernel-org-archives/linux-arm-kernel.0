From: budheej@gmail.com (Budhee Jamaich)
Date: Wed, 17 Mar 2010 11:09:03 +0200
Subject: mapping uncached memory
In-Reply-To: <20100317081520.GA15954@n2100.arm.linux.org.uk>
References: <57314e841003161617l53dc3a50la969369f0161ccdd@mail.gmail.com>
	<20100316235422.GC13948@n2100.arm.linux.org.uk>
	<57314e841003170102y2b2634f1na9c18282f344d3c2@mail.gmail.com>
	<20100317081520.GA15954@n2100.arm.linux.org.uk>
Message-ID: <57314e841003170209q669735fcid63331697f393794@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 17, 2010 at 10:15 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> No - if it did, it would contradict the previous sentence. ?What it's
> referring to is that on weakly ordered CPUs, you may need barriers.
>

thank you so much.

can you please just give me a hint so i can understand the underlying
mechanism that makes  dma_alloc_coherent work ?
how does the hardware know not to cache access to these addresses ?

again thank you so much
