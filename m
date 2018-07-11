From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 11 Jul 2018 11:14:06 +0200
Subject: [PATCH v5 13/22] ARM: sun8i-a23-a33: Add SRAM controller node
 and C1 SRAM region
In-Reply-To: <20180710080114.31469-14-paul.kocialkowski@bootlin.com>
References: <20180710080114.31469-1-paul.kocialkowski@bootlin.com>
 <20180710080114.31469-14-paul.kocialkowski@bootlin.com>
Message-ID: <20180711091405.mkhzamcmimhofryo@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2018 at 10:01:05AM +0200, Paul Kocialkowski wrote:
> From: Maxime Ripard <maxime.ripard@bootlin.com>
> 
> This adds a SRAM controller node for the A23 and A33, with support for
> the C1 SRAM region that is shared between the Video Engine and the CPU.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Fixed the compatible and the commit prefix and applied.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180711/13c6a1c6/attachment.sig>
