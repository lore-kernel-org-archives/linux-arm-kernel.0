From: linux@dominikbrodowski.net (Dominik Brodowski)
Date: Wed, 25 Jan 2012 20:40:12 +0100
Subject: [PATCH 00/19] ARM SA11x0 / PXA / SoC-common PCMCIA cleanups
In-Reply-To: <20120120101709.GE1068@n2100.arm.linux.org.uk>
References: <20120120101709.GE1068@n2100.arm.linux.org.uk>
Message-ID: <20120125194012.GC9192@comet.dominikbrodowski.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey,

On Fri, Jan 20, 2012 at 10:17:09AM +0000, Russell King - ARM Linux wrote:
> What follows is a series of 19 patches cleaning up the SA11xx and PXA
> PCMCIA support, which uses the soc-common infrastructure.
> 
> Now that we have proper gpiolib support in the kernel for these platforms,
> with properly implemented gpio_to_irq() functionality, we can move some
> things that the individual platform socket drivers were doing into the
> soc-common core.
> 
> This significantly reduces the code in the platform socket drivers -
> a reduction of around 550 lines, for the net addition of about 50 lines
> to soc-common.
> 
> The final set of five patches in this set contain some minor bug fixes
> (which are really low priority) and cleanup the handling of the SA1111
> build between PXA and SA11x0 platforms.
> 
> Please supply acks; I have other work which touches the header files
> in arch/arm which would conflict, and it would help to keep it together
> rather than have SFR carry those resolutions.

Insofar as it touches generic PCMCIA stuff:

Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
