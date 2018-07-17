From: cphealy@gmail.com (Chris Healy)
Date: Tue, 17 Jul 2018 08:22:14 -0700
Subject: [PATCH] ARM: dts: vf610: Add ZII SSMB SPU3 board
In-Reply-To: <20180717152035.GD16320@lunn.ch>
References: <20180717040651.641-1-andrew.smirnov@gmail.com>
 <20180717144638.GB16320@lunn.ch>
 <CAFXsbZpKyLjp0bO7MVR5StKf=3UkXUANydhM+8_13G3itRmE+Q@mail.gmail.com>
 <20180717152035.GD16320@lunn.ch>
Message-ID: <CAFXsbZpS0zs3nihDuaMZaNEwYDyhQQeo_5gz5W-frv0QJFZKPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2018 at 8:20 AM, Andrew Lunn <andrew@lunn.ch> wrote:
>> >> +++ b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
>> >> @@ -0,0 +1,343 @@
>> >> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>> >> +
>> >> +/*
>> >> + * Device tree file for ZII's SSMB SPU3 board
>> >> + *
>> >> + * SSMB - SPU3 Switch Management Board
>> >> + * SPU - Seat Power Unit
>> >
>> > I think this is the first Zodiac board with mutually recursive
>> > acronyms.
>> >
>> > Probably a question for Chris: Does SSMB specifically refer to version
>> > 3 of the SPU?
>> >
>> >    Andrew
>>
>> SPU3 is the third generation of seat power unit.
>> SSMB is the SPU3 Switch Management Board.
>>
>> So, SSMB is a backronym.  This naming scheme breaks down a bit though
>> when follow on designs (that are not the SPU3) also use the SSMB, but
>> that's what it is... ;-)
>
> O.K, i was just wondering if the 3 was in the wrong place. More
> logically, it would be
>
> * SSMB - SPU Switch Management Board
> * SPU 3 - Seat Power Unit, version 3.
>
> But you are saying the Marketing guys messed up the naming and
> engineering is now stuck with it.
>
Yep
