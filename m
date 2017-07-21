From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 21 Jul 2017 09:21:16 +0200
Subject: [PATCH v2 05/10] mmc: sunxi: Support MMC DDR52 transfer mode
 with new timing mode
In-Reply-To: <20170720034452.15920-6-wens@csie.org>
References: <20170720034452.15920-1-wens@csie.org>
 <20170720034452.15920-6-wens@csie.org>
Message-ID: <20170721072116.bub4fxqq2zg6kj3t@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 20, 2017 at 11:44:47AM +0800, Chen-Yu Tsai wrote:
> The MMC controller can support DDR52 transfers under the new timing
> mode. According to the BSP kernel, the module clock has to be double
> the card clock, regardless of the bus width. The default timings in
> the hardware can be used.
> 
> This also reworks the code setting the internal divider, getting rid
> of a extra conditional.
> 
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170721/72ae80f0/attachment.sig>
