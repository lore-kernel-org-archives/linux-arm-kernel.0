From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 10 Apr 2018 15:01:52 +0200
Subject: [PATCH v2 5/5] pinctrl: sunxi: Use of_clk_get_parent_count()
 instead of open coding
In-Reply-To: <1523364701-15383-6-git-send-email-geert+renesas@glider.be>
References: <1523364701-15383-1-git-send-email-geert+renesas@glider.be>
 <1523364701-15383-6-git-send-email-geert+renesas@glider.be>
Message-ID: <20180410130152.cccquujj7j6asv5b@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2018 at 02:51:41PM +0200, Geert Uytterhoeven wrote:
> A new open coder has crept in since 470b73a38470e8ba ("pinctrl: sunxi:
> Use of_clk_get_parent_count() instead of open coding"), replace it.
> 
> of_clk_get_parent_count() was moved to <linux/of_clk.h>, so include that
> instead of <linux/clk-provider.h>.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180410/d806aba5/attachment.sig>
