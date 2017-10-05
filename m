From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 5 Oct 2017 11:02:30 +0200
Subject: [PATCH 2/3] ARM: dts: gr-peach: Enable MTU2 timer pulse unit
In-Reply-To: <1507193900-23801-3-git-send-email-jacopo+renesas@jmondi.org>
References: <1507193900-23801-1-git-send-email-jacopo+renesas@jmondi.org>
 <1507193900-23801-3-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <CAMuHMdV+eXxXE-oa5mQ9h0SQg+a8hMkx+SD0HVzNhKd4sBm1cA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 5, 2017 at 10:58 AM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> MTU2 multi-function/multi-channel timer/counter is not enabled for
> GR-Peach board. The timer is used as clock event source to schedule
> wake-ups, and without this enabled all sleeps not performed through busy
> waiting hang the board.
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
