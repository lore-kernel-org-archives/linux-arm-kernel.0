From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 19 Aug 2014 09:29:01 +0200
Subject: [PATCH v2 1/5] ARM: shmobile: r8a7740: Add CMT1 device to DT
In-Reply-To: <CANqRtoTBJOZEFoOg+YmfyovCGDTa43Qs77OW-qd9YQLFq3tQ3A@mail.gmail.com>
References: <1407801882-2561-1-git-send-email-horms+renesas@verge.net.au>
 <1407801882-2561-2-git-send-email-horms+renesas@verge.net.au>
 <CANqRtoTBJOZEFoOg+YmfyovCGDTa43Qs77OW-qd9YQLFq3tQ3A@mail.gmail.com>
Message-ID: <CAMuHMdXTa8dG0L2xLNELn3R310PJc+HotHwJZsaqPzuWQRJf5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 19, 2014 at 8:39 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>>  arch/arm/boot/dts/r8a7740.dtsi | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
>> index 6cd6a46..1067a96 100644
>> --- a/arch/arm/boot/dts/r8a7740.dtsi
>> +++ b/arch/arm/boot/dts/r8a7740.dtsi
>> @@ -41,6 +41,18 @@
>>                 interrupts = <0 83 IRQ_TYPE_LEVEL_HIGH>;
>>         };
>>
>> +       cmt1: timer at e6138000 {
>> +               compatible = "renesas,cmt-48";
>
> Do we want to have the "r8a7740" in the compatible string somewhere?

Documentation/devicetree/bindings/timer/renesas,cmt.txt does not
mention compatible properties containing SoC names.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
