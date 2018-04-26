From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 26 Apr 2018 13:56:00 +0200
Subject: [PATCH v2 2/5] ARM: timer-sp: Use of_clk_get_parent_count()
 instead of open coding
In-Reply-To: <1523364701-15383-3-git-send-email-geert+renesas@glider.be>
References: <1523364701-15383-1-git-send-email-geert+renesas@glider.be>
 <1523364701-15383-3-git-send-email-geert+renesas@glider.be>
Message-ID: <CACRpkdZdiVhZcfJU67i+innQimcR48Zq6uRB42c57Vx1G204jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2018 at 2:51 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This depends on "[PATCH v2 1/5] clk: Extract OF clock helpers in
> <linux/of_clk.h>".
>
> v2:
>   - of_clk_get_parent_count() was moved to <linux/of_clk.h>,
>   - Dropped RFC, as a dummy is now available in the !CONFIG_COMMON_CLK
>     case.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
