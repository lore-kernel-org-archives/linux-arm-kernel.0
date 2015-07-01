From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 1 Jul 2015 09:10:23 +0200
Subject: [RFC 3/3] ARM: shmobile: r8a7790: rework dts to use i2c demuxer
In-Reply-To: <1435700651-3543-4-git-send-email-wsa@the-dreams.de>
References: <1435700651-3543-1-git-send-email-wsa@the-dreams.de>
 <1435700651-3543-4-git-send-email-wsa@the-dreams.de>
Message-ID: <CAMuHMdXTnY_gg+VWcSxUZWnD6yrL9xxCSoJYQVCh4Dj7Lxr8Qg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 30, 2015 at 11:44 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> --- a/arch/arm/boot/dts/r8a7790-lager.dts
> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> @@ -49,6 +49,8 @@
>         aliases {
>                 serial0 = &scifa0;
>                 serial1 = &scifa1;
> +               i2c8 = &i2chdmi;
> +               i2c9 = &gpioi2c;

"i2c<suffix>" or "<prefix>i2c"?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
