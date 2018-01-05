From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 05 Jan 2018 15:55:55 +0100
Subject: [PATCH 1/7] arm64: dts: marvell: use SPDX-License-Identifier for
 Armada SoCs
In-Reply-To: <20180105143820.GB4038@lunn.ch> (Andrew Lunn's message of "Fri, 5
 Jan 2018 15:38:20 +0100")
References: <20180105115329.1233-1-gregory.clement@free-electrons.com>
 <20180105115329.1233-2-gregory.clement@free-electrons.com>
 <20180105134046.12915b36@windsurf.lan>
 <87vagga2nd.fsf@free-electrons.com> <20180105143820.GB4038@lunn.ch>
Message-ID: <87r2r49wxw.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,
 
 On ven., janv. 05 2018, Andrew Lunn <andrew@lunn.ch> wrote:

>> > The previous license was GPL-2.0+ or X11, not GPL-2.0+ or MIT. Any
>> > reason to change from X11 to MIT ?
>> 
>> As explained in the commit log:
>> " the X11 license text [1] is explicitly for the X Consortium and has a
>> couple of extra clauses. The MIT license text [2] is actually what the
>> current DT files claim."
>> 
>> Also as I wrote it was already discussed on the mainling lists (device
>> tree one and LAKML) see:
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2017-February/489922.html
>
> Hi Gregory
>
> If i remember correctly, there was a reason for X11 over MIT. I think
> Russell King looked into this. Maybe you can find the discussion on
> the mailing list?

The point from Russell King was that "MIT license" was ambiguous. But
the text of the license we used was exactly the one named as MIT in
SPDX. That's the reason why using the MIT key word for SPDX would be the
wright things to do.

Note also that Here [1], Russell already gave his opinion about it. In
the thread the complain was more about the spdx itself that the
name of the license. And his main concerned was about not having the
license text available. But it should be resolved because all the
license text will be part of the kernel sources [2].

Thanks,

Gregory

[1]:
http://lists.infradead.org/pipermail/linux-arm-kernel/2017-February/490649.html
[2]:
https://lkml.org/lkml/2017/12/4/935

>
>     Andrew
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
