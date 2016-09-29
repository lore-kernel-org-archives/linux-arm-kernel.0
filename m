From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 29 Sep 2016 08:36:48 +0200
Subject: [PATCH RFC 6/8] ARM: dts: r8a7743: add SYS-DMAC support
In-Reply-To: <be7575a5-e9a0-05a6-5b2d-803632c7edac@cogentembedded.com>
References: <3533019.Wim1Kuh1ic@wasted.cogentembedded.com>
 <1815255.1arMxK7TDL@wasted.cogentembedded.com>
 <CAMuHMdXz5K66AU7d-+NsPrAyc8V53mDxzggiUk-TrFRAwBFXOg@mail.gmail.com>
 <be7575a5-e9a0-05a6-5b2d-803632c7edac@cogentembedded.com>
Message-ID: <CAMuHMdWho3WCpoNW7H_Oa2wnMkDV_3VoRD5EwzRqbfE2bDCtgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Wed, Sep 28, 2016 at 10:09 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 09/19/2016 11:19 AM, Geert Uytterhoeven wrote:
>>> --- renesas.orig/arch/arm/boot/dts/r8a7743.dtsi
>>> +++ renesas/arch/arm/boot/dts/r8a7743.dtsi
>>> @@ -90,6 +90,70 @@
>>>                         #power-domain-cells = <1>;
>>>                 };
>>>
>>> +               dmac0: dma-controller at e6700000 {
>>> +                       compatible = "renesas,dmac-r8a7743",
>>
>>
>> To be documented.
>
>    The R-Car DMAC binding has "renesas,dmac-<soctype>" documented.
> I can add the mention of RZ/G and new examples though...

Just adding a line for RZ/G1M should be sufficient. Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
