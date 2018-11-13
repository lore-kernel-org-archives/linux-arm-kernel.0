From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 13 Nov 2018 11:29:25 +0100
Subject: [PATCH v3 4/6] spi: pxa2xx: dt-bindings: Add ready GPIO signal
In-Reply-To: <20181113102228.820214-5-lkundrak@v3.sk>
References: <20181113102228.820214-1-lkundrak@v3.sk>
 <20181113102228.820214-5-lkundrak@v3.sk>
Message-ID: <CAMuHMdU2hJ_htC19jpno_khGombxn-KK+kdQjVMOuJrZWVXV5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 13, 2018 at 11:23 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
> This this is used to let the SPI master know that our FIFO is filled and
> we're ready to service a transfer. Only useful in slave mode.
>
> A signal like this is used by an embedded controller on a OLPC XO 1.75
> machine, that happens to be a SPI master.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Acked-by: Pavel Machek <pavel@ucw.cz>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
