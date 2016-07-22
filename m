From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 22 Jul 2016 11:01:01 +0200
Subject: [PATCH 3/3] ARM: sunxi: enable big-endian
In-Reply-To: <20160721182329.13478-4-michael.weiser@gmx.de>
References: <20160721182329.13478-1-michael.weiser@gmx.de>
 <20160721182329.13478-4-michael.weiser@gmx.de>
Message-ID: <20160722090101.GB7687@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 21, 2016 at 08:23:29PM +0200, Michael Weiser wrote:
> At least the Cubieboard2 incarnation of sunxi works correctly in
> big-endian mode. Allow the selection of big-endian.
> 
> Signed-off-by: Michael Weiser <michael.weiser@gmx.de>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: linux-arm-kernel at lists.infradead.org

With what devices has it been tested? The one doing DMA will probably
be the one who fail, have you tested the DMA engine? EMAC? GMAC?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160722/0e68325a/attachment.sig>
