From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 14 May 2014 12:26:38 +0200
Subject: [PATCH v5 01/11] ARM: shmobile: r7s72100: document MSTP clock
 support
In-Reply-To: <20140513000513.5943.68810@quantum>
References: <1398765822-2314-1-git-send-email-wsa@the-dreams.de>
 <1398765822-2314-2-git-send-email-wsa@the-dreams.de>
 <20140513000513.5943.68810@quantum>
Message-ID: <CAMuHMdWK1WAePx3N_ybPkWcoTtP_6PdcEPNEyBv02A9zOZSWOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Stephen,

On Tue, May 13, 2014 at 2:05 AM, Mike Turquette <mturquette@linaro.org> wrote:
> Quoting Wolfram Sang (2014-04-29 03:03:32)
>> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>>
>> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> Acked-by: Mike Turquette <mturquette@linaro.org>
>
> No need to take this through the clk tree. Feel free to send it with the
> rest through arm-soc.

(merging in clk/clk-next)

Note that this will cause a conflict for you, as Mike applied commit
5483bf698f42a6f0467463b064084eb888298232 ("clk: shmobile: r8a7779:
Add MSTP clock support"), which adds a line at the exact same spot.

Resolution: both lines should be kept.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
