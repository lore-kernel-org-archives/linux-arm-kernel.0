From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 15 Nov 2017 17:21:07 +0100
Subject: [PATCH 3/3] arm64: dts: renesas: eagle: add EtherAVB pins
In-Reply-To: <1017d8fb-e353-f212-09a9-a28bf07eddc2@cogentembedded.com>
References: <20171110200714.406365231@cogentembedded.com>
 <CAMuHMdWCj=CjA_zyC1GKr=KEk2CNMAtwvREw25R1uJktZucY4w@mail.gmail.com>
 <1017d8fb-e353-f212-09a9-a28bf07eddc2@cogentembedded.com>
Message-ID: <CAMuHMdX8j__iF5xP33Na9pVM1nRWvrE7e68-zg0oE0gE5MOHXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Tue, Nov 14, 2017 at 7:00 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 11/14/2017 11:44 AM, Geert Uytterhoeven wrote:
>>> Add the (previously omitted) EtherAVB pin data to the Eagle board's
>>> device tree.

>>> --- renesas.orig/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
>>> +++ renesas/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
>>> @@ -34,6 +34,9 @@
>
> [...]
>>>
>>> @@ -53,6 +56,11 @@
>>>   };
>>>
>>>   &pfc {
>>> +       avb_pins: avb {
>>> +               groups = "avb0_mdio", "avb0_mii";
>>
>>
>> Oh no, its'called "avb0_mdio" here, but "avb(0)_mdc" on all other
>> R-Car Gen3 SoCs?
>
>
>    Can you remember the reason? I don;t want to follow the bad example. :-)

Sorry, I don't know.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
