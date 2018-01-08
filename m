From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 08 Jan 2018 16:27:41 +0100
Subject: [PATCH 1/7] arm64: dts: marvell: use SPDX-License-Identifier for
 Armada SoCs
In-Reply-To: <20180105153020.GF4038@lunn.ch> (Andrew Lunn's message of "Fri, 5
 Jan 2018 16:30:20 +0100")
References: <20180105115329.1233-1-gregory.clement@free-electrons.com>
 <20180105115329.1233-2-gregory.clement@free-electrons.com>
 <20180105134046.12915b36@windsurf.lan>
 <87vagga2nd.fsf@free-electrons.com> <20180105143820.GB4038@lunn.ch>
 <87r2r49wxw.fsf@free-electrons.com> <20180105153020.GF4038@lunn.ch>
Message-ID: <87o9m48j6a.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,
 
 On ven., janv. 05 2018, Andrew Lunn <andrew@lunn.ch> wrote:

> On Fri, Jan 05, 2018 at 03:55:55PM +0100, Gregory CLEMENT wrote:
>> Hi Andrew,
>>  
>>  On ven., janv. 05 2018, Andrew Lunn <andrew@lunn.ch> wrote:
>> 
>> >> > The previous license was GPL-2.0+ or X11, not GPL-2.0+ or MIT. Any
>> >> > reason to change from X11 to MIT ?
>> >> 
>> >> As explained in the commit log:
>> >> " the X11 license text [1] is explicitly for the X Consortium and has a
>> >> couple of extra clauses. The MIT license text [2] is actually what the
>> >> current DT files claim."
>> >> 
>> >> Also as I wrote it was already discussed on the mainling lists (device
>> >> tree one and LAKML) see:
>> >> http://lists.infradead.org/pipermail/linux-arm-kernel/2017-February/489922.html
>> >
>> > Hi Gregory
>> >
>> > If i remember correctly, there was a reason for X11 over MIT. I think
>> > Russell King looked into this. Maybe you can find the discussion on
>> > the mailing list?
>
> Hi Gregory
>
> I'm meaning an older discussion, when we first started using dual
> license. There was some discussion back then as to MIT vs X11.
> That discussion could be relevant here.

It was what I have looked for initially. But I didn't find it. I wonder
if the question was first discussed at a conference.

> What we need to be careful of is ensuring the changes you are making
> here don't actually change the licenses.  If the intent was to use
> X11, and we actually state "X11 license" in the source code, we need
> to be careful if we replace that with MIT.

I think that it the content of the text of the license show more the
intent that the title. Moreover, by using the MIT keyword on SPDX we
really have the exactly same content.

Oh and finally I found the thread:
https://www.spinics.net/lists/arm-kernel/msg358704.html

So even there the X11 license was referred as a MIT X11 license, and,
really, I don't think at any moment we intend to mention the X
Consortium for the device tree files. It was just the name "MIT license"
which was considered as ambiguous.

Gregory

>
>    Andrew

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
