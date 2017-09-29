From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 29 Sep 2017 10:46:58 +0200
Subject: [PATCH v3 01/14] clk: sunxi-ng: sun6i: Export video PLLs
In-Reply-To: <20170929082306.16193-2-wens@csie.org>
References: <20170929082306.16193-1-wens@csie.org>
 <20170929082306.16193-2-wens@csie.org>
Message-ID: <20170929084658.la46onmwcibicd4b@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 29, 2017 at 08:22:53AM +0000, Chen-Yu Tsai wrote:
> The 2x outputs of the 2 video PLL clocks are directly used by the
> HDMI controller block.
> 
> Export them so they can be referenced in the device tree.
> 
> Fixes: c6e6c96d8fa6 ("clk: sunxi-ng: Add A31/A31s clocks")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170929/0fdb4054/attachment.sig>
