From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 13 Nov 2018 11:31:02 +0100
Subject: [PATCH v3 5/6] spi: pxa2xx: Add ready signal
In-Reply-To: <20181113102228.820214-6-lkundrak@v3.sk>
References: <20181113102228.820214-1-lkundrak@v3.sk>
 <20181113102228.820214-6-lkundrak@v3.sk>
Message-ID: <CAMuHMdV-WvoFN_JOj46fA5st2o3CrX7VK0qQ2rSo+cgFoMD5+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 13, 2018 at 11:23 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
> Strobe a GPIO line when the slave TX FIFO is filled. This is how the
> Embedded Controller on an OLPC XO-1.75 machine, that happens to be a SPI
> master, learns that it can initiate a transaction.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Tested-by: Pavel Machek <pavel@ucw.cz>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
