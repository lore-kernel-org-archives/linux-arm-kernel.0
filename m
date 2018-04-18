From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 18 Apr 2018 11:36:27 +0200
Subject: [PATCH v6 11/11] ARM: shmobile: Convert file to use cntvoff
In-Reply-To: <20180416215032.5023-12-mylene.josserand@bootlin.com>
References: <20180416215032.5023-1-mylene.josserand@bootlin.com>
 <20180416215032.5023-12-mylene.josserand@bootlin.com>
Message-ID: <CAMuHMdU9soQuNMC59Y2AQdTmXbWBz-P3EFfZ6NYGKukJVukKgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Myl?ne,

On Mon, Apr 16, 2018 at 11:50 PM, Myl?ne Josserand
<mylene.josserand@bootlin.com> wrote:
> Now that a common function is available for CNTVOFF's
> initialization, let's convert shmobile-apmu code to use
> this function.

Thanks for your patch, works fine on Renesas ALT with R-Car E2,
which suffers from lack of CNTVOFF initialization.

> Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
