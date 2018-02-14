From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 14 Feb 2018 10:14:56 +0100
Subject: [PATCH] ARM: shmobile: stout: enable R-Car Gen2 regulator quirk
In-Reply-To: <20180213232812.31408-1-marek.vasut+renesas@gmail.com>
References: <20180213232812.31408-1-marek.vasut+renesas@gmail.com>
Message-ID: <CAMuHMdX625D9+U1r_OnQyhwrtMBz-kdc-xtoLMtjv+Gk84p+zQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Wed, Feb 14, 2018 at 12:28 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Regulator setup is suboptimal on H2 Stout too.

Worse, Stout has 2 DA9210 regulators, so you have to add a check for a
DA9210 at address 0x70.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
