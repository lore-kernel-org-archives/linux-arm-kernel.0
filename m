From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 27 Jan 2016 16:50:54 +0100
Subject: [PATCH RFC 02/11] clk: sunxi: factors: Make struct
 clk_factors_config table const
In-Reply-To: <1453727747-23307-3-git-send-email-wens@csie.org>
References: <1453727747-23307-1-git-send-email-wens@csie.org>
 <1453727747-23307-3-git-send-email-wens@csie.org>
Message-ID: <20160127155054.GF4317@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 09:15:38PM +0800, Chen-Yu Tsai wrote:
> struct clk_factors_config contains shifts/widths for the factors of
> the factors clk. This is used to read out the factors from the register
> value. In no case is it written to, so make it const.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160127/971e5d64/attachment.sig>
