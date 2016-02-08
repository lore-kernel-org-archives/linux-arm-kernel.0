From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 8 Feb 2016 16:32:06 +0100
Subject: [PATCH v2] clk: shmobile: r8a7795: Add SD divider support
In-Reply-To: <20160204193036.GA1958@tetsubishi>
References: <1454135639-4102-1-git-send-email-dirk.behme@gmail.com>
 <20160204193036.GA1958@tetsubishi>
Message-ID: <CAMuHMdW3Cp-Ga9NCb=TgGE7QxUTNp-PbOXsNu47Vvgcf-m0bSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 4, 2016 at 8:30 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Sat, Jan 30, 2016 at 07:33:59AM +0100, Dirk Behme wrote:
>> This patch adds SD[0..3] clock divider support for R-Car Gen3 SoC.
>>
>> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> Since we don't have UHS support currently, changing the clock is not
> really exercised; but the code looks good and if it needs fixing, we can
> do it incrementally IMO. What is currently needed works fine on my
> Salvator-X for the exposed SD interfaces.

Thanks, will queue for next renesas-drivers and v4.6.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
