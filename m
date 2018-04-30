From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 30 Apr 2018 15:46:30 +0200
Subject: [PATCH v3 5/5] pinctrl: sunxi: Use of_clk_get_parent_count()
 instead of open coding
In-Reply-To: <1524063005-1716-6-git-send-email-geert+renesas@glider.be>
References: <1524063005-1716-1-git-send-email-geert+renesas@glider.be>
 <1524063005-1716-6-git-send-email-geert+renesas@glider.be>
Message-ID: <20180430134630.GF11457@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2018 at 04:50:05PM +0200, Geert Uytterhoeven wrote:
> A new open coder has crept in since 470b73a38470e8ba ("pinctrl: sunxi:
> Use of_clk_get_parent_count() instead of open coding"), replace it.
> 
> of_clk_get_parent_count() was moved to <linux/of_clk.h>, so include that
> instead of <linux/clk-provider.h>.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
> This depends on "[PATCH v3 1/5] clk: Extract OF clock helpers in
> <linux/of_clk.h>".
> 
> v3:
>   - Add Acked-by,
> 
> v2:
>   - New.
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
