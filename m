From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 14 May 2018 23:25:03 +0200
Subject: [PATCH 03/12] platform/early: export platform_match() locally
In-Reply-To: <20180511162028.20616-4-brgl@bgdev.pl>
References: <20180511162028.20616-1-brgl@bgdev.pl>
 <20180511162028.20616-4-brgl@bgdev.pl>
Message-ID: <CAMuHMdW+Ma4BE61+U0J5bBaBG6i3Nf9Ei9h0WVzY+gn84469pw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2018 at 6:20 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> We will use this function to match devices in the early platform core
> code. Export it locally in drivers/base.
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
