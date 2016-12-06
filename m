From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 6 Dec 2016 13:41:41 +0100
Subject: [PATCH v2 0/5] ARM: shmobile: R-Car Gen2: Allow booting secondary
 CPU cores in debug mode
In-Reply-To: <20161206123854.GA10942@verge.net.au>
References: <1480934381-32126-1-git-send-email-geert+renesas@glider.be>
 <20161206123854.GA10942@verge.net.au>
Message-ID: <CAMuHMdUTDqFz_5JuGHEC5ZF+j95puaPDJ+A8yVmu9dgNLGXhJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Tue, Dec 6, 2016 at 1:39 PM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, Dec 05, 2016 at 11:39:36AM +0100, Geert Uytterhoeven wrote:
>> This patch series allows booting secondary CPU cores on R-Car Gen2 when
>> hardware debug mode is enabled. In this mode, reset requests derived

> Thanks, I have tentatively queued this up for v4.11.
>
> I have pulled in the rcar-rst dependency with the expectation ttha
> it will disappear when I rebase on v4.10-rc1 once it has been released.

Thank you very much!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
