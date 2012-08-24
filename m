From: johnhlinn@gmail.com (John Linn)
Date: Thu, 23 Aug 2012 17:58:50 -0700
Subject: Cortex A9 with ACP needing mixed coherency model
Message-ID: <CAB9O=CPx2PKjyWiKa6B+MJnO0G=805Gb_rnjULb+xw1YOZjCyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It doesn't look like there's any good way to have a mixed coherency
model to support using the ACP where there is coherency and using
other ports where there is not coherency.
ARM Linux kernel can support arch_is_coherent(), which means all DMA
I/O is coherent. We have multiple DMA engines and they can go to thru
coherent or non-coherent ports.

Am I missing something, or has someone figured out a way to deal with this?

Thanks,
John
