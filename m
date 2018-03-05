From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 5 Mar 2018 11:24:18 +0100
Subject: [PATCH 4/5] arm64: dts: renesas: r8a7796: Add cpu
 capacity-dmips-mhz
In-Reply-To: <1519697995-6061-5-git-send-email-gaku.inami.xh@renesas.com>
References: <1519697995-6061-1-git-send-email-gaku.inami.xh@renesas.com>
 <1519697995-6061-5-git-send-email-gaku.inami.xh@renesas.com>
Message-ID: <CAMuHMdWpUJXvuFpTzE0t3ysLEC8exa169J64H2Q0w4NH_+k=gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Inami-san,

On Tue, Feb 27, 2018 at 3:19 AM, Gaku Inami <gaku.inami.xh@renesas.com> wrote:
> Set the capacity-dmips-mhz for r8a7796, that is based on dhrystone.
>
> Expected cpu capacity:
> Cortex-A57 at 1.5Ghz: 1024, Cortex-A53 at 1.2GHz: 411

Thanks for your patch!

> Signed-off-by: Gaku Inami <gaku.inami.xh@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

But same comment as for r8a7795.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
