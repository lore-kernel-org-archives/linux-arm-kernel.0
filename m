From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 22 Aug 2016 10:10:23 +0200
Subject: [PATCH] ARM: dts: blanche: add DU support
In-Reply-To: <20160822074111.GE28034@verge.net.au>
References: <5383928.8UnDsUpmkz@wasted.cogentembedded.com>
 <1783132.r9t2y3QUUq@wasted.cogentembedded.com>
 <20160822074111.GE28034@verge.net.au>
Message-ID: <CAMuHMdXVw9SuagmZTD0nZOv-AC3ruWazfBbG5=cRrdHKQYcqgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Mon, Aug 22, 2016 at 9:41 AM, Simon Horman <horms@verge.net.au> wrote:
> On Fri, Aug 19, 2016 at 11:42:54PM +0300, Sergei Shtylyov wrote:
>> Index: renesas/arch/arm/boot/dts/r8a7792-blanche.dts
>> ===================================================================
>> --- renesas.orig/arch/arm/boot/dts/r8a7792-blanche.dts
>> +++ renesas/arch/arm/boot/dts/r8a7792-blanche.dts
>
> ...
>
>> @@ -186,3 +251,63 @@
>>       cd-gpios = <&gpio11 11 GPIO_ACTIVE_LOW>;
>>       status = "okay";
>>  };
>> +
>> +&i2c1 {
>> +     status = "okay";
>> +     clock-frequency = <400000>;
>
> Is it intentional that there are no pinctrl properties here?

$ git grep -w I2C arch/arm/boot/dts/r8a7792.dtsi
arch/arm/boot/dts/r8a7792.dtsi:         /* I2C doesn't need pinmux */
$

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
