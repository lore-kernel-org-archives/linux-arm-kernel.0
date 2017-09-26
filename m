From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 26 Sep 2017 11:32:47 +0200
Subject: [PATCH v2 02/13] clk: sunxi-ng: sun6i: Rename HDMI DDC clock to
 avoid name collision
In-Reply-To: <20170926065919.24446-3-wens@csie.org>
References: <20170926065919.24446-1-wens@csie.org>
 <20170926065919.24446-3-wens@csie.org>
Message-ID: <20170926093247.blcu52dzluqawzb5@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 26, 2017 at 06:59:08AM +0000, Chen-Yu Tsai wrote:
> The HDMI DDC clock found in the CCU is the parent of the actual DDC
> clock within the HDMI controller. That clock is also named "hdmi-ddc".
> 
> Rename the one in the CCU to "hdmi-ddc-parent". This makes more sense
> than renaming the one in the HDMI controller to something else.
> 
> Fixes: c6e6c96d8fa6 ("clk: sunxi-ng: Add A31/A31s clocks")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

I'd rather stick to the datasheet names. What about "DDC" ?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170926/58f42cbf/attachment.sig>
