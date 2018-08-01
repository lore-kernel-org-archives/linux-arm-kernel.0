From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 1 Aug 2018 14:16:14 +0200
Subject: [PATCH] ARM: shmobile: gose: Add DA9210 node for CPU DVFS
In-Reply-To: <20180730111726.5526-1-marek.vasut+renesas@gmail.com>
References: <20180730111726.5526-1-marek.vasut+renesas@gmail.com>
Message-ID: <CAMuHMdUop4fUTbgh0iCQRWTNz_X49070qPKZc0iJ9xFvhi9RHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Mon, Jul 30, 2018 at 1:17 PM Marek Vasut <marek.vasut@gmail.com> wrote:
> Add DA9210 DVFS node to the I2C bus and link it to CPU0 for DVFS.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Thanks for your patch!

Oneline-summary prefix should be "ARM: dts: gose:".

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
