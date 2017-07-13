From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 13 Jul 2017 18:31:33 +0200
Subject: [PATCH v2] ARM: dts: iwg20m: Add MMCIF0 support
In-Reply-To: <1499960340-25310-1-git-send-email-chris.paterson2@renesas.com>
References: <1499853805-5915-4-git-send-email-chris.paterson2@renesas.com>
 <1499960340-25310-1-git-send-email-chris.paterson2@renesas.com>
Message-ID: <CAMuHMdV2f1oyi9dNGdGmqx7x7RNk10jomKQ4jHJ9wXNSEBKtNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 13, 2017 at 5:39 PM, Chris Paterson
<chris.paterson2@renesas.com> wrote:
> Define the iwg20m board dependent part of the MMCIF0 device node.
>
> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> v1->v2:
>  - Corrected data pin group to mmc_data8_b - Thanks Geert.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
