From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 24 Aug 2016 08:02:22 +0200
Subject: [PATCH] ARM: dts: sun8i: add NAND controller node for A23/A33
In-Reply-To: <20160823135546.60179-1-icenowy@aosc.xyz>
References: <20160823135546.60179-1-icenowy@aosc.xyz>
Message-ID: <20160824060222.GT2598@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 23, 2016 at 09:55:46PM +0800, Icenowy Zheng wrote:
> A23/A33 has a NAND controller which can now be used properly.
> 
> Add a device node for it.
> 
> The DMA function cannot work because of changed DMA IP block, so it's
> temporarily removed in the device node. However, with PIO mode it can still
> work.

What is preventing the NAND driver to work with DMA with the sun6i driver?

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160824/01124f92/attachment.sig>
