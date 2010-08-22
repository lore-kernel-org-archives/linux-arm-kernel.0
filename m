From: post@hendrik-sattler.de (Hendrik Sattler)
Date: Sun, 22 Aug 2010 17:52:03 +0200
Subject: ixp4xx support in newer kernels
In-Reply-To: <m3wrrmr0tb.fsf@intrepid.localdomain>
References: <AANLkTin-A2ubhzsn0DGD2vWn1RxougLV=4V-CS3VcNWe@mail.gmail.com>
	<m3wrrmr0tb.fsf@intrepid.localdomain>
Message-ID: <201008221752.03624.post@hendrik-sattler.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag 19 August 2010, 19:04:32 schrieb Krzysztof Halasa:
> Hi,
> 
> y bhanu <kernelccrazy@gmail.com> writes:
> > I am starting off on a new project with ixp4xx based chip.
> > I already have it working in 2.6.19 kernel.
> > How well are ixp432/ixp435 chips supported in new kernels.
> > I would like to move it to 2.6.35 kernel.
> > 
> > If I want to look at the latest patched for IXP4xx, is there good spot
> > to look at ( gitweb or URL).
> 
> They should work fine, except possibly a problem with "coherent" memory
> allocations, which is being worked on, and for which a usable patch is
> available.

And the USB gadget driver, had a working patch and it was never applied. 
Search the archieves.

HS
