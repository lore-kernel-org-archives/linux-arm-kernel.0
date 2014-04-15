From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 15 Apr 2014 18:11:51 +0200
Subject: [PATCH] clk: shmobile: clk-mstp: change to using clock-indices
In-Reply-To: <1397577994-12061-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1397577994-12061-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <CAMuHMdXfFi5xaR0diobn5C5-v104CaW-DQ=sFhEqmQ61QfVRGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

On Tue, Apr 15, 2014 at 6:06 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> With the addition of clock-indices, we need to change the renesas
> clock implementation to use these instead of the local definition
> of "renesas,clock-indices".
>
> Since this will break booting with older device trees, we add a
> simple auto-detection of which properties are present.

Thanks for your patch!

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
