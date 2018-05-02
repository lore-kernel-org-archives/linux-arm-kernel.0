From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 02 May 2018 08:38:53 -0700
Subject: [PATCH v3 5/5] pinctrl: sunxi: Use of_clk_get_parent_count()
 instead of open coding
In-Reply-To: <1524063005-1716-6-git-send-email-geert+renesas@glider.be>
References: <1524063005-1716-1-git-send-email-geert+renesas@glider.be>
 <1524063005-1716-6-git-send-email-geert+renesas@glider.be>
Message-ID: <152527553396.138124.11939404292726432804@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Geert Uytterhoeven (2018-04-18 07:50:05)
> A new open coder has crept in since 470b73a38470e8ba ("pinctrl: sunxi:
> Use of_clk_get_parent_count() instead of open coding"), replace it.
> 
> of_clk_get_parent_count() was moved to <linux/of_clk.h>, so include that
> instead of <linux/clk-provider.h>.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---

Applied to clk-next
