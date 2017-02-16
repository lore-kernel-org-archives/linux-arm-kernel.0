From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 16 Feb 2017 19:45:24 +0100
Subject: [PATCH 0/8] ARM: sun8i: a33: Mali improvements
In-Reply-To: <10fd28cb-269a-ec38-ecfb-b7c86be3e716@math.uni-bielefeld.de>
References: <10fd28cb-269a-ec38-ecfb-b7c86be3e716@math.uni-bielefeld.de>
Message-ID: <20170216184524.cxcy2ux37yrwutla@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Feb 16, 2017 at 01:43:06PM +0100, Tobias Jakobi wrote:
> I was wondering about the following. Wasn't there some strict
> requirement about code going upstream, which also included that there
> was a full open-source driver stack for it?
> 
> I don't see how this is the case for Mali, neither in the kernel, nor in
> userspace. I'm aware that the Mali kernel driver is open-source. But it
> is not upstream, maintained out of tree, and won't land upstream in its
> current form (no resemblence to a DRM driver at all). And let's not talk
> about the userspace part.
> 
> So, why should this be here?

The device tree is a representation of the hardware itself. The state
of the driver support doesn't change the hardware you're running on,
just like your BIOS/UEFI on x86 won't change the device it reports to
Linux based on whether it has a driver for it.

So yes, unfortunately, we don't have a driver upstream at the
moment. But that doesn't prevent us from describing the hardware
accurately.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170216/0f4319a5/attachment-0001.sig>
