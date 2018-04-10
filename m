From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 10 Apr 2018 15:15:24 +0200
Subject: [PATCH v2 1/5] clk: Extract OF clock helpers in <linux/of_clk.h>
In-Reply-To: <1523364701-15383-2-git-send-email-geert+renesas@glider.be>
References: <1523364701-15383-1-git-send-email-geert+renesas@glider.be>
 <1523364701-15383-2-git-send-email-geert+renesas@glider.be>
Message-ID: <15715859.glpt2iY6pm@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 10. April 2018, 14:51:37 CEST schrieb Geert Uytterhoeven:
> The use of of_clk_get_parent_{count,name}() and of_clk_init() is not
> limited to clock providers.
> 
> Hence move these helpers into their own header file, so callers that are
> not clock providers no longer have to include <linux/clk-provider.h>.
> 
> Suggested-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Really cool move,
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
