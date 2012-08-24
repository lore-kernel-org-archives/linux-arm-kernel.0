From: will.deacon@arm.com (Will Deacon)
Date: Fri, 24 Aug 2012 09:54:41 +0100
Subject: Cortex A9 with ACP needing mixed coherency model
In-Reply-To: <CAB9O=CPx2PKjyWiKa6B+MJnO0G=805Gb_rnjULb+xw1YOZjCyQ@mail.gmail.com>
References: <CAB9O=CPx2PKjyWiKa6B+MJnO0G=805Gb_rnjULb+xw1YOZjCyQ@mail.gmail.com>
Message-ID: <20120824085440.GC5400@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 24, 2012 at 01:58:50AM +0100, John Linn wrote:
> It doesn't look like there's any good way to have a mixed coherency
> model to support using the ACP where there is coherency and using
> other ports where there is not coherency.
> ARM Linux kernel can support arch_is_coherent(), which means all DMA
> I/O is coherent. We have multiple DMA engines and they can go to thru
> coherent or non-coherent ports.
> 
> Am I missing something, or has someone figured out a way to deal with this?

Didn't Rob have a crack at fixing this with his recent DMA series?

  http://lists.infradead.org/pipermail/linux-arm-kernel/2012-August/113929.html

It's a really nice set of patches, so take a look.

Will
