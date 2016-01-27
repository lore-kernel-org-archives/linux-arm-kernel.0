From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 27 Jan 2016 18:49:32 +0100
Subject: [PATCH RFC 11/11] clk: sunxi: rewrite sun8i-a23-mbus-clk using
 the simpler composite clk
In-Reply-To: <1453727747-23307-12-git-send-email-wens@csie.org>
References: <1453727747-23307-1-git-send-email-wens@csie.org>
 <1453727747-23307-12-git-send-email-wens@csie.org>
Message-ID: <20160127174932.GP4317@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 09:15:47PM +0800, Chen-Yu Tsai wrote:
> sun8i-a23-mbus-clk used sunxi's factors clk, which is nice for very
> complicated clocks, but is not really needed here.
> 
> Convert sun8i-a23-mbus-clk to use clk_composite, as it is a gate + mux
> + divider. This makes the code easier to understand.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160127/bbe0d487/attachment-0001.sig>
