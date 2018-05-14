From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 14 May 2018 23:26:28 +0200
Subject: [PATCH 08/12] of/platform: provide a separate routine for device
 initialization
In-Reply-To: <20180511162028.20616-9-brgl@bgdev.pl>
References: <20180511162028.20616-1-brgl@bgdev.pl>
 <20180511162028.20616-9-brgl@bgdev.pl>
Message-ID: <CAMuHMdX=Fsw=wJ1Gc6RkAcpVaJaFtrmacqhDM4AsjrWwJwX3yA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2018 at 6:20 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> The early platform device framework will need to initialize the
> platform device objects without them being allocated in
> of_device_alloc(). Provide a routine that allows it.
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
