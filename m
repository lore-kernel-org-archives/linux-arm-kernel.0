From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 14 May 2018 23:25:46 +0200
Subject: [PATCH 06/12] of: add a new flag for OF device nodes
In-Reply-To: <20180511162028.20616-7-brgl@bgdev.pl>
References: <20180511162028.20616-1-brgl@bgdev.pl>
 <20180511162028.20616-7-brgl@bgdev.pl>
Message-ID: <CAMuHMdWbmdGWz_h_77iHX6=ooadOHsiCMo1-iH33qw-4wZO4CQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2018 at 6:20 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> This flag indicates that a device node has been populated early and
> that it needs different handling when called from
> of_platform_populate().
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
