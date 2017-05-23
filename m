From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 23 May 2017 21:25:40 +0200
Subject: [PATCH] arm: dts: r7s72100: Add support for GR-Peach
In-Reply-To: <1495567254-10226-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1495567254-10226-1-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <CAMuHMdUovD=6YfJYckoftWyJZ3eRjcKFkScj=wLhyTDSFPavgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 23, 2017 at 9:20 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> Add device tree source for Renesas GR-Peach board.
> GR-Peach is an RZ/A1H based board with 10MB of on-chip SRAM and 8MB
> QSPI flash storage.
> Add support for the board, and create a 2MB partition to use as rootfs.
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
