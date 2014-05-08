From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 8 May 2014 12:12:29 +0200
Subject: [PATCH v4] drivers: sh: compile drivers/sh/pm_runtime.c if
 ARCH_SHMOBILE_MULTI
In-Reply-To: <1399411579-10681-1-git-send-email-geert+renesas@glider.be>
References: <1399411579-10681-1-git-send-email-geert+renesas@glider.be>
Message-ID: <CAMuHMdWwenyU1RS4c8spFcb7M0oCXP9z8zbGQ0VACKj7EbvvkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 6, 2014 at 11:26 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Tested on Koelsch (legacy, reference, shmobile, and shmobile+bbb kernels)
> and BeagleBone Black (shmobile+bbb). Will test on more hardware tomorrow.

Tested on genmai with Wolfram's CCF support.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
