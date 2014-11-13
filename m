From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 13 Nov 2014 20:39:33 +0100
Subject: [PATCH v6] simplefb: add clock handling code
In-Reply-To: <1415906546-2408-1-git-send-email-hdegoede@redhat.com>
References: <1415906546-2408-1-git-send-email-hdegoede@redhat.com>
Message-ID: <CAMuHMdW-6Eb9DSE=JQm7xWMhJUpt1xxLqS=6KU+=ZDMsmtiBag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 13, 2014 at 8:22 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> changes in v6:
> -Wrap the clock code in #ifdef CONFIG_OF, as simplefb is used on non
>  devicetree platforms too

With clocks?

If yes, "clk_get(&pdev->dev, NULL)" can return a clock...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
