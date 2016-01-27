From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 27 Jan 2016 18:32:46 +0100
Subject: [PATCH RFC 07/11] clk: sunxi: factors: Support custom formulas
In-Reply-To: <1453727747-23307-8-git-send-email-wens@csie.org>
References: <1453727747-23307-1-git-send-email-wens@csie.org>
 <1453727747-23307-8-git-send-email-wens@csie.org>
Message-ID: <20160127173246.GL4317@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 09:15:43PM +0800, Chen-Yu Tsai wrote:
> Some clocks cannot be modelled using the standard factors clk formula,
> such as clocks with special pre-dividers on one parent, or clocks
> with all power-of-two dividers.
> 
> Add support for a custom .recalc callback for factors clk. Also pass
> the current parent index to the .get_factor and .recalc callbacks.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160127/5b2622d0/attachment.sig>
