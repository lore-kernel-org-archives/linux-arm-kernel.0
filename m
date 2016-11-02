From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 2 Nov 2016 14:40:11 +0100
Subject: [PATCH v2 4/4] spi: sun6i: Support Allwinner H3 SPI controller
In-Reply-To: <20161028065412.23008-5-woogyom.kim@gmail.com>
References: <20161028065412.23008-1-woogyom.kim@gmail.com>
 <20161028065412.23008-5-woogyom.kim@gmail.com>
Message-ID: <20161102134011.aotjogti4vl4ebdt@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 28, 2016 at 03:54:12PM +0900, Milo Kim wrote:
> H3 has two SPI controllers. The size of the buffer is 64 * 8.
> (8 bit transfer by 64 entry FIFO)
> A31 has four controllers. The size of the buffer is 128 * 8.
> (8 bit transfer by 128 entry FIFO)
> 
> Register maps are sharable, so sun6i SPI driver is reusable with
> device configuration.
> 
> Use the variable, 'fifo_depth' instead of fixed value to support both SPI
> controllers.
> 
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Milo Kim <woogyom.kim@gmail.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161102/304caca0/attachment.sig>
