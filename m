From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 19 Jan 2015 22:49:11 +0100
Subject: [PATCH v4 1/9] clk: sunxi: Add mod0 and mmc module clock support
 for A80
In-Reply-To: <1421471974-32719-2-git-send-email-wens@csie.org>
References: <1421471974-32719-1-git-send-email-wens@csie.org>
 <1421471974-32719-2-git-send-email-wens@csie.org>
Message-ID: <20150119214911.GK4367@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 17, 2015 at 01:19:26PM +0800, Chen-Yu Tsai wrote:
> The module 0 style clocks, or storage module clocks as named in the
> official SDK, are almost the same as the module 0 clocks on earlier
> Allwinner SoCs. The only difference is wider mux register bits.
> 
> As with earlier Allwinner SoCs, mmc module clocks are a special case
> of mod0 clocks, with phase controls for 2 child clocks, output and
> sample.
> 
> This patch adds support for both.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150119/0847492e/attachment.sig>
