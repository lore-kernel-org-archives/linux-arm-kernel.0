From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 20 Jul 2016 15:50:20 +0200
Subject: [PATCH 2/2] ARM: dts: r8a7792: add SDHI support
In-Reply-To: <e6246060-fa54-37c1-949d-b93da109dbb9@cogentembedded.com>
References: <2441635.ESeLhIjWEX@wasted.cogentembedded.com>
 <8030361.FnpbGzHVP8@wasted.cogentembedded.com>
 <20160717225842.GA25133@verge.net.au>
 <cece2545-52f9-7ddb-36d2-df364a272092@cogentembedded.com>
 <CAMuHMdUUZ=gopWOir9PMiDgJ8o+CMp+qG=FLhGg_gHrMYzwgFg@mail.gmail.com>
 <e6246060-fa54-37c1-949d-b93da109dbb9@cogentembedded.com>
Message-ID: <CAMuHMdXez5KZMH=3=egqWWP9Dp9gSRKw=kqHBMPnNjwwAv=Jdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Wed, Jul 20, 2016 at 3:40 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
>> BTW, given SDHI on V2H doesn't support SDR50/SDR104, unlike the instances
>> on other R-Car Gen2 SoCs, can you please tell us the version value, as
>> read
>> from CTL_VERSION in sh_mobile_sdhi_sdbuf_width()?
>
>    It's 0xCB0D, the same as on other SoCs.

Thanks!

#define SDHI_VER_GEN2_SDR104    0xcb0d

Not good, as it doesn't support SDR50/SDR104....

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
