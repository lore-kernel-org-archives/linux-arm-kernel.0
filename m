From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 29 Sep 2017 10:47:55 +0200
Subject: [PATCH v3 02/14] clk: sunxi-ng: sun6i: Rename HDMI DDC clock to
 avoid name collision
In-Reply-To: <20170929082306.16193-3-wens@csie.org>
References: <20170929082306.16193-1-wens@csie.org>
 <20170929082306.16193-3-wens@csie.org>
Message-ID: <20170929084755.vsbqn4bq6z2n7c64@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 29, 2017 at 08:22:54AM +0000, Chen-Yu Tsai wrote:
> The HDMI DDC clock found in the CCU is the parent of the actual DDC
> clock within the HDMI controller. That clock is also named "hdmi-ddc".
> 
> Rename the one in the CCU to "ddc". This makes more sense than renaming
> the one in the HDMI controller to something else.
> 
> Fixes: c6e6c96d8fa6 ("clk: sunxi-ng: Add A31/A31s clocks")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170929/d70ffdea/attachment-0001.sig>
