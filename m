From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 20 Jul 2016 16:57:05 +0300
Subject: [PATCH 2/2] ARM: dts: r8a7792: add SDHI support
In-Reply-To: <CAMuHMdXez5KZMH=3=egqWWP9Dp9gSRKw=kqHBMPnNjwwAv=Jdg@mail.gmail.com>
References: <2441635.ESeLhIjWEX@wasted.cogentembedded.com>
 <8030361.FnpbGzHVP8@wasted.cogentembedded.com>
 <20160717225842.GA25133@verge.net.au>
 <cece2545-52f9-7ddb-36d2-df364a272092@cogentembedded.com>
 <CAMuHMdUUZ=gopWOir9PMiDgJ8o+CMp+qG=FLhGg_gHrMYzwgFg@mail.gmail.com>
 <e6246060-fa54-37c1-949d-b93da109dbb9@cogentembedded.com>
 <CAMuHMdXez5KZMH=3=egqWWP9Dp9gSRKw=kqHBMPnNjwwAv=Jdg@mail.gmail.com>
Message-ID: <772f56cd-15ad-e4d6-69c1-e96da2c50300@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/20/2016 04:50 PM, Geert Uytterhoeven wrote:

>>> BTW, given SDHI on V2H doesn't support SDR50/SDR104, unlike the instances
>>> on other R-Car Gen2 SoCs, can you please tell us the version value, as
>>> read
>>> from CTL_VERSION in sh_mobile_sdhi_sdbuf_width()?
>>
>>    It's 0xCB0D, the same as on other SoCs.
>
> Thanks!
>
> #define SDHI_VER_GEN2_SDR104    0xcb0d

    Not seeing this #define, where is it?

> Not good, as it doesn't support SDR50/SDR104....

    Does it have the register at 0x324 tho?

> Gr{oetje,eeting}s,
>
>                         Geert

MBR, Sergei
