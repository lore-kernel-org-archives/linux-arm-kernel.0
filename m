From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 17 Jul 2017 11:14:44 +0200
Subject: [PATCH 04/11] mmc: sunxi: Keep default timing phase settings for
 new timing mode
In-Reply-To: <20170714064302.20383-5-wens@csie.org>
References: <20170714064302.20383-1-wens@csie.org>
 <20170714064302.20383-5-wens@csie.org>
Message-ID: <20170717091444.7yd2rcx3qdx35rmf@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 14, 2017 at 02:42:55PM +0800, Chen-Yu Tsai wrote:
> The register for the "new timing mode" also has bit fields for setting
> output and sample timing phases. According to comments in Allwinner's
> BSP kernel, the default values are good enough.
> 
> Keep the default values already in the hardware when setting new timing
> mode, instead of overwriting the whole register.
> 
> Fixes: 9a37e53e451e ("mmc: sunxi: Enable the new timings for the A64 MMC
> 		      controllers")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170717/175d464b/attachment.sig>
