From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 17 Feb 2017 16:43:41 +0100
Subject: [PATCH 0/8] ARM: sun8i: a33: Mali improvements
In-Reply-To: <2cecfc48-576f-3888-08aa-1fe2edc3c752@math.uni-bielefeld.de>
References: <10fd28cb-269a-ec38-ecfb-b7c86be3e716@math.uni-bielefeld.de>
 <20170216184524.cxcy2ux37yrwutla@lukather>
 <2cecfc48-576f-3888-08aa-1fe2edc3c752@math.uni-bielefeld.de>
Message-ID: <20170217154341.vn7uqvdaijtrj64s@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2017 at 01:45:44PM +0100, Tobias Jakobi wrote:
> Hello Maxime,
> 
> Maxime Ripard wrote:
> > Hi,
> > 
> > On Thu, Feb 16, 2017 at 01:43:06PM +0100, Tobias Jakobi wrote:
> >> I was wondering about the following. Wasn't there some strict
> >> requirement about code going upstream, which also included that there
> >> was a full open-source driver stack for it?
> >>
> >> I don't see how this is the case for Mali, neither in the kernel, nor in
> >> userspace. I'm aware that the Mali kernel driver is open-source. But it
> >> is not upstream, maintained out of tree, and won't land upstream in its
> >> current form (no resemblence to a DRM driver at all). And let's not talk
> >> about the userspace part.
> >>
> >> So, why should this be here?
> > 
> > The device tree is a representation of the hardware itself. The state
> > of the driver support doesn't change the hardware you're running on,
> > just like your BIOS/UEFI on x86 won't change the device it reports to
> > Linux based on whether it has a driver for it.
>
> Like Emil already said, the new bindings and the DT entries are solely
> introduced to support a proprietary out-of-tree module.

No. This new binding and the DT entries are solely introduced to
describe a device found in a number of SoCs, just like any other DT
binding we have.

> The current workflow when introducing new DT entries is the following:
> - upstream a driver that uses the entries
> - THEN add the new entries

And that's never been the preferred workflow, for *any* patches.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170217/8cdb7cbf/attachment.sig>
