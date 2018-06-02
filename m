From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sat, 2 Jun 2018 11:41:43 +0200
Subject: [PATCH] clkdev: Remove duplicated negative index check from
 __of_clk_get()
In-Reply-To: <152791486506.225090.5983323218999937025@swboyd.mtv.corp.google.com>
References: <1526641120-1585-1-git-send-email-geert+renesas@glider.be>
 <152788083877.225090.16757573144833344500@swboyd.mtv.corp.google.com>
 <CAMuHMdUNXQDdv-CQs+KpaHJ8gGFjFrPRNXF3HPZNyTdQr+23Og@mail.gmail.com>
 <152791486506.225090.5983323218999937025@swboyd.mtv.corp.google.com>
Message-ID: <CAMuHMdVEGpYCjycdoYkaMjnPQ9dL33yPAm0EUoTtEZxkaup7XA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Sat, Jun 2, 2018 at 6:47 AM, Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Geert Uytterhoeven (2018-06-01 12:22:33)
>> On Fri, Jun 1, 2018 at 9:20 PM, Stephen Boyd <sboyd@kernel.org> wrote:
>> > Quoting Geert Uytterhoeven (2018-05-18 03:58:40)
>> >> __of_clk_get() calls of_parse_phandle_with_args(), which rejects
>> >> negative indices since commit bd69f73f2c81eed9 ("of: Create function for
>> >> counting number of phandles in a property").
>> >>
>> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> >> ---
>> >> Commit bd69f73f2c81eed9 is in v3.9.
>> >
>> > Did you send this to Russell's patch tracker? Otherwise I can pick it up
>>
>> Not yet. The patch tracker is for reviewed patches, AFAIK.
>>
>> > to clk-next.
>>
>> Thanks!
>>
>
> Ok. If you need my reviewed-by to add it to the tracker feel free to
> have:
>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Thanks, but it's much easier if you would take it, and I can avoid looking
up again how to submit it properly to the patch tracker.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
