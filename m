From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 6 Jul 2015 12:49:50 +0200
Subject: [PATCH] ARM: shmobile: kzm9g dts: Add adxl345-specific compatible
 property
In-Reply-To: <1980362.9qv8Mc7ut7@avalon>
References: <1436176746-10995-1-git-send-email-geert+renesas@glider.be>
 <1980362.9qv8Mc7ut7@avalon>
Message-ID: <CAMuHMdWhSj5HZ+KYBkWbMpvUzFJGHS5-k8exhrxyCsAB+DJL3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 6, 2015 at 12:17 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> --- a/arch/arm/boot/dts/sh73a0-kzm9g.dts
>> +++ b/arch/arm/boot/dts/sh73a0-kzm9g.dts
>> @@ -206,7 +206,7 @@
>>       };
>>
>>       accelerometer at 1d {
>> -             compatible = "adi,adxl34x";
>> +             compatible = "adi,adxl345", "adi,adxl34x";
>
> "adi,adxl34x" is deprecated and shouldn't be used in DT. You can just specify
> "adi,adxl345".

Right, we only care (sometimes ;-) about backward-compatibility,
not about forward-compatibility.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
