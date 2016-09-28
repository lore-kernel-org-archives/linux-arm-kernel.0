From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 28 Sep 2016 23:09:40 +0300
Subject: [PATCH RFC 6/8] ARM: dts: r8a7743: add SYS-DMAC support
In-Reply-To: <CAMuHMdXz5K66AU7d-+NsPrAyc8V53mDxzggiUk-TrFRAwBFXOg@mail.gmail.com>
References: <3533019.Wim1Kuh1ic@wasted.cogentembedded.com>
 <1815255.1arMxK7TDL@wasted.cogentembedded.com>
 <CAMuHMdXz5K66AU7d-+NsPrAyc8V53mDxzggiUk-TrFRAwBFXOg@mail.gmail.com>
Message-ID: <be7575a5-e9a0-05a6-5b2d-803632c7edac@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/19/2016 11:19 AM, Geert Uytterhoeven wrote:

>> --- renesas.orig/arch/arm/boot/dts/r8a7743.dtsi
>> +++ renesas/arch/arm/boot/dts/r8a7743.dtsi
>> @@ -90,6 +90,70 @@
>>                         #power-domain-cells = <1>;
>>                 };
>>
>> +               dmac0: dma-controller at e6700000 {
>> +                       compatible = "renesas,dmac-r8a7743",
>
> To be documented.

    The R-Car DMAC binding has "renesas,dmac-<soctype>" documented.
I can add the mention of RZ/G and new examples though...

> Gr{oetje,eeting}s,
>
>                         Geert

MBR, Sergei
