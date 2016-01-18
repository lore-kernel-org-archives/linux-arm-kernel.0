From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 18 Jan 2016 18:15:01 +0100
Subject: [PATCH 1/3] clk: Allow clocks to be marked as CRITICAL
In-Reply-To: <1453127331-20616-2-git-send-email-lee.jones@linaro.org>
References: <1453127331-20616-1-git-send-email-lee.jones@linaro.org>
 <1453127331-20616-2-git-send-email-lee.jones@linaro.org>
Message-ID: <CAMuHMdWoj=MT+-Tb+o6ocy2WKsZ42-ZUmN-Oe4ogNssgToFngw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Mon, Jan 18, 2016 at 3:28 PM, Lee Jones <lee.jones@linaro.org> wrote:
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -31,6 +31,7 @@
>  #define CLK_SET_RATE_NO_REPARENT BIT(7) /* don't re-parent on rate change */
>  #define CLK_GET_ACCURACY_NOCACHE BIT(8) /* do not use the cached clk accuracy */
>  #define CLK_RECALC_NEW_RATES   BIT(9) /* recalc rates after notifications */
> +#define CLK_IS_CRITICAL                BIT(10) /* do not gate, ever */

10 is already taken, even upstream. Please rebase ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
