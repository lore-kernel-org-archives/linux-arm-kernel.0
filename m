From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 21 Jun 2016 09:11:35 +0200
Subject: [PATCH v4 13/13] ARM: dts: r8a7793: Add APMU node and second CPU
 core
In-Reply-To: <d862ed53-b57b-47b7-f783-bbeceb6eae3e@cogentembedded.com>
References: <1466072862-28030-1-git-send-email-geert+renesas@glider.be>
 <1466072862-28030-14-git-send-email-geert+renesas@glider.be>
 <d862ed53-b57b-47b7-f783-bbeceb6eae3e@cogentembedded.com>
Message-ID: <CAMuHMdVJD0rFJLPFUeUk=8giXw+OkgMb=Ko5r++MCJd6mcuqtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Mon, Jun 20, 2016 at 11:05 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
>> diff --git a/arch/arm/boot/dts/r8a7793.dtsi
>> b/arch/arm/boot/dts/r8a7793.dtsi
>> index 9b55c1c6ee31a49d..fce310c54efa88eb 100644
>> --- a/arch/arm/boot/dts/r8a7793.dtsi
>> +++ b/arch/arm/boot/dts/r8a7793.dtsi
>
> [...]
>>
>> @@ -56,6 +57,13 @@
>>                         next-level-cache = <&L2_CA15>;
>>                 };
>>
>> +               cpu1: cpu at 1 {
>> +                       device_type = "cpu";
>> +                       compatible = "arm,cortex-a15";
>> +                       reg = <1>;
>> +                       clock-frequency = <1500000000>;
>
>    Why no "power-domains??

Because the original patch predates that, and I forgot to update it...

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
