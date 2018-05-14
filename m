From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 14 May 2018 23:26:09 +0200
Subject: [PATCH 07/12] of/platform: provide a separate routine for setting
 up device resources
In-Reply-To: <20180511162028.20616-8-brgl@bgdev.pl>
References: <20180511162028.20616-1-brgl@bgdev.pl>
 <20180511162028.20616-8-brgl@bgdev.pl>
Message-ID: <CAMuHMdU8vU=wHDfrSA4Y_cM9GgrY-ERH=9C1mvoAy9EzhRsjOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2018 at 6:20 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> The early platform driver framework will need to setup the device
> resources before the regular populating of the device tree happens.
>
> Provide a separate function for that.
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
