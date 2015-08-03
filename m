From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 3 Aug 2015 17:19:21 +0200
Subject: [PATCH v3] ARM: shmobile: silk: initial device tree
In-Reply-To: <55BF8522.1010906@cogentembedded.com>
References: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
 <2360526.88foRQAOiM@wasted.cogentembedded.com>
 <CAMuHMdWT=nzsFuM-vfe5GoAtDE-AtW4LAZoEnBGGVZm54-mAzg@mail.gmail.com>
 <55BF8522.1010906@cogentembedded.com>
Message-ID: <CAMuHMdVRKjO9iQfhQYJUb9rBKCX3TS+_Vq_SWr0YoY7ov2BCLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Mon, Aug 3, 2015 at 5:13 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 08/03/2015 04:00 PM, Geert Uytterhoeven wrote:
>>> --- /dev/null
>>> +++ renesas/arch/arm/boot/dts/r8a7794-silk.dts
>>> @@ -0,0 +1,51 @@
>
>>> +/ {
>>> +       model = "SILK";
>>> +       compatible = "renesas,silk", "renesas,r8a7794";
>
>> WARNING: DT compatible string "renesas,silk" appears un-documented --
>> check ./Documentation/devicetree/bindings/
>
>> Do you plan to update Documentation/devicetree/bindings/arm/shmobile.txt?
>
>    No, I had no idea I should record the board names somewhere too...

All "compatible" values should be documented before being used in a
.dts(i) file.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
