From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 18 May 2017 09:52:09 +0200
Subject: [PATCH v6 1/9] irqchip/sunxi-nmi: add A64 R_INTC to the binding
 doc
In-Reply-To: <20170518071653.36561-2-icenowy@aosc.io>
References: <20170518071653.36561-1-icenowy@aosc.io>
 <20170518071653.36561-2-icenowy@aosc.io>
Message-ID: <20170518075209.pershxhml7m5u5xr@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 18, 2017 at 03:16:45PM +0800, Icenowy Zheng wrote:
> The A31 NMI driver seems to be using wrong base address.
> 
> As we're going to convert to use a correct NMI base address (and
> correctly name it to R_INTC as the datasheet suggests), add a new
> compatible string for the "correct" R_INTC, which we will use for A64
> SoC.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Acked-by: Rob Herring <robh@kernel.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170518/abd1cbe1/attachment-0001.sig>
