From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 6 Jun 2017 20:47:13 +0200
Subject: [PATCH 00/10] irqchip: sunxi-nmi: Cleanups and fix A31 R_INTC
 register offset
In-Reply-To: <20170606055932.22548-1-wens@csie.org>
References: <20170606055932.22548-1-wens@csie.org>
Message-ID: <20170606184713.4qxvap65o33rkzwz@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 06, 2017 at 01:59:22PM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
> 
> This is an alternative to Icenowy's recent A64 R_INTC patches.
> 
> This is a two part series. The first four patches clean up the existing
> sunxi-nmi driver. Patches five and six add a new "sun6i-a31-r-intc"
> compatible, which mainly adjusts or removes the awkward register region
> offset the old "sun6i-a31-sc-nmi" compatible needed. The remaining
> patches fix or add device nodes for SoC's having this hardware.
> 
> Using "sun6i-a31-r-intc" introduced in this series, instead of Icenowy's
> "sun50i-a64-r-intc" is preferred. This follows our policy of naming
> hardware blocks and compatibles after their first occurrence.
> 
> The first six patches should go through the irqchip tree, while we
> (sunxi) can take the device tree changes after the driver has been
> merged, to avoid breaking linux-next as a whole.

For the whole serie:
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170606/7ea66f24/attachment.sig>
