From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 29 May 2018 10:48:58 +0200
Subject: [PATCH v2 4/5] clk: renesas: r8a7795: add ccree clock bindings
In-Reply-To: <1527171551-21979-5-git-send-email-gilad@benyossef.com>
References: <1527171551-21979-1-git-send-email-gilad@benyossef.com>
 <1527171551-21979-5-git-send-email-gilad@benyossef.com>
Message-ID: <CAMuHMdVxcnw5Qy4JPo5r-VvgSxDpp==g6sandNeNji+8CgKOqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 24, 2018 at 4:19 PM, Gilad Ben-Yossef <gilad@benyossef.com> wrote:
> This patch adds the clock used by the CryptoCell 630p instance in the SoC.
>
> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Thanks, queueing in clk-renesas-for-v4.19, with "bindings" dropped from the
one-line summary.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
