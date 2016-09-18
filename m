From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 18 Sep 2016 10:49:36 +0200
Subject: [RFC PATCH 00/10] ARM: dts: exynos: Fix invalid GIC interrupt
 flags
In-Reply-To: <1474054971-16831-1-git-send-email-krzk@kernel.org>
References: <1474054971-16831-1-git-send-email-krzk@kernel.org>
Message-ID: <CAMuHMdUGsVKzye7rVzmHMvmskL+tnE5kDnctfmiHnmHX88bh4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On Fri, Sep 16, 2016 at 9:42 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Marek (internally), Geert and Alban reported errors like:
>         genirq: Setting trigger mode 0 for irq 16 failed (gic_set_type+0x0/0x68)

I didn't report these on Exynos, though, so I think you should drop my
Reported-by.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
