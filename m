From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 14 Aug 2017 16:15:44 +0200
Subject: [PATCH 2/2] ARM: dts: r8a7743: Add IIC cores to dtsi
In-Reply-To: <TY1PR06MB0702EA22AFE7D8145BF623A6B7880@TY1PR06MB0702.apcprd06.prod.outlook.com>
References: <1502196418-31341-1-git-send-email-biju.das@bp.renesas.com>
 <12d923ba-184c-ef59-f27b-41a7592a5f93@cogentembedded.com>
 <20170810080121.GE16647@verge.net.au>
 <20170810112411.GA4380@katana>
 <TY1PR06MB0702EA22AFE7D8145BF623A6B7880@TY1PR06MB0702.apcprd06.prod.outlook.com>
Message-ID: <CAMuHMdXX0BRvWOc4iosiYNWuA4tP2BpLF5kndNrDL4FeKctgkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 10, 2017 at 3:49 PM, Chris Paterson
<Chris.Paterson2@renesas.com> wrote:
>> From: Wolfram Sang [mailto:wsa at the-dreams.de]
>> Sent: 10 August 2017 12:24
>>
>>
>> > > >+                i2c6: i2c at e60b0000 {
>> > >
>> > >    I'd use iic0 as the label.

Sergei: I assume you meant "iic3"? ;-)

>> >
>> > I have no preference here other than that we try to be consistent in
>> > DT for different R-Car SoCs. Wolfram, do you have an opinion on this?
>>
>> Back then, for M2-W, I decided to go with the schematics/datasheets.
>> And those mentioned i2c6 rather than iic0. For that reason, the comment
>
> The M2 schematics still use i2c6, and for consistency I'd vote to use the same with RZ/G1M.
>
>>
>> "/* The memory map in the User's Manual maps the cores to bus numbers */"
>>
>> exists in r8a7791.dtsi. Dunno the manual of this SoC here.
>
> The manual for r8a7743 uses the same terminology as the r8a7791 manuals.

The pinctrl section does, indeed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
