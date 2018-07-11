From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 11 Jul 2018 11:11:24 +0200
Subject: [PATCH v5 12/22] ARM: sun7i-a20: Add support for the C1 SRAM
 region with the SRAM controller
In-Reply-To: <20180710080114.31469-13-paul.kocialkowski@bootlin.com>
References: <20180710080114.31469-1-paul.kocialkowski@bootlin.com>
 <20180710080114.31469-13-paul.kocialkowski@bootlin.com>
Message-ID: <20180711091124.v7jl7m7zm7hplxkx@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2018 at 10:01:04AM +0200, Paul Kocialkowski wrote:
> From: Maxime Ripard <maxime.ripard@bootlin.com>
> 
> This adds support for the C1 SRAM region (to be used with the SRAM
> controller driver) for the A20 platform. The region is shared
> between the Video Engine and the CPU.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Fixed the SRAM size and applied.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180711/5a756ef9/attachment.sig>
