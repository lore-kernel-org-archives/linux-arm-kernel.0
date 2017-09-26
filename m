From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 26 Sep 2017 12:02:40 +0200
Subject: [PATCH v2 11/13] drm/sun4i: hdmi: Add support for A31's HDMI
 controller
In-Reply-To: <20170926065919.24446-12-wens@csie.org>
References: <20170926065919.24446-1-wens@csie.org>
 <20170926065919.24446-12-wens@csie.org>
Message-ID: <20170926100240.es6fbqux3kfihd33@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 26, 2017 at 06:59:17AM +0000, Chen-Yu Tsai wrote:
> The HDMI controller found in the A31 SoCs is slightly different
> from the one already supported, which is found in the A10s:
> 
>   - Need different initial values for the PLL related registers
> 
>   - Different behavior of the DDC and TMDS clocks
> 
>   - Different register layout for the DDC portion
> 
>   - Separate DDC parent clock
> 
> This patch adds support for it.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170926/5be92fee/attachment.sig>
