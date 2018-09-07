From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 7 Sep 2018 10:21:03 +0200
Subject: [PATCH] clk: sunxi-ng: sun4i: Set VCO and PLL bias current to
 lowest setting
In-Reply-To: <20180906132537.20772-1-wens@csie.org>
References: <20180906132537.20772-1-wens@csie.org>
Message-ID: <20180907082103.lyuubyqpojehtkz4@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 06, 2018 at 09:25:37PM +0800, Chen-Yu Tsai wrote:
> The default mid-level PLL bias current setting interferes with sigma
> delta modulation. This manifests as decreased audio quality at lower
> sampling rates, which sounds like radio broadcast quality, and
> distortion noises at sampling rates at 48 kHz or above.
> 
> Changing the bias current settings to the lowest gets rid of the
> noise.
> 
> Fixes: de3448519194 ("clk: sunxi-ng: sun4i: Use sigma-delta modulation
> 		      for audio PLL")
> Cc: <stable@vger.kernel.org> # 4.15.x
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180907/3af44284/attachment.sig>
