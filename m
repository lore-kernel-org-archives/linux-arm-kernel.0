From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 13 Jul 2016 03:23:10 +0200
Subject: [PATCH 2/2] ARM: dts: r8a7792: remove ADSP clock
In-Reply-To: <6927311.Po2EPBmxEp@wasted.cogentembedded.com>
References: <1529351.Fac5N2tKoF@wasted.cogentembedded.com>
 <6927311.Po2EPBmxEp@wasted.cogentembedded.com>
Message-ID: <CAMuHMdVkWPrfA0dc_pS1w2C7AB9mO+D59RiL1RLcFBg9W_tecQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2016 at 11:52 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Simon Horman told  me  that R8A7792 had ADSP clock (based on the most recent

... based on a probably incorrect table in ...

> R-Car gen2 manual) but when I  got that manual as well, this claim proved
> to be false: R8A7792 is the only gen2 SoC that doesn't  have ADSP at all.
> Remove that  clock  for good...
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
