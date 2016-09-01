From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 1 Sep 2016 21:35:15 +0200
Subject: [PATCH 1/3] ARM: dts: r7s72100: add ethernet clock to device tree
In-Reply-To: <20160901155430.23400-1-chris.brandt@renesas.com>
References: <20160901155430.23400-1-chris.brandt@renesas.com>
Message-ID: <CAMuHMdV3iNL_WLrEDUJUcSoRbjx0KVOxrErajF3QdV301bzaQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 1, 2016 at 5:54 PM, Chris Brandt <chris.brandt@renesas.com> wrote:
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

But as Sergei mentioned, the addition of mstp7_clks to the .dtsi really belongs
in this patch.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
