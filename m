From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 2 Mar 2015 18:18:20 +0100
Subject: [PATCH 02/10] SH: use clkdev_add_table()
In-Reply-To: <E1YSTnH-0001JY-GT@rmk-PC.arm.linux.org.uk>
References: <20150302170538.GQ8656@n2100.arm.linux.org.uk>
 <E1YSTnH-0001JY-GT@rmk-PC.arm.linux.org.uk>
Message-ID: <CAMuHMdWJbLhVgWTqM8mC9AkqUKYYEh2Zv85mWizbHqoZNTxUMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 2, 2015 at 6:06 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> We have always had an efficient way of registering a table of clock
> lookups - it's called clkdev_add_table().  However, some people seem
> to really love writing inefficient and unnecessary code.
>
> Convert SH to use the correct interface.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks, looks good.

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
