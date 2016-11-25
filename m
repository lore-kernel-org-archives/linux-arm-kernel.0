From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 25 Nov 2016 13:58:19 +0100
Subject: [PATCH v2 6/8] ASoC: sun4i-codec: Add support for H3 codec
In-Reply-To: <20161125123442.28410-7-wens@csie.org>
References: <20161125123442.28410-1-wens@csie.org>
 <20161125123442.28410-7-wens@csie.org>
Message-ID: <20161125125819.2tillw7khiu42epe@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 25, 2016 at 08:34:40PM +0800, Chen-Yu Tsai wrote:
> The codec on the H3 is similar to the one found on the A31. One key
> difference is the analog path controls are routed through the PRCM
> block. This is supported by the sun8i-codec-analog driver, and tied
> into this codec driver with the audio card's aux_dev.
> 
> In addition, the H3 has no HP (headphone) and HBIAS support, and no
> MIC3 input. The FIFO related registers are slightly rearranged.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Acked-by: Rob Herring <robh@kernel.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161125/1b113a91/attachment.sig>
