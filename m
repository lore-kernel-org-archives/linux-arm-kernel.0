From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 22 Nov 2017 17:59:23 +0100
Subject: [PATCH 3/6] arm: dts: marvell: Add missing #phy-cells to
 usb-nop-xceiv
In-Reply-To: <CAK8P3a1x7mnpvfgsnwVJdX4OFwJZn0GpTE9ATfoLuQPB5ev=gg@mail.gmail.com>
 (Arnd Bergmann's message of "Tue, 21 Nov 2017 21:45:49 +0100")
References: <20171109222614.5719-1-robh@kernel.org>
 <20171109222614.5719-3-robh@kernel.org>
 <CAL_JsqJhq7TqdaS+i8yk8rRJM0hH2hyk8eybXsnR0D8QoncXZg@mail.gmail.com>
 <20171121200922.GD30040@lunn.ch>
 <CAK8P3a1x7mnpvfgsnwVJdX4OFwJZn0GpTE9ATfoLuQPB5ev=gg@mail.gmail.com>
Message-ID: <87po8az1uc.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,
 
 On mar., nov. 21 2017, Arnd Bergmann <arnd@arndb.de> wrote:

> On Tue, Nov 21, 2017 at 9:09 PM, Andrew Lunn <andrew@lunn.ch> wrote:
>> On Tue, Nov 21, 2017 at 12:29:48PM -0600, Rob Herring wrote:
>>> On Thu, Nov 9, 2017 at 4:26 PM, Rob Herring <robh@kernel.org> wrote:
>>> > "usb-nop-xceiv" is using the phy binding, but is missing #phy-cells
>>> > property. This is probably because the binding was the precursor to the phy
>>> > binding.
>>> >
>>> > Fixes the following warning in Marvell dts files:
>>> >
>>> > Warning (phys_property): Missing property '#phy-cells' in node ...
>>> >
>>> > Signed-off-by: Rob Herring <robh@kernel.org>
>>> > Cc: Jason Cooper <jason@lakedaemon.net>
>>> > Cc: Andrew Lunn <andrew@lunn.ch>
>>> > Cc: Gregory Clement <gregory.clement@free-electrons.com>
>>> > Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>>> > ---
>>> > Please apply to Marvell tree.
>>>
>>> Ping.
>>>
>>> Arnd, can you apply if you'd like the warnings fixed and Marvell
>>> maintainers don't respond.
>>
>> Hi Rob
>>
>> Patches submitted a week before the merge window opens are generally
>> deferred to the next cycle. I expect that once -rc1 is out, Gregory
>> will pick up this patch.
>
> These are real bugfixes, I want them in 4.15, since we now get a
> loud warning for them. I'd rather not shut up that warning because
> it's not a false-positive.

As pointed by Andrew, I planned to take them once the 4.15-rc1 would be
released. It was not obvious for me that it was real fixes. Actually I
would have expected to have first the dts fixed in a release and then
the warning enabled.

I am fine if you take this patch, especially if it is merged in
4.15-rc1.

So for this patch:

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

Gregory


>
>        Arnd

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
