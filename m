From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 11 Apr 2016 09:11:19 +0200
Subject: [GIT PULL] Renesas ARM Based SoC Fixes for v4.6
In-Reply-To: <cover.1460339328.git.horms+renesas@verge.net.au>
References: <cover.1460339328.git.horms+renesas@verge.net.au>
Message-ID: <CAMuHMdUwuabK2Ajo5dMWEf014Xvk-1WYz4YBTw1jVScrTKSx0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Mon, Apr 11, 2016 at 3:52 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
>
> Please consider these Renesas ARM based SoC fixes for v4.6.
>
>
> Allow serial to work once again on the Porter board (Revision B) which
> does not have the oscillator in question mounted.

Have you tested this on Porter?

I believe there's another change to be made for this revert to actually work,
cfr. "[PATCH] ARM: dts: r8a7791: Don't disable referenced optional clocks"
(https://lkml.org/lkml/2016/4/6/350)

> The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:
>
>   Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fixes-for-v4.6
>
> for you to fetch changes up to e885767418bff0c591cc1e45babdd25d91b4a795:
>
>   Revert "ARM: dts: porter: Enable SCIF_CLK frequency and pins" (2016-04-08 15:56:28 +0900)
>
> ----------------------------------------------------------------
> Renesas ARM Based SoC Fixes for v4.6
>
> * Revert "ARM: dts: porter: Enable SCIF_CLK frequency and pins"
>
> ----------------------------------------------------------------
> Sjoerd Simons (1):
>       Revert "ARM: dts: porter: Enable SCIF_CLK frequency and pins"

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
