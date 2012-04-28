From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sat, 28 Apr 2012 17:21:41 +0200
Subject: [PATCH 5/8] ARM: PCI: get rid of pci_std_swizzle()
In-Reply-To: <E1SNLmC-000811-KT@rmk-PC.arm.linux.org.uk> (Russell King's
 message of "Thu, 26 Apr 2012 11:18:16 +0100")
References: <20120426101626.GE24211@n2100.arm.linux.org.uk>
 <E1SNLmC-000811-KT@rmk-PC.arm.linux.org.uk>
Message-ID: <m34ns39916.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King <rmk+kernel@arm.linux.org.uk> writes:

> Most PCI implementations use the standard PCI swizzle function, which
> handles the well defined behaviour of PCI-to-PCI bridges which can be
> found on cards (eg, four port ethernet cards.)
>
> Rather than having almost every platform specify the standard swizzle
> function, make this the default when no swizzle function is supplied.
> Therefore, a swizzle function only needs to be provided when there is
> something exceptional which needs to be handled.
>
> This gets rid of the swizzle initializer from 47 files, and leaves us
> with just two platforms specifying a swizzle function: ARM Integrator
> and Chalice CATS.

Acked-by: Krzysztof Ha?asa <khc@pm.waw.pl>
