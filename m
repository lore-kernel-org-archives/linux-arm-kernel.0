From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 29 Dec 2014 23:34:07 +0300
Subject: [PATCH] ARM: shmobile: r8a7791: add ADSP clocks
In-Reply-To: <CAMuHMdUqC5v-d95Sk2NewSE-EBKS49vn7jPKpixF2djg6NOmVw@mail.gmail.com>
References: <1937156.Ii2YrGkOFy@wasted.cogentembedded.com>
 <CAMuHMdUqC5v-d95Sk2NewSE-EBKS49vn7jPKpixF2djg6NOmVw@mail.gmail.com>
Message-ID: <54A1BABF.5070208@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 12/29/2014 11:24 PM, Geert Uytterhoeven wrote:

>> --- renesas.orig/include/dt-bindings/clock/r8a7791-clock.h
>> +++ renesas/include/dt-bindings/clock/r8a7791-clock.h

>> -#define R8A7791_CLK_RCAN               9
>> +#define R8A7791_CLK_ADSP               9
>> +#define R8A7791_CLK_RCAN               10

> R8A7791_CLK_RCAN is changed?

    Yes. It shouldn't be?

> Gr{oetje,eeting}s,
>                          Geert

WBR, Sergei
