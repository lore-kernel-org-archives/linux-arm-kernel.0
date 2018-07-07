From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Sat, 7 Jul 2018 13:28:01 +0200
Subject: [PATCH] dma: stm32: replace "%p" with "%pK"
In-Reply-To: <CAMuHMdVEOx=PLAHzGEtPmVtitsVYSc-F1TUP6DVCS=Ct7QupYw@mail.gmail.com>
References: <20180706130220.21957-1-benjamin.gaignard@st.com>
 <CAMuHMdVEOx=PLAHzGEtPmVtitsVYSc-F1TUP6DVCS=Ct7QupYw@mail.gmail.com>
Message-ID: <CA+M3ks7URGgxKfjkB9H2vi0qH-SvMZd1SfK4KZGPbF81+xJR9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-07-06 21:38 GMT+02:00 Geert Uytterhoeven <geert@linux-m68k.org>:
> Hi Benjamin,
>
> On Fri, Jul 6, 2018 at 3:03 PM Benjamin Gaignard
> <benjamin.gaignard@linaro.org> wrote:
>> The format specifier "%p" can leak kernel addresses.
>> Use "%pK" instead.
>
> Still? Isn't the value randomized these days?

%p give an hashed value, with %pK you can use a sysctl to get the real
value if you are root

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds



-- 
Benjamin Gaignard

Graphic Study Group

Linaro.org ? Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
