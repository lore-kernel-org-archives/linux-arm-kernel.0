From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 14 Apr 2016 15:33:45 +0200
Subject: [PATCH 1/2] dt-bindings: pci: add DT binding for Marvell Armada
 7K/8K PCIe controller
In-Reply-To: <5192758.5yjNn0Uus9@wuerfel>
References: <1459071058-18328-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1459071058-18328-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <5192758.5yjNn0Uus9@wuerfel>
Message-ID: <20160414153345.31b04824@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On Mon, 28 Mar 2016 23:18:02 +0200, Arnd Bergmann wrote:
> On Sunday 27 March 2016 11:30:57 Thomas Petazzoni wrote:
> > +               ranges = <0x81000000 0 0xf9000000 0  0xf9000000 0 0x10000       /* downstream I/O */
> > +                         0x82000000 0 0xf6000000 0  0xf6000000 0 0xf00000>;    /* non-prefetchable memory */
> > 
> 
> No 64-bit (prefetchable) MMIO area? Is this a hardware limitation,
> or did you just forget to add it?

I don't have enough technical documentation at the moment to answer the
question. Would it be possible to merge this as-is, and update it later
on when we have enough information about 64-bit MMIO area support? It
does not affect this new DT binding, since it's purely related to the
standard PCI binding.

Would this be OK? I'd prefer to have PCI supported with just the 32
bits non-prefetchable memory rather than no PCI supported at all.

Thanks a lot!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
