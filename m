From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 14 May 2018 23:24:23 +0200
Subject: [PATCH 01/12] platform/early: add a new field to struct device
In-Reply-To: <20180511162028.20616-2-brgl@bgdev.pl>
References: <20180511162028.20616-1-brgl@bgdev.pl>
 <20180511162028.20616-2-brgl@bgdev.pl>
Message-ID: <CAMuHMdX-QbDTgzpeigMQmHe3LmBQL3DCWXN2=zDqohHm2tpUWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2018 at 6:20 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Add a new single-bit field to struct device which will be used to
> indicate that a device was probed early in the boot sequence.
>
> This does not affect the size of struct device on any architecture
> I built on (ARM, ARM64, x86_64).
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
