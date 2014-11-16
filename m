From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 16 Nov 2014 17:57:55 +0100
Subject: [PATCH v3 1/6] clk: sunxi: Specify number of child clocks for
 divs clocks
In-Reply-To: <1415815715-31791-2-git-send-email-wens@csie.org>
References: <1415815715-31791-1-git-send-email-wens@csie.org>
 <1415815715-31791-2-git-send-email-wens@csie.org>
Message-ID: <20141116165755.GJ6414@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 13, 2014 at 02:08:30AM +0800, Chen-Yu Tsai wrote:
> Currently sunxi_divs_clk_setup assumes the number of child clocks
> to be the same as the number of clock-output-names, and a maximum
> of SUNXI_DIVS_MAX_QTY child clocks.
> 
> On sun6i, PLL6 only has 1 child clock, but the parent would be used
> as well, thereby also having it's own clock-output-names entry. This
> results in an extra bogus clock being registered.
> 
> This patch adds an entry for the number of child clocks alongside
> the data structures for them.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141116/72558d4d/attachment.sig>
