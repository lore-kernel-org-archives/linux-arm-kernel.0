From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 25 Aug 2016 22:53:43 +0200
Subject: [PATCH] ARM: dts: sun8i: add NAND controller node for A23/A33
In-Reply-To: <16141472026895@web4j.yandex.ru>
References: <20160823135546.60179-1-icenowy@aosc.xyz>
 <20160824060222.GT2598@lukather> <16141472026895@web4j.yandex.ru>
Message-ID: <20160825205343.GJ32598@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Aug 24, 2016 at 04:21:35PM +0800, Icenowy Zheng wrote:
> Hi Maxime,
> 
> 24.08.2016, 14:02, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> > Hi,
> >
> > On Tue, Aug 23, 2016 at 09:55:46PM +0800, Icenowy Zheng wrote:
> >> ?A23/A33 has a NAND controller which can now be used properly.
> >>
> >> ?Add a device node for it.
> >>
> >> ?The DMA function cannot work because of changed DMA IP block, so it's
> >> ?temporarily removed in the device node. However, with PIO mode it can still
> >> ?work.
> >
> > What is preventing the NAND driver to work with DMA with the sun6i driver?
>
> It seems that under sun6i we should use dedicated rx and tx DMAs, but not a
> "rxtx" DMA.

Ah, I see. I just applied your patch, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160825/b3581fd4/attachment.sig>
