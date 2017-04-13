From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 13 Apr 2017 21:47:19 +0200
Subject: [PATCH RFC 0/5] *** SPI Slave mode support ***
In-Reply-To: <20170413125929.dygodgj6c35ydh5p@sirena.org.uk>
References: <1492085644-4195-1-git-send-email-jiada_wang@mentor.com>
 <20170413125929.dygodgj6c35ydh5p@sirena.org.uk>
Message-ID: <CAMuHMdUm=90ddNWM5KWqT+W0hqZ-QO6vPHj5OisbYquDYq1ZmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 13, 2017 at 2:59 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Apr 13, 2017 at 05:13:59AM -0700, jiada_wang at mentor.com wrote:
>> From: Jiada Wang <jiada_wang@mentor.com>
>>
>> v1:
>>   add Slave mode support in SPI core
>>   spidev create slave device when SPI controller work in slave mode
>>   spi-imx support to work in slave mode
>
> Adding Geert who also had a series doing this in progress that was
> getting very near to being merged.

Thank you!

Actually my plan is to fix the last remaining issues and resubmit for v4.13.

References:
  - v2: https://lkml.org/lkml/2016/9/12/1065
  - v1: https://lkml.org/lkml/2016/6/22/423

BTW Jiada, what's your use case? Just spidev?

Thx!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
