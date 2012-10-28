From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 28 Oct 2012 20:26:57 +0100
Subject: [PATCH v3 04/11] clk: davinci - add pll divider clock driver
In-Reply-To: <1351181518-11882-5-git-send-email-m-karicheri2@ti.com>
References: <1351181518-11882-1-git-send-email-m-karicheri2@ti.com>
 <1351181518-11882-5-git-send-email-m-karicheri2@ti.com>
Message-ID: <CACRpkdY3ji_twCqej6Yf8grR7oovf3jeGrbQMzybk5CK5f2Y9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 25, 2012 at 6:11 PM, Murali Karicheri <m-karicheri2@ti.com> wrote:

> pll dividers are present in the pll controller of DaVinci and Other
> SoCs that re-uses the same hardware IP. This has a enable bit for
> bypass the divider or enable the driver. This is a sub class of the
> clk-divider clock checks the enable bit to calculare the rate and
> invoke the recalculate() function of the clk-divider if enabled.
>
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>

Looking good,
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
