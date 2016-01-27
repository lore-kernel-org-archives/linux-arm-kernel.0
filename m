From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 27 Jan 2016 18:41:25 +0100
Subject: [PATCH RFC 09/11] clk: sunxi: rewrite sun6i-a31-ahb1-clk using
 factors clk with custom recalc
In-Reply-To: <1453727747-23307-10-git-send-email-wens@csie.org>
References: <1453727747-23307-1-git-send-email-wens@csie.org>
 <1453727747-23307-10-git-send-email-wens@csie.org>
Message-ID: <20160127174125.GN4317@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 09:15:45PM +0800, Chen-Yu Tsai wrote:
> The factors clk implementation has been extended to support custom
> recalc callbacks to support clocks that use one factor for certain
> parents only, like a pre-divider.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160127/2ee34ebd/attachment.sig>
