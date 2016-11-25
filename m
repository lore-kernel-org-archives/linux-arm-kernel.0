From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 25 Nov 2016 13:57:54 +0100
Subject: [PATCH v2 2/8] ASoC: sun4i-codec: Add support for A23 codec
In-Reply-To: <20161125123442.28410-3-wens@csie.org>
References: <20161125123442.28410-1-wens@csie.org>
 <20161125123442.28410-3-wens@csie.org>
Message-ID: <20161125125754.ixgtbm5zyztedl7o@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 25, 2016 at 08:34:36PM +0800, Chen-Yu Tsai wrote:
> The codec in the A23 is similar to the one found on the A31. One key
> difference is the analog path controls are routed through the PRCM
> block. This is supported by the sun8i-codec-analog driver, and tied
> into this codec driver with the audio card's aux_dev.
> 
> In addition, the A23 does not have LINEOUT, and it does not support
> headset jack detection or buttons.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Acked-by: Rob Herring <robh@kernel.org>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161125/26d001dd/attachment-0001.sig>
