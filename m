From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 4 Feb 2016 13:05:07 +0100
Subject: [PATCH v4] clk: sunxi: Refactor A31 PLL6 so that it can be reused
In-Reply-To: <1454358000-13594-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1454358000-13594-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20160204120507.GC4270@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 01, 2016 at 09:20:00PM +0100, Maxime Ripard wrote:
> Remove the fixed dividers from the PLL6 driver to be able to have a
> reusable driver that can be used across several SoCs that share the same
> controller, but don't have the same set of dividers for this clock, and to
> also be reused multiple times in the same SoC, since we're droping the
> clock name.
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160204/92ce1654/attachment.sig>
