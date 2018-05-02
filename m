From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 02 May 2018 08:38:39 -0700
Subject: [PATCH v3 1/5] clk: Extract OF clock helpers in <linux/of_clk.h>
In-Reply-To: <1524063005-1716-2-git-send-email-geert+renesas@glider.be>
References: <1524063005-1716-1-git-send-email-geert+renesas@glider.be>
 <1524063005-1716-2-git-send-email-geert+renesas@glider.be>
Message-ID: <152527551948.138124.11345269390915156871@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Geert Uytterhoeven (2018-04-18 07:50:01)
> The use of of_clk_get_parent_{count,name}() and of_clk_init() is not
> limited to clock providers.
> 
> Hence move these helpers into their own header file, so callers that are
> not clock providers no longer have to include <linux/clk-provider.h>.
> 
> Suggested-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> ---

Applied to clk-next
