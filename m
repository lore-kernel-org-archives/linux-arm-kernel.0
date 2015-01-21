From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 21 Jan 2015 11:40:30 +0100
Subject: [PATCH 11/13] Documentation: Remove ZBOOT MMC/SDHI utility and
 docs
In-Reply-To: <20150121045447.7648.23274.sendpatchset@little-apple>
References: <20150121045256.7648.7451.sendpatchset@little-apple>
 <20150121045447.7648.23274.sendpatchset@little-apple>
Message-ID: <CAMuHMdVy=28VAbiH3763UzA4qJ7qUOAJzFT7fv6GQfXq5-kLuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

On Wed, Jan 21, 2015 at 5:54 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> --- 0001/Documentation/arm/Makefile
> +++ work/Documentation/arm/Makefile     2015-01-21 11:27:40.337571523 +0900
> @@ -1 +1 @@
> -subdir-y := SH-Mobile
> +

.git/rebase-apply/patch:14: new blank line at EOF.

This file can just be removed, if you remove the "arm" from
Documentation/Makefile?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
