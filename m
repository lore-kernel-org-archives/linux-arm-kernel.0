From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 30 Apr 2018 15:44:20 +0200
Subject: [PATCH v3 4/5] soc/tegra: pmc: Use of_clk_get_parent_count()
 instead of open coding
In-Reply-To: <1524063005-1716-5-git-send-email-geert+renesas@glider.be>
References: <1524063005-1716-1-git-send-email-geert+renesas@glider.be>
 <1524063005-1716-5-git-send-email-geert+renesas@glider.be>
Message-ID: <20180430134420.GE11457@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2018 at 04:50:04PM +0200, Geert Uytterhoeven wrote:
> As of_clk_get_parent_count() returns zero on failure, while
> of_count_phandle_with_args() might return a negative error code, this
> also fixes the issue of possibly using a very big number in the
> allocation below.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> This depends on "[PATCH v3 1/5] clk: Extract OF clock helpers in
> <linux/of_clk.h>".
> 
> v3:
>   - Add Acked-by,
> 
> v2:
>   - of_clk_get_parent_count() was moved to <linux/of_clk.h>.
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>




 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
