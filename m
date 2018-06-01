From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 1 Jun 2018 21:22:33 +0200
Subject: [PATCH] clkdev: Remove duplicated negative index check from
 __of_clk_get()
In-Reply-To: <152788083877.225090.16757573144833344500@swboyd.mtv.corp.google.com>
References: <1526641120-1585-1-git-send-email-geert+renesas@glider.be>
 <152788083877.225090.16757573144833344500@swboyd.mtv.corp.google.com>
Message-ID: <CAMuHMdUNXQDdv-CQs+KpaHJ8gGFjFrPRNXF3HPZNyTdQr+23Og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Fri, Jun 1, 2018 at 9:20 PM, Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Geert Uytterhoeven (2018-05-18 03:58:40)
>> __of_clk_get() calls of_parse_phandle_with_args(), which rejects
>> negative indices since commit bd69f73f2c81eed9 ("of: Create function for
>> counting number of phandles in a property").
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> Commit bd69f73f2c81eed9 is in v3.9.
>
> Did you send this to Russell's patch tracker? Otherwise I can pick it up

Not yet. The patch tracker is for reviewed patches, AFAIK.

> to clk-next.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
