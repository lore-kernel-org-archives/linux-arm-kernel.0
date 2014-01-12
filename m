From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 12 Jan 2014 13:55:19 +0100
Subject: [PATCH 0/9] Renesas RSPI/QSPI DT support
In-Reply-To: <1389525222-3482-1-git-send-email-geert@linux-m68k.org>
References: <1389525222-3482-1-git-send-email-geert@linux-m68k.org>
Message-ID: <CAMuHMdWmFa-XsderYDp4jMw6r7fnwpm5XgQGfz8gEbCryXEkHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 12, 2014 at 12:13 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>     [5/9] ARM: shmobile: r7s72100: Add RSPI clocks for DT
>     [6/9][V3] ARM: shmobile: r7s72100 dtsi: Add RSPI nodes
>     [7/9][V3] ARM: shmobile: genmai reference: Add RSPI nodes
>     [8/9] ARM: shmobile: r8a7791 dtsi: Add QSPI node
>     [9/9] ARM: shmobile: koelsch: Add QSPI nodes

Forgot to mention:

The ARM/shmobile part is based on renesas-devel-v3.13-rc7-20140109v2, with
Magnus' pinctrl, Wolfram's riic, Simon's sh_eth, Valentine's i2c pinctrl
and Laurent's SCIF DT work applied on top.
[Simon: I don't know in which order you will merge these. If you want me
 to rebase my patches, just ask! Thanks!]

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
