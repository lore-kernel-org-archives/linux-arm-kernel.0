From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 8 Feb 2018 09:03:35 +0100
Subject: [PATCH v4 02/12] clk: sunxi-ng: Use u64 for calculation of nkmp
 rate
In-Reply-To: <20180207211713.3638-3-jernej.skrabec@siol.net>
References: <20180207211713.3638-1-jernej.skrabec@siol.net>
 <20180207211713.3638-3-jernej.skrabec@siol.net>
Message-ID: <20180208080335.uduk2aa6vdkaa5n3@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 07, 2018 at 10:17:03PM +0100, Jernej Skrabec wrote:
> When parent rate is 24MHz and multiplier N >= 180, intermediate clock
> rate doesn't fit in 32 bit variable anymore.
> 
> Because of that, introduce function for calculating clock rate which
> uses 64 bit variable for intermediate result.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180208/7308bd8c/attachment-0001.sig>
