From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 17 Apr 2018 10:50:20 +0200
Subject: [PATCH v2 2/5] ARM: timer-sp: Use of_clk_get_parent_count()
 instead of open coding
In-Reply-To: <1523364701-15383-3-git-send-email-geert+renesas@glider.be>
References: <1523364701-15383-1-git-send-email-geert+renesas@glider.be>
 <1523364701-15383-3-git-send-email-geert+renesas@glider.be>
Message-ID: <20180417085020.GA7214@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2018 at 02:51:38PM +0200, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This depends on "[PATCH v2 1/5] clk: Extract OF clock helpers in
> <linux/of_clk.h>".
> 
> v2:
>   - of_clk_get_parent_count() was moved to <linux/of_clk.h>,
>   - Dropped RFC, as a dummy is now available in the !CONFIG_COMMON_CLK
>     case.
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
