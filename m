From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 26 Sep 2017 11:24:31 +0200
Subject: [PATCH v2 01/13] clk: sunxi-ng: sun6i: Export video PLLs
In-Reply-To: <20170926065919.24446-2-wens@csie.org>
References: <20170926065919.24446-1-wens@csie.org>
 <20170926065919.24446-2-wens@csie.org>
Message-ID: <20170926092431.puk7e5ippmjwfy4x@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 26, 2017 at 06:59:07AM +0000, Chen-Yu Tsai wrote:
> The 2x outputs of the 2 video PLL clocks are directly used by the
> HDMI controller block.
> 
> Export them so they can be referenced in the device tree.
> 
> Fixes: c6e6c96d8fa6 ("clk: sunxi-ng: Add A31/A31s clocks")
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170926/6b033da0/attachment.sig>
