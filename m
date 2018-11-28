From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 28 Nov 2018 19:42:50 +0100
Subject: [PATCH] clk: renesas: Mark rza2_cpg_clk_register static
In-Reply-To: <20181128183702.231609-1-sboyd@kernel.org>
References: <20181128183702.231609-1-sboyd@kernel.org>
Message-ID: <CAMuHMdXk8Uoqw05uEqUvXfzQjdgLHLPEDqVvAMETE6BDDHyybw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 7:37 PM Stephen Boyd <sboyd@kernel.org> wrote:
> This is only used in this file, so mark it static to silence a sparse
> warning.
>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
