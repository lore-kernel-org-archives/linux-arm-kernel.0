From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 30 Nov 2015 09:34:10 +0100
Subject: [PATCH] ARM: shmobile: alt: Add QSPI device to DT
In-Reply-To: <1448863990-16276-1-git-send-email-horms+renesas@verge.net.au>
References: <1448863990-16276-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdWnyZbHiLEPn-6dEweBEXHzWr6o2KF2iCpzg2-OhZRVSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 30, 2015 at 7:13 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Enable the QSPI controller in the alt device tree.
>
> Based similar work for the silk board by by Vladimir Barinov and
> Sergei Shtylyov.
>
> Cc: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Verified against Alt schematics and r8a7794 datasheet.

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

I can't verify the FLASH layout. Note that p.11 of
ALT_MiniMonitor_Manual(SPI_Boot)_Rev0.01_e.pdf shows a different
FLASH layout for the second and third partition.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
