From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 21 Oct 2014 21:41:10 +0200
Subject: [PATCH v2 1/5] clk: sunxi: make factors clock mux mask
 configurable
In-Reply-To: <1413814230-13735-2-git-send-email-wens@csie.org>
References: <1413814230-13735-1-git-send-email-wens@csie.org>
 <1413814230-13735-2-git-send-email-wens@csie.org>
Message-ID: <20141021194110.GS21108@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 20, 2014 at 10:10:26PM +0800, Chen-Yu Tsai wrote:
> Some of the factors-style clocks on the A80 have different widths
> for the mux values in the registers.
> 
> Add a .muxmask field to clk_factors_config to make it configurable.
> Passing a bitmask instead of a width parameter will allow reuse
> in case we support table-based muxes in the future.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141021/2799b26d/attachment.sig>
