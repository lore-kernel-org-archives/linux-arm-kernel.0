From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 23 Nov 2017 10:49:13 +0100
Subject: [PATCH] arm64: dts: renesas: r8a7795: Move nodes which have no
 reg property out of bus
In-Reply-To: <20171123094657.r2wjbmvrn24ohrn6@verge.net.au>
References: <20171120110125.12267-1-horms+renesas@verge.net.au>
 <CAMuHMdXqPqhiCZFseBGFDEh9R+_kFcrmjWWgCSudtnHkuXoFgw@mail.gmail.com>
 <20171123094657.r2wjbmvrn24ohrn6@verge.net.au>
Message-ID: <CAMuHMdX4voo+HOx69Wj7B+kDwyqb8KNSQVwWnUcCqLR_27aBiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Thu, Nov 23, 2017 at 10:46 AM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Nov 23, 2017 at 10:27:55AM +0100, Geert Uytterhoeven wrote:
>> On Mon, Nov 20, 2017 at 12:01 PM, Simon Horman
>> <horms+renesas@verge.net.au> wrote:
>> > --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>> > +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>> > @@ -126,6 +126,86 @@
>>
>> The node above is called "cpus".
>>
>> >                 };
>> >         };
>> >
>> > +       pmu_a57 {
>>
>> > +       };
>> > +
>> > +       pmu_a53 {
>>
>> > +       };
>> > +
>> > +       timer {
>>
>> > +       };
>> > +
>> > +       thermal-zones {
>>
>> > +       };
>> > +
>> >         extal_clk: extal {
>> >                 compatible = "fixed-clock";
>> >                 #clock-cells = <0>;
>>
>> Any sorting rules (alphabetically?) for nodes at the root level?
>
> Now would be a good time to decide on an alternate on an order as
> I plan to submit similar patches for several other SoCs.
>
> I took used order they were already present (with other nodes) in the
> cpu node. They appear to be sorted alphabetically. Should I keep that
> sort order relative to existing nodes present in the root node?

I think you should.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
