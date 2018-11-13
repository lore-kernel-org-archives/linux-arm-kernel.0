From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 13 Nov 2018 11:28:01 +0100
Subject: [PATCH v3 1/6] spi: pxa2xx: dt-bindings: Add spi-slave property
In-Reply-To: <20181113102228.820214-2-lkundrak@v3.sk>
References: <20181113102228.820214-1-lkundrak@v3.sk>
 <20181113102228.820214-2-lkundrak@v3.sk>
Message-ID: <CAMuHMdW6+LLM+Xf8cqgGcz5a3GZQDTba2bXS=qCC5eu2uwFEHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 13, 2018 at 11:23 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
> This is used to indicate that the chip attached to this controller is a SPI
> master.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Pavel Machek <pavel@ucw.cz>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
